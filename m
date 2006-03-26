Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751980AbWCZACO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbWCZACO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWCZACO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 19:02:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15114 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751980AbWCZACN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 19:02:13 -0500
Date: Sun, 26 Mar 2006 00:02:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-git6: build failure: ksysfs.c (h7201_defconfig)
Message-ID: <20060326000202.GH25788@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20060323163852.GC25849@flint.arm.linux.org.uk> <20060323165108.GA16474@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323165108.GA16474@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 08:51:08AM -0800, Greg KH wrote:
> On Thu, Mar 23, 2006 at 04:38:52PM +0000, Russell King wrote:
> > Building h7201_defconfig on ARM provokes these build errors:
> > 
> >   LD      .tmp_vmlinux1
> > kernel/built-in.o: In function `uevent_seqnum_show':
> > ksysfs.c:(.text+0x1f258): undefined reference to `uevent_seqnum'
> > kernel/built-in.o: In function `uevent_helper_show':
> > ksysfs.c:(.text+0x1f280): undefined reference to `uevent_helper'
> > kernel/built-in.o: In function `uevent_helper_store':
> > ksysfs.c:(.text+0x1f2e0): undefined reference to `uevent_helper'
> > kernel/built-in.o:(.data+0xd1c): undefined reference to `uevent_helper'
> > make: *** [.tmp_vmlinux1] Error 1
> > make: Leaving directory `/var/tmp/kernel-orig'
> 
> Ugh, CONFIG_NET is not set, yet CONFIG_HOTPLUG is.  I was wrong with my
> assumption that no one would ever need that :)
> 
> I have a patch in my queue from Andrew that fixes it up, I'll send it on
> to Linus later today to fix this.  Thanks for letting me know.

2.6.16-git9 is better, but still fails on this defconfig.  We now
have:

  LD      .tmp_vmlinux1
kernel/built-in.o:(.data+0xd1c): undefined reference to `uevent_helper'
make: *** [.tmp_vmlinux1] Error 1
make: Leaving directory `/var/tmp/kernel-orig'

which seems to be a reference from sysfs.c for ...proc.../sys/kernel/hotplug.

This brings up an interesting point - if CONFIG_NET is not set and
CONFIG_HOTPLUG is set, don't we want to call /sbin/hotplug?  If
...proc.../sys/kernel/hotplug isn't present then what?

Or are we back in the business of breaking the userspace expectations
in random ways?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
