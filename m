Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266035AbVBECYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbVBECYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 21:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVBECYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 21:24:31 -0500
Received: from orb.pobox.com ([207.8.226.5]:16300 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S266560AbVBECTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:19:13 -0500
Date: Fri, 4 Feb 2005 18:19:06 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Gary Smith <linuxkernel@adndrealm.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Post install 2.4.29 causes many apps to seg fault.
Message-ID: <20050205021906.GA7524@ip68-4-98-123.oc.oc.cox.net>
References: <1107544219.4203c89bdfa6a@www.adndrealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107544219.4203c89bdfa6a@www.adndrealm.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 11:10:19AM -0800, Gary Smith wrote:
> Hello, 
> 
> I have been running RHEL3 update 3 for some time and need to patch netfilter 
> for PPTP.  After doing so and installing the kernel I found that certain 
> applications (such as MySQL, nslook, etc) began to segfault.  Rolling the 
> kernel back fixed the problem.
> 
> I have since then gone back and recompiled the vanilla 2.4.29 kernel (without 
> additing any patches this time - clean from tarball) and installed it and all 
> of the the applications that failed on the custom kernel (with the PPTP 
> patches) continue to fail (clean box as well).
> 
> Is there something more that I need to compile besides the kernel for 
> compatability or is this a sign of some type of bug.  I do realize that RHEL3 
> itself has some proprietary items added to their kernel but replacing it 
> shouldn't make other applications fails.

RHEL3 glibc (and some application binaries IIRC) assume the existence of
futex support in the kernel. Upstream, futex support only exists in 2.6,
but Red Hat backported it to their 2.4 kernels for Red Hat 9, RHEL 3,
and Fedora Core 1.

Red Hat's assumption with RHEL is that you will be running *their* kernel
so it's OK for them to make their glibc and application binaries depend
on their kernel.

If you must run a vanilla kernel, it would be best to use RHEL 2.1
instead, or to run a 2.6 kernel. Note that you'll need to install
module-init-tools to get modules working under 2.6. One way to do this
is to install a newer "modutils" package (I *think* the one from Fedora
Core 2 should work, but I don't remember for certain) -- despite the name,
the modutils package from Fedora Core 2 actually has module-init-tools in
it as well.

You may run into other gotchas when trying to run 2.6 on RHEL3; in that
case it may be easiest to wait for RHEL4 (Valentine's Day is rumored),
as that will work with 2.6 out-of-the-box and RHEL4's 2.6 kernel will
likely be far less heavily patched than RHEL3's 2.4 kernel. If you can't
wait for RHEL4, you could try the RHEL4 beta or Fedora Core in the
meantime.

If you *really* need to run a vanilla 2.4 kernel on RHEL3, you could try
installing the glibc packages from Fedora Core 1 or 2 (*maybe* FC3 glibc
packages would work too, but I'm less sure about that). Then recompile
any applications that still segfault or freeze with a vanilla kernel
(note that, for all I know, rpm itself could be one of these!)

I hope this helps...

-Barry K. Nathan <barryn@pobox.com>

