Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTKLRNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbTKLRNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:13:25 -0500
Received: from cmsrelay02.mx.net ([165.212.11.111]:59307 "HELO
	cmsrelay02.mx.net") by vger.kernel.org with SMTP id S263849AbTKLRNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:13:15 -0500
X-USANET-Auth: 131.252.134.35  AUTH cory.bell@usa.net homer.oit.pdx.edu
Subject: Re: Via KT600 support?
From: Cory Bell <cory.bell@usa.net>
To: linux-kernel@vger.kernel.org
Cc: Joe Harrington <jh@oobleck.astro.cornell.edu>
Content-Type: text/plain
Message-Id: <1068657190.4255.21.camel@homer.oit.pdx.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 12 Nov 2003 09:13:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Harrington <jh@oobleck.astro.cornell.edu> wrote:
> I am having show-stopper difficulties getting Linux to run on my Asus
> A7V600 motherboard, which sports the Via KT600 chipset.

I also have an Asus A7V600. I'm unsure of the board revision, but I'm
running BIOS 1005.
 
> During install of Fedora Core 1, Fedora Core test3, Red Hat 9, and
> Debian 3.0r1, the install fails at a random point, generally during
> the non-interactive package loading phase.  The most recent kernel
> with the problem is kernel-2.4.22-1.2115.nptl in the Fedora Core 1
> release.  The problem is 100% reproducible.

I installed FC1 from CD with no problems.

> VC messages indicate problems in different programs each time.
> Generally the failure happens during package installation, but
> sometimes it happens earlier.  After the first indication of a
> problem, one can generally still switch VCs, but eventually that stops
> working, too.  Frequently, there are several programs indicating
> problems in the VC screens.

What are you seeing? Segfaults? Panics? Have you tried the memtest86
boot option (from the FC1 CDs)?

> The hardware:
> 
> Asus A7V600 mobo (VIA KT600 chipset)
> AMD 2800+XP CPU
> 1536 MB DDR333 (3 sticks)
> IDE disks (250GB WD)
> IDE CD/DVD reader

I have:
Asus A7V600
Athlon XP 2600+ (Barton)
512MB DDR333 (PC2700)
Lite-On IDE DVD-ROM
Lite-On IDE CD-RW
Maxtor PATA 160GB
Chaintech Geforce 4 Ti4800 (AGP 8x)
No SATA

> Things I have tried:
> noapic nolapic acpi=off pci=noacpi allowcddma nodma
> in various combinations and individually.  None worked.  I also
> changed "APIC" to "PIC" in the BIOS, to no avail.

Mine works fine in APIC mode and with ACPI.
 
> I have tested and replaced the hardware extensively over the past
> several months of chasing this problem down.  The problem is not
> damaged hardware.  I suspect it is a problem with chipset support in
> the kernel.  However, I have not been able to find a reliable source
> of information about the support status of various chipsets and
> motherboard features in the kernel.

Everything is supported fine except:
1) The OSS driver doesn't like the onboard AC-97 Audio - I installed
ALSA 0.9.8 with "options snd-via82xx dxs_support=2".
2) The sk98lin driver included in 2.4.22 is very old and doesn't
support the onboard "3Com 3C940" (actually a Syskonnect chip).
2.4.23-rc1 contains the latest driver, or you can patch 2.4.22.

ALSA: http://www.alsa-project.org/
Syskonnect Driver: http://www.syskonnect.com/syskonnect/support/driver/d0102_driver.html

One caveat: It appears that the kernel included with FC1 was not
compiled with the same version of gcc that is included in FC1. This
means you will need to compile your own kernel (or rebuild the FC1
kernel SRPM). I got an instant panic when trying to insert a
locally-compiled sk98lin module into the supplied kernel, so I just
downloaded the latest 2.4.23 test release.

-Cory



