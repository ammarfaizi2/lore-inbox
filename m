Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSHFQDw>; Tue, 6 Aug 2002 12:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSHFQDw>; Tue, 6 Aug 2002 12:03:52 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:53253 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S311025AbSHFQDv>;
	Tue, 6 Aug 2002 12:03:51 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andries Brouwer <aebr@win.tue.nl>
Date: Tue, 6 Aug 2002 18:06:55 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.5.30 IDE 112
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, martin@dalecki.de
X-mailer: Pegasus Mail v3.50
Message-ID: <1404D797AC6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Aug 02 at 16:10, Andries Brouwer wrote:
> > BIOS refused to report proper size (120GB) when partition table
> > was empty, or when it contained partitions created for xxx/16/63
> > geometry. It reported size ~600MB, and actively refused to allow
> > access above this limit...
> 
> Funny. Do you mean that your BIOS used SETMAX ?

No. It miscalculated something somewhere. Only BIOS INT13h interface
was affected. But it is problem if it is your boot disk, and BIOS
is willing to load only MBR and first few sectors from disk, while your
LILO lives at ~60GB from disk start.
 
> Yes. I already advised this maintainer to add -C,-H,-S options to fdisk
> (cfdisk and sfdisk already have them), and he did so immediately.
> Visible one of these weeks in util-linux-2.11v.

Thanks. I'm still using fdisk...
 
> So, I have two questions:
> 1. What precisely do you mean with "actively refused" ?
> 2. Is there a Windows or Netware reason to prefer extended translation
> above no translation?

When that one BIOS (Award in 6BTM from Chaintech) found 120GB disk
with partition table saying that it is partitioned as 16heads/63sectors,
depending on LBA/LARGE/NORMAL setting it reported size 20MB/600MB/30GB
(if you want exact numbers/geometries, I can obtain them on saturday),
and code in the BIOS checked that OS does not try to access data above 
limit BIOS (mis)calculated when using INT13 interface (so windows98 rescue 
diskette was not able to create partition > 30GB, and PartitionMagic 
refused to operate at all with partition error #110 (or 108 or 109)).

I first thought that BIOS does not support disks over 30GB, but after
I rebuilt partition table with xxx/255/63 geometry, disk was correctly 
recognized and reported as 120GB by BIOS regardless of setting in the BIOS.

Some Netware drivers use geometry reported by the BIOS internally, and
if BIOS reports 16heads/63sectors, code doing blocknr -> CHS -> LBA can
overflow. But it is fixed for some years, so it should not be problem
for existing systems, and new (NW5/NW6) systems should cope with this.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
