Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWIACDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWIACDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 22:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWIACDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 22:03:13 -0400
Received: from ns.suse.de ([195.135.220.2]:26057 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750776AbWIACDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 22:03:11 -0400
From: Neil Brown <neilb@suse.de>
To: linux-kernel@vger.kernel.org
Date: Fri, 1 Sep 2006 12:02:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17655.38092.888976.846697@cse.unsw.edu.au>
Subject: RFC - sysctl or module parameters.
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are so many ways to feed configuration parameters into the
kernel these days.  
There is sysctl.  There is sysfs. And there are module paramters.
(procfs? who said procfs? I certainly didn't).

I have a module - let's call it 'lockd'.
I want to make it configurable - say to be able to identify
 peers by IP address (as it currently does) or host name
 (good for multi homed peers, if you trust them).

And I want Jo Sysadmin to be able to set some simple configuration
setting somewhere and have it 'just work'.

Options:
 - I could make it a module parameter: use_hostnames, and tell
   Jo to put
     options lockd use_hostnames=yes
   in /etc/modprobe.d/lockd  if that is what (s)he wants.
   But that won't work if the module is compiled in (will it?).

 - I could make a sysctl /proc/sys/fs/nfs/nsm_use_hostnames
   at tell Jo to put
      fs.nfs.nsm_use_hostnames=1
   if /etc/sysctl.conf if desired.
   But that wouldn't work if lockd is a module that is loaded
   after "/usr/sbin/sysctl -p" has been run.

 - I could do both and tell Jo to make both changes, just in case,
   but that is rather ugly, though that is what we currently do
   for nlm_udpport, nlm_tcpport, nlm_timeout, nlm_grace_period.

It occurs to me that since we have /sys/module/X/parameters,
it wouldn't be too hard to have some functionality, possibly
in modprobe, that looked for all the 'options' lines in
modprobe config files, checked to see if the modules was loaded,
and then imposed those options that could be imposed.

Thus we could just have a module option, just add module config
information to /etc/modprobe.d and run
  modprobe --apply-option-to-active-modules
at the same time as "sysctl -p" and it would all 'just work'
whether the module were compiled in to not.

Is that a reasonable idea?

(I'll probably add both a sysctl and a mod param for my current
problem, but I'd love it if there were a better approach
possible in the future).

Thanks,
NeilBrown
