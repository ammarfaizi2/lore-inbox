Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262727AbTCJFZO>; Mon, 10 Mar 2003 00:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbTCJFZN>; Mon, 10 Mar 2003 00:25:13 -0500
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:39182 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP
	id <S262727AbTCJFZM>; Mon, 10 Mar 2003 00:25:12 -0500
Message-ID: <3E6C2436.1000007@torque.net>
Date: Mon, 10 Mar 2003 15:35:50 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
Subject: Re: 2.4: high system load with SG_IO on IDE-SCSI: PIO?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
 > I have seen readcd ("sg driver 3.2.0") use 96% system time
 > for a readcd -c2scan on IDE-SCSI (ATAPI CD-ROM, Plextor
 > PX-4824TA 1.04, UDMA/33), Linux 2.4.19+SuSE patches
 > (k_athlon-2.4.19-167).
 >
 > ...
 > ioctl(3, 0x2285, 0xbfffec20)            = 0
 > ...
 >
 > The same application on a real SCSI-device with SCSI host
 > adaptor (aic7xxx FWIW) is way below 5% system CPU time.
 >
 > Might SG_IO use PIO on ATAPI CD-ROMs? If so, are there
 > patches to enable DMA? Is this at all possible with SG_IO?

 > I find 96% system load is way too high for modern hardware.
 > (Duron/700 that is, VIA 82C686a).

SG_IO is an ioctl in the sg driver that issues scsi commands
and waits for a response. The route from sg is through the
scsi mid level and via ide-scsi to the ide subsystem. Nothing
in the SG_IO ioctl interface addresses ATA DMA and PIO settings.
They can be changed via the hdparm ** command.

The experience from the early 2.4 series was that the ide
subsystem was too aggressive in its DMA settings for CD/DVD
burners. [My experience with scsi devices is that disks have
much better target implementations (i.e. more robust) than
CD/DVD devices and scanners.] Later versions of the 2.4 series
are a lot more conservative in their speed treatment of ATAPI
devices. The robustness comes at the expense of system load.


** Even though a CD writer appears as /dev/scd0 with ide-scsi
appropriately configured, the hdparm command can still be used
on /dev/hdd (for example, if the writer is the slave on the
second IDE bus).

Doug Gilbert

