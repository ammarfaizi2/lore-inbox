Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWECMmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWECMmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWECMmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:42:25 -0400
Received: from rtr.ca ([64.26.128.89]:18143 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965182AbWECMmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:42:23 -0400
Message-ID: <4458A52D.30100@rtr.ca>
Date: Wed, 03 May 2006 08:42:21 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: sander@humilis.net
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius> <4428BCBF.2050000@pobox.com> <20060503121643.GA21882@favonius>
In-Reply-To: <20060503121643.GA21882@favonius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've added two Marvell MV88SX6081 controller (total of three now),
> removed the bad disks from the system (all I hope), added new ones
> (total of 12, 300GB Maxtor DiamondMax, connected to the controllers
> now (each four disks)), and added two 2.5" disks for the OS (connected
> to the onboard Nvidia).
> 
> I also upgraded to 2.6.17-rc3-mm1, which seemed oke using badblocks, but
> dd and mdadm give trouble.
> 
> First of all, Linux does not always see all disks during boot. Sometimes
> one or two disks are missing. I haven't checked yet if these are always
...
> [  416.910684] ata12: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000B8120 bmdma 0x0 irq 21
> [  417.016463] BUG: warning at drivers/scsi/sata_mv.c:1904/__msleep()
> [  417.053468] 
> [  417.053469] Call Trace: <IRQ> <ffffffff803e8c33>{__mv_phy_reset+242}
> [  417.099671]        <ffffffff803e811f>{mv_channel_reset+133} <ffffffff803e9297>{mv_interrupt+568}
> [  417.152658]        <ffffffff8020ec91>{handle_IRQ_event+41} <ffffffff80282bbf>{__do_IRQ+155}
> [  417.203033]        <ffffffff8025dd91>{do_IRQ+60} <ffffffff8025be52>{default_idle+0}
> [  417.249254]        <ffffffff80256178>{ret_from_intr+0} <EOI> <ffffffff80258d00>{thread_return+86}
> [  417.302853]        <ffffffff8025be7f>{default_idle+45} <ffffffff80243c0f>{cpu_idle+98}
> [  417.350632]        <ffffffff806e8b74>{start_secondary+1127}
> [  420.701529] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
> [  420.701533] ata5: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
...

> [55973.577770] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
> [55973.622012] ata24: status=0x50 { DriveReady SeekComplete }
> [55973.654966] ata24: error=0x01 { AddrMarkNotFound }
> [55973.683740] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
...

Hi Sander,

I'm still debugging the chip/driver on the 2.6.16.xx series,
and my sata_mv.c code here is behaving well for most testers
thus far here.  I'm avoiding 2.6.17-* until sata_mv stabilizes
on the existing kernels.

Does the drive probing work for you on older kernels?

I'll email you privately and set you up with a better copy of sata_mv.c

Cheers
