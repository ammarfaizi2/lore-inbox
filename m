Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbTFBRwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264823AbTFBRwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:52:23 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:35037 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id S264819AbTFBRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:52:21 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BDA57@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'rob@mur.org.uk'" <rob@mur.org.uk>
Cc: "'alan@lxorguk.ukuu.org.uk'" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: ide problem - is this a known problem, or is the disk dead?
Date: Mon, 2 Jun 2003 13:05:33 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-01 at 23:28, Robert Murray wrote:
> Jun 1 06:28:00 r2d2 kernel: hdc: dma_timer_expiry: dma status == 0x21
> Jun 1 06:28:10 r2d2 kernel: hdc: timeout waiting for DMA
> Jun 1 06:28:10 r2d2 kernel: hdc: timeout waiting for DMA
> Jun 1 06:28:10 r2d2 kernel: hdc: (__ide_dma_test_irq) called while not
waiting
> Jun 1 06:28:10 r2d2 kernel: hdc: status timeout: status=0xd0 { Busy }
> Jun 1 06:28:10 r2d2 kernel:
> Jun 1 06:28:10 r2d2 kernel: hdc: drive not ready for command
> Jun 1 06:28:40 r2d2 kernel: ide1: reset timed-out, status=0xd0
> Jun 1 06:28:40 r2d2 kernel: hdc: status timeout: status=0xd0 { Busy }
> Jun 1 06:29:11 r2d2 kernel:

I had exact same problem when I had both SCSI and IDE drives on my system
(and boot drive was SCSI). If you check out file drivers/ide/ide-geometry.c,
the potential hazard is spelled out in the comment:
/*
 * I did this, but it doesnt work - there is no reasonable way to find the
 * correspondence between the BIOS numbering of the disks and the Linux
 * numbering. -aeb
 *
 * The code below is bad. One of the problems is that drives 1 and 2
 * may be SCSI disks (even when IDE disks are present), so that
 * the geometry we read here from BIOS is attributed to the wrong disks.
 * Consequently, also the former "drive->present = 1" below was a mistake.
 *
 * Eventually the entire routine below should be removed.
 *
 */
 void probe_cmos_for_drives (ide_hwif_t *hwif)
 {
	...
... and it was removed in 2.5. I avoided this by just "return"-ing from this
routine.

--Natalie

