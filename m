Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUEYTk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUEYTk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbUEYTkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:40:55 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:43236 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265081AbUEYTj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:39:56 -0400
To: greg@bakers.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 agpgart on Tyan K8W 32bit not working?
References: <1ZPD4-17S-7@gated-at.bofh.it>
From: rainer.koenig.abg@t-online.de (Rainer Koenig)
Organization: Rainer at home
Date: Tue, 25 May 2004 21:38:45 +0200
In-Reply-To: <1ZPD4-17S-7@gated-at.bofh.it> (bakerg3@yahoo.com's message of
 "Tue, 25 May 2004 21:20:10 +0200")
Message-ID: <87y8nguwje.fsf@Rainer.Koenig.Abg.dialin.t-online.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
X-Seen: false
X-ID: Z6x3MZZGYe3OfWxukGSNJajuej3VUlxTB48-XWEOKRYKpS1BRcBDk7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gb <bakerg3@yahoo.com> writes:

> I'm using the generic 2.4.26 kernel on a Tyan K8W
> (dual opteron) with 4GB of memory and an NV18GL
> [Quadro4 NVS] graphics card.  The K8W BIOS version is
> 2.02 (1.02 also exhibits the same behavior).

Let me limit the output to the interesting part:

> On a 64bit kernel, the following is returned:
>
> [greg@testpig3 greg]$ lspci
> 04:01.0 PCI bridge: Advanced Micro Devices [AMD]
> AMD-8151 AGP Bridge (rev 13)
> 05:00.0 VGA compatible controller: nVidia Corporation
> NV18GL [Quadro4 NVS] (rev a2)
> 05:00.0 VGA compatible controller: nVidia Corporation
> NV18GL [Quadro4 NVS] (rev a2)
>
> On a 32-bit kernel, the following is returned:
>
> [greg@profit linux]$ lspci
> 03:0c.0 FireWire (IEEE 1394): Texas Instruments
> TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
> 05:00.0 VGA compatible controller: nVidia Corporation
> NV18GL [Quadro4 NVS] (rev a2)

The AMD-8151 AGP Bridge on bus #4 is missing on the 32-bit kernel.

> [greg@profit linux]$ dmesg | grep -i agp
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory:
> 3932M
> agpgart: no supported devices found.
> [drm:drm_init] *ERROR* Cannot initialize the agpgart
> module.
> 0: NVRM: AGPGART: unable to retrieve symbol table

Well, I have experienced problems with Red Hat EL 3.0 32 bit where the
old kernel doesn't support the AMD bridge. But on my tests a 2.4.25
kernel did well. So the problem is located elsewhere.

> I have tried booting with:
>
> kernel /vmlinuz-2.4.26-bangalore4-01 ro root=/dev/hda2
> hdc=ide-scsi apm=power-off agp_try_unsupported=1

The question is how your kernel is configuring the PCI devices because
the problem is that the bridge is not listed in the output of lspci.
Try the boot parameter "pci=noacpi" so that PCI is configured the "old"
way without using probably buggy ACPI tables from the BIOS. Anyway, your
problem really looks very strange to me, because usally the kernel that
doesn't see the bridge on bus #4 won't even see the AGP card on bus #5.

Regards,
Rainer
-- 
Rainer König, Diplom-Informatiker (FH), Augsburg, Germany
