Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271840AbRH0Sxg>; Mon, 27 Aug 2001 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271841AbRH0Sx1>; Mon, 27 Aug 2001 14:53:27 -0400
Received: from cr934547-a.flfrd1.on.wave.home.com ([24.112.247.163]:9404 "EHLO
	mokona.furryterror.org") by vger.kernel.org with ESMTP
	id <S271840AbRH0SxM>; Mon, 27 Aug 2001 14:53:12 -0400
From: uixjjji1@umail.furryterror.org (Zygo Blaxell)
Subject: Linux 2.4.9 (and 2.4.8-ac{11,12}) IDE brokenness (and workaround for non-PDC20268R chipsets)
Date: 27 Aug 2001 14:50:31 -0400
Organization: Furry Cats and Hungry Terrors
Message-ID: <9me4pn$iko$1@shippou.furryterror.org>
NNTP-Posting-Host: 10.250.7.77
X-Header-Mangling: Original "From:" was <zblaxell@shippou.furryterror.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some machines running 2.4.9 and 2.4.8-ac1[12], I get an unending stream of these:

	Aug 27 14:46:39 kasumi kernel: hdh: status error: status=0x58 { DriveReady SeekComplete DataRequest }
	Aug 27 14:46:39 kasumi kernel: hdh: drive not ready for command
	Aug 27 14:46:45 kasumi kernel: hdf: status error: status=0x58 { DriveReady SeekComplete DataRequest }
	Aug 27 14:46:45 kasumi kernel: hdf: drive not ready for command
	Aug 27 14:46:45 kasumi kernel: hdh: status error: status=0x58 { DriveReady SeekComplete DataRequest }
	Aug 27 14:46:45 kasumi kernel: hdh: drive not ready for command

This only seems to happen to some drives or drive/controller combinations.
For disks on PIIX controllers, sometimes the DMA doesn't get turned on at
startup.  A simple 'hdparm -d1 /dev/hdc' can fix this.

Unfortunately, this is what happens on a Promise Fasttrak 100 TX2 (PCI device
ID 0x6268):

	root@kasumi:~# hdparm -d1 /dev/hde

	/dev/hde:
	 setting using_dma to 1 (on)
	 HDIO_SET_DMA failed: Operation not permitted
	 using_dma    =  0 (off)

	root@kasumi:~# cat /proc/ide/pdc202xx

					PDC202XX Chipset.
	------------------------------- General Status ---------------------------------
	Burst Mode                           : enabled
	Host Mode                            : Tri-Stated
	Bus Clocking                         : 100 External
	IO pad select                        : 10 mA
	Status Polling Period                : 15
	Interrupt Check Status Polling Delay : 15
	--------------- Primary Channel ---------------- Secondary Channel -------------
			enabled                          enabled
	66 Clocking     enabled                          enabled
		   Mode MASTER                      Mode MASTER
			Error                            Error
	--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
	DMA enabled:    no               no              no                no
	DMA Mode:       PIO---           PIO---          PIO---            PIO---
	PIO Mode:       PIO ?            PIO ?           PIO ?            PIO ?


The drives function perfectly (as far as I can tell, anyway) when I
use a hacked version of 2.4.6 which simply uses the PDC20268 driver
(PCI id 0x4d68) on my PDC20268R card (PCI id 0x6268).

-- 
Zygo Blaxell (Laptop) <zblaxell@feedme.hungrycats.org>
GPG = D13D 6651 F446 9787 600B AD1E CCF3 6F93 2823 44AD
