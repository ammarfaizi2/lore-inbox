Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWHBDmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWHBDmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWHBDmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:42:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:29326 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751107AbWHBDml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:42:41 -0400
Date: Tue, 1 Aug 2006 20:37:41 -0700
From: Greg KH <greg@kroah.com>
To: Piet Delaney <piet@bluelane.com>
Cc: linux-kernel@vger.kernel.org, piet at work <piet@work.piet.net>
Subject: Re: udev taking a long time during startup
Message-ID: <20060802033741.GA24880@kroah.com>
References: <1154416586.4332.64.camel@piet2.bluelane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154416586.4332.64.camel@piet2.bluelane.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 12:16:25AM -0700, Piet Delaney wrote:
> Hey Gang:
> 
> We were wondering why there is a 60 second delay on our systems
> from the time that the kernel releases memory and the file system 
> is checked.
> 
> I dropped into kgdb during this period and found that an init
> script, S10udev in our case, was sleeping in sys_nanosleep()
> or sys_wait4(). Looks like thread/process S10udev forks udevstart
> which forks udev which appears to be sleeping or waiting every time
> I check in on it; Seems terribly wasteful.

You don't let us know what kernel version, or what version of udev, or
even what distro you are using.  I think we need a bit more information
here :)

> udev seems to be a utility for hotplug and configured
> with /etc/udev/udev.conf. Since we have no hot plug devices
> I wonder if it really has to be called on every startup. On
> solaris the device nodes are only re-established if you boot
> with a -r option.

Yes, udev figures out what device nodes to create at boot time, it is
required if you want to use it.

thanks,

greg k-h
