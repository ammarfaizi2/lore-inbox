Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWIAKKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWIAKKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 06:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWIAKKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 06:10:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42701 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751379AbWIAKKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 06:10:15 -0400
Date: Fri, 1 Sep 2006 03:10:01 -0700
From: Greg KH <greg@kroah.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - sysctl or module parameters.
Message-ID: <20060901101001.GA13912@kroah.com>
References: <17655.38092.888976.846697@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17655.38092.888976.846697@cse.unsw.edu.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 12:02:52PM +1000, Neil Brown wrote:
> 
> There are so many ways to feed configuration parameters into the
> kernel these days.  
> There is sysctl.  There is sysfs. And there are module paramters.
> (procfs? who said procfs? I certainly didn't).
> 
> I have a module - let's call it 'lockd'.
> I want to make it configurable - say to be able to identify
>  peers by IP address (as it currently does) or host name
>  (good for multi homed peers, if you trust them).
> 
> And I want Jo Sysadmin to be able to set some simple configuration
> setting somewhere and have it 'just work'.
> 
> Options:
>  - I could make it a module parameter: use_hostnames, and tell
>    Jo to put
>      options lockd use_hostnames=yes
>    in /etc/modprobe.d/lockd  if that is what (s)he wants.
>    But that won't work if the module is compiled in (will it?).

Yes it will.  See Documentation/kernel-parameters.txt for how it works.

>  - I could make a sysctl /proc/sys/fs/nfs/nsm_use_hostnames
>    at tell Jo to put
>       fs.nfs.nsm_use_hostnames=1
>    if /etc/sysctl.conf if desired.
>    But that wouldn't work if lockd is a module that is loaded
>    after "/usr/sbin/sysctl -p" has been run.
> 
>  - I could do both and tell Jo to make both changes, just in case,
>    but that is rather ugly, though that is what we currently do
>    for nlm_udpport, nlm_tcpport, nlm_timeout, nlm_grace_period.
> 
> It occurs to me that since we have /sys/module/X/parameters,
> it wouldn't be too hard to have some functionality, possibly
> in modprobe, that looked for all the 'options' lines in
> modprobe config files, checked to see if the modules was loaded,
> and then imposed those options that could be imposed.

those options _are_ module parameters, and as such work just fine with
the modprobe config files.

> Thus we could just have a module option, just add module config
> information to /etc/modprobe.d and run
>   modprobe --apply-option-to-active-modules
> at the same time as "sysctl -p" and it would all 'just work'
> whether the module were compiled in to not.

Ah, you want it after the code is loaded.  That's different.

Would probably work just fine, no objection from me.  Except you would
have to hack up the module-init-tools package :)

thanks,

greg k-h
