Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbSK3AKY>; Fri, 29 Nov 2002 19:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbSK3AKY>; Fri, 29 Nov 2002 19:10:24 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:56203 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267189AbSK3AKW>;
	Fri, 29 Nov 2002 19:10:22 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mark Rutherford <mark@justirc.net>
Date: Sat, 30 Nov 2002 01:17:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [2.4.20] Trouble with via 8235 [does not boot]
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <8F01E9B6A83@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 02 at 18:58, Mark Rutherford wrote:

> I think I have but i will let you all be the judge.
> please find attached my .config renamed to config.txt for the sake of
> window$

Nothing strange in it...

> also find attached a normal bootup as of 1 hour ago using kernel 2.5.44
> I have tried the following:
> re-downloaded the kernel souces in both tar/bz2 and tar/gzip formats
> both archives were the same, natually
> reconfigured both to no avail.
> what I do not understand is that it does not detect the 2 devices i have
> on the promise controller, or hda, hdb
> it does find hdc and hdd and it does seem to detect the via 8235
> controller as well.
> what could possibly be wrong here?

>From log you posted:
 
> Nov 29 18:14:24 Darkstar kernel: PDC20276: IDE controller at PCI slot 00:0f.0
> Nov 29 18:14:24 Darkstar kernel: PDC20276: chipset revision 1
> Nov 29 18:14:24 Darkstar kernel: PDC20276: not 100%% native mode: will probe irqs later
> Nov 29 18:14:24 Darkstar kernel: PDC20276: neither IDE port enabled (BIOS)
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Nov 29 18:14:24 Darkstar kernel: VP_IDE: IDE controller at PCI slot 00:11.1
> Nov 29 18:14:24 Darkstar kernel: VP_IDE: chipset revision 6
> Nov 29 18:14:24 Darkstar kernel: VP_IDE: not 100%% native mode: will probe irqs later
> Nov 29 18:14:24 Darkstar kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
> Nov 29 18:14:24 Darkstar kernel: hda: setmax LBA 156250080, native 156250000
> Nov 29 18:14:24 Darkstar kernel: hda: 156250000 sectors (80000 MB)
> w/2048KiB Cache, CHS=9726/255/63, UDMA(100)
> Nov 29 18:14:24 Darkstar kernel:  hda: hda1
> Nov 29 18:14:24 Darkstar kernel: hdb: 26564832 sectors (13601 MB)
> w/2048KiB Cache, CHS=1653/255/63, UDMA(66)
> Nov 29 18:14:24 Darkstar kernel:  hdb: hdb1 hdb2
> Nov 29 18:14:24 Darkstar kernel: Uniform CD-ROM driver Revision: 3.12

It looks to me like that 2.5.44 also believes that you have
two HDDs connected to VIA, and none to Promise. Did not just
2.4.20 swapped hda/hdb with hdc/hdd?

It would be really handy if you could write down logs from 2.4.20. Or
capture them with serial console.

You can also boot 2.5.x, look at which address your via lives, and
then use ide0=... parameters. I believe that via should be configured
for primary IDE, so try booting 2.4.20 with ' ide0=0x1f0,0x3f6,14'.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
