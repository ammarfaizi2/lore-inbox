Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbSKSVkL>; Tue, 19 Nov 2002 16:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbSKSVkL>; Tue, 19 Nov 2002 16:40:11 -0500
Received: from boxer.fnal.gov ([131.225.80.86]:29327 "EHLO boxer.fnal.gov")
	by vger.kernel.org with ESMTP id <S267348AbSKSVkK>;
	Tue, 19 Nov 2002 16:40:10 -0500
Date: Tue, 19 Nov 2002 15:47:14 -0600 (CST)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: Serverworks dma_intr: error=0x40 { UncorrectableError } 
Message-ID: <Pine.LNX.4.31.0211191538250.12125-100000@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problems with the Serverworks OSB4 chipset are well documented
on this list.  It is known that changing to multi-word DMA mode
will severely reduce problems.  However, since we need high
throughput in our application, we are running at high DMA speeds still.
The configuration in question is:

2.4.9-31smp kernel, Tyan 2518 motherboard, Western Digital 20 Gb system
disk hda, and hdc and hdd being each a 40Gb Western Digital drive.

The error usually happens on the system disk.  In that location
of the disk, there are usually some corrupted files as a result.
But when we either reinstall the system disk, formatting checking
for bad blocks, or low-level format the disk and reinstall, the
system is able to go on for quite some length of time
without these errors repeating.

My question--is there any way that the Serverworks OSB4 could be
causing a soft error on the disk such that the disk appears to
be bad (sometimes to the point that SMART puts up an alert in
the BIOS saying it is bad) but yet can still be used effectively?

(And yes, I am aware that the 2.4.18 kernels trap this condition and
usually stop the file corruption before it happens.)

Nov  7 05:08:10 fnd0102 kernel: Curious - OSB4 thinks the DMA is still
running.
Nov  7 05:08:10 fnd0102 kernel: OSB4 wait exit.
Nov  7 05:08:10 fnd0102 kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Nov  7 05:08:10 fnd0102 kernel: hda: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=4457382, sector=4457312
Nov  7 05:08:10 fnd0102 kernel: end_request: I/O error, dev 03:01 (hda),
sector
4457312
Nov  7 05:08:10 fnd0102 kernel: EXT2-fs error (device ide0(3,1)):

Steve Timm


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

