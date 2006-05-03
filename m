Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWECNcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWECNcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWECNcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:32:42 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:32391 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1030190AbWECNcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:32:41 -0400
Date: Wed, 3 May 2006 15:32:39 +0200
From: Sander <sander@humilis.net>
To: Mark Lord <liml@rtr.ca>
Cc: sander@humilis.net, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060503133239.GA11811@favonius>
Reply-To: sander@humilis.net
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius> <4428BCBF.2050000@pobox.com> <20060503121643.GA21882@favonius> <4458A52D.30100@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4458A52D.30100@rtr.ca>
X-Uptime: 15:14:13 up 4 days, 19:19, 30 users,  load average: 1.68, 1.63, 1.69
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote (ao):
> I'm still debugging the chip/driver on the 2.6.16.xx series,
> and my sata_mv.c code here is behaving well for most testers
> thus far here. I'm avoiding 2.6.17-* until sata_mv stabilizes
> on the existing kernels.
> 
> Does the drive probing work for you on older kernels?

Thank you for your reply. I'll try the latest 2.6.16.13 kernel and see
how that goes.

I'll also try the kernel 2.6.17-rc3 as Andrew asked me to check if the
"Assertion failed!" message is gone in that release.

> I'll email you privately and set you up with a better copy of
> sata_mv.c

Thanks!

I believe quite some bits changed in sata between 2.6.16 and 2.6.17-rcX.
I assume your sata_mv.c will not work at all on anything else than
2.6.16(.xx) ?


Btw, building raid5 over the first eight disks works fine (76% done
now). Building raid5 over the last four disks fails immediately (drives
get marked F in /proc/mdstat).

The message "PCI ERROR; PCI IRQ cause=0x40000100" gives no result in
Google. Could this be a broken or miss-seated controller?

	With kind regards, Sander


[61784.672427] md: bind<sdk>
[61784.688305] md: bind<sdl>
[61784.708029] md: bind<sdm>
[61784.723717] md: bind<sdn>
[61784.744018] raid5: device sdm operational as raid disk 2
[61784.775951] raid5: device sdl operational as raid disk 1
[61784.807838] raid5: device sdk operational as raid disk 0
[61784.840407] raid5: allocated 4262kB for md2
[61784.865502] raid5: raid level 5 set md2 active with 3 out of 4 devices, algorithm 2
[61784.911459] RAID5 conf printout:
[61784.930942]  --- rd:4 wd:3 fd:1
[61784.949935]  disk 0, o:1, dev:sdk
[61784.969901]  disk 1, o:1, dev:sdl
[61784.989904]  disk 2, o:1, dev:sdm
[61785.051462] RAID5 conf printout:
[61785.070778]  --- rd:4 wd:3 fd:1
[61785.089573]  disk 0, o:1, dev:sdk
[61785.109412]  disk 1, o:1, dev:sdl
[61785.129250]  disk 2, o:1, dev:sdm
[61785.149088]  disk 3, o:1, dev:sdn
[61785.168981] md: syncing RAID array md2
[61785.191425] md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
[61785.233595] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
[61785.293964] md: using 128k window, over a total of 293057280 blocks.
[61788.142322] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[61788.186559] ata22: status=0x50 { DriveReady SeekComplete }
[61788.219510] ata22: error=0x01 { AddrMarkNotFound }
[61788.248283] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[61788.406525] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[61788.450799] ata23: status=0x50 { DriveReady SeekComplete }
[61788.483752] ata23: error=0x01 { AddrMarkNotFound }
[61788.512526] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[61789.169903] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[61789.214134] ata22: status=0x50 { DriveReady SeekComplete }
[61789.247088] ata22: error=0x01 { AddrMarkNotFound }
[61789.901445] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[61789.945686] ata24: status=0x50 { DriveReady SeekComplete }
[61789.978638] ata24: error=0x01 { AddrMarkNotFound }
[61790.007411] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[61790.665135] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[61790.709387] ata21: status=0x50 { DriveReady SeekComplete }
[61790.742337] ata21: error=0x01 { AddrMarkNotFound }
[61791.396897] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[61791.441145] ata24: status=0x50 { DriveReady SeekComplete }
[61791.474097] ata24: error=0x01 { AddrMarkNotFound }
[61791.502871] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100

[cut]


-- 
Humilis IT Services and Solutions
http://www.humilis.net
