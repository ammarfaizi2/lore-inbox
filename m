Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbTDFKJ0 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbTDFKJ0 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:09:26 -0400
Received: from node181b.a2000.nl ([62.108.24.27]:28817 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S262889AbTDFKJY (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 06:09:24 -0400
Date: Sun, 6 Apr 2003 12:20:42 +0200 (CEST)
From: Stephan van Hienen <kernel@ddx.a2000.nu>
To: Andre Hedrick <andre@linux-ide.org>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: onboard ICH4 seen as ICH3 (ultra100 controller onboard)
 (2.4.20/2.4.21-pre7)
In-Reply-To: <Pine.LNX.4.10.10304052330410.32611-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.53.0304061216200.6973@ddx.a2000.nu>
References: <Pine.LNX.4.10.10304052330410.32611-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Andre Hedrick wrote:

>
> Looking back over the thread, you have a failed cable detect.
> I do not know why, but pat ide0=ata66 and ide1=ata66 to see if that is a
> temp work-around.
ok this works (but ide0=ata100/ide1=at100 doesn't work)

hda: 351651888 sectors (180046 MB) w/2048KiB Cache, CHS=21889/255/63,
UDMA(100)
blk: queue c03ddf68, I/O limit 4095Mb (mask 0xffffffff)
hdc: 351651888 sectors (180046 MB) w/2048KiB Cache, CHS=21889/255/63,
UDMA(100)
blk: queue c03de2cc, I/O limit 4095Mb (mask 0xffffffff)

]$ cat /proc/ide/piix

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1
------
DMA enabled:    yes              no              yes               no
UDMA enabled:   yes              no              yes               no
UDMA enabled:   3                X               3                 X
UDMA
DMA
PIO

]# hdparm -X69 /dev/hda

/dev/hda:
 setting xfermode to 69 (UltraDMA mode5)

]# hdparm -X69 /dev/hdc

/dev/hdc:
 setting xfermode to 69 (UltraDMA mode5)

]# cat /proc/ide/piix

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1
------
DMA enabled:    yes              no              yes               no
UDMA enabled:   yes              no              yes               no
UDMA enabled:   5                X               5                 X
UDMA
DMA
PIO



>
> You said nothing selected?
>
> Does that mean your bios is set to [none] for all devices?
> If so change it to [auto], [none] tends to do strange things.

then i get get the 'lba48 problem', my bios doesn't support lba48
