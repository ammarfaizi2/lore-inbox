Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWHHJQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWHHJQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWHHJQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:16:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:25004 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750833AbWHHJQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:16:21 -0400
Date: Tue, 8 Aug 2006 11:13:00 +0200 (MEST)
Message-Id: <200608080913.k789D0fC019037@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org, thomas@stewarts.org.uk
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 09:24:29 +0100, Thomas Stewart wrote:
> I have a Dell Optiplex GX280, a Pentium 4 with an Intel chipset. It has
> 4G of ram. The problem is I can only see 3.2G, even tho the bios reports
> 4G.
> 
> While using debian 2.6.16-2-686:
> thomas@coke:~$ uname -a
> Linux coke 2.6.16-2-686 #1 Sat Jul 15 21:59:21 UTC 2006 i686 GNU/Linux
> thomas@coke:~$ grep MemTotal /proc/meminfo
> MemTotal:      3375484 kB
> 
> This is expected as the standard debian kernels don't set
> CONFIG_HIGHMEM64G. My understanding is that this needs to be set for the
> full 4G to work on i386.
> 
> So I downloaded 2.6.18-rc3-git3 and 2.6.18-rc2-mm1 to give them a try. I
> used the debian config as a starting point for oldconfig. Then from
> menuconfig, "Processor type and featues" -> "High Memory Support" and
> selected 64G. I then compiled both, rebooted and got these results:
> 
> 2.6.18-rc2-mm1  reported MemTotal: 3376192 kB
> 2.6.18-rc3-git3 reported MemTotal: 3376236 kB

Most likely the BIOS is reserving large parts of the [0,4GB[ range for
PCI devices and some for itself. Please post the E820 memory map the
kernel prints near the start of the boot sequence on your machine.

> Is there anything I can do to make use of the 800M or so of ram that's
> unused? Changing to amd64 or anything else that's sane or better does
> not count ;-)

You need a chipset+BIOS that can relocate RAM to above the 4GB boundary.
I don't know how common those are in the 32-bit x86 world.
