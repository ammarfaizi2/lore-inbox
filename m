Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVKCOvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVKCOvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVKCOvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:51:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29377 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030209AbVKCOvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:51:12 -0500
Subject: Re: ECC circuitry error / md weirdness?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: PinkFreud <pf-kernel20051102@mirkwood.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051102155711.GT19490@eriador.mirkwood.net>
References: <20051102155711.GT19490@eriador.mirkwood.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 15:21:14 +0000
Message-Id: <1131031274.18848.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-02 at 10:57 -0500, PinkFreud wrote:
> We have an md array (RAID5) with 3 disks + 1 spare.  Recently, this
> appeared in the logs:
> 
> Oct 27 23:44:58 cbs-server kernel: hdk: status timeout: status=0x80 {
> Busy }
> Oct 27 23:44:58 cbs-server kernel: 
> Oct 27 23:44:58 cbs-server kernel: hdk: DMA disabled
> Oct 27 23:44:58 cbs-server kernel: PDC202XX: Secondary channel reset.
> Oct 27 23:44:58 cbs-server kernel: hdk: drive not ready for command
> Oct 27 23:45:04 cbs-server kernel: ide5: reset: master: ECC circuitry
> error
> Oct 27 23:45:04 cbs-server kernel: hdk: status error: status=0x58 {
> DriveReady SeekComplete DataRequest }
> 
> After that was just a repetition of the 'drive not ready for command'
> and status=0x58 lines.
> 
> What really threw me for a loop, though, was the fact that hdk was one
> of the active disks in the array mentioned above.  md was happily
> writing to a disk that the kernel thought was failing!  I had to
> manually fail the disk out of the array to convince md to pull the
> spare in.
> 
> The end result is one hell of a corrupt filesystem (I'm now seeing
> 'ghost' files that won't go away):
> 
> [root@cbs-server cope11.feat]# ls -al | grep example_func.nii.gz
> [root@cbs-server cope11.feat]# ls -al example_func.nii.gz
> ls: example_func.nii.gz: Input/output error
> [root@cbs-server cope11.feat]# 
> 
> fsck has had no luck in fixing these errors, though it does find
> - and fix - problems every time I run it (ext3 fs).
> 
> I suspect I'm going to have to mkfs the array (unless someone can
> recommend something else!).  My main concern, though, is figuring out
> what went wrong with hdk and md in the first place.  I've never seen
> the ECC circuitry error that was thrown before.  AFAICT, the hard disk
> appears to be fine.  It's about 3 months old, and both SMART offline
> data collection and extended self test were run last night without a
> single error being logged by the drive.  Likewise, it stopped throwing
> errors in the system logs when it was failed out of the array.
> 
> I'm also concerned about why md was writing to a disk that the kernel
> saw as having errors.  Should it not fail the disk out of the array
> automatically?
> 
> Specs on the system in question:
> 2.4.31 (vanilla) SMP
> 2 Promise 20268 IDE controllers
> 4 WDC WD3200SB-01KMA0 disks
> 
> 
