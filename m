Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTIEJoD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 05:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTIEJoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 05:44:03 -0400
Received: from zooty.lancs.ac.uk ([148.88.16.231]:11922 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP id S262319AbTIEJoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 05:44:00 -0400
Subject: Re: corruption with A7A266+200GB disk?
To: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Date: Fri, 5 Sep 2003 10:43:57 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <1062596153.19059.42.camel@dhcp23.swansea.linux.org.uk> from "Alan Cox" at Sep 03, 2003 02:35:54 PM
X-Mailer: ELM [version 2.5 PL0]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19vD8H-00079E-00@cent1.lancs.ac.uk>
From: Steve Bennett <steveb@unix.lancs.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ALi does support LBA48 in PIO mode. Right now the choice is 
> DMA and 137Gb or no DMA and 200Gb, ideally it should be DMA
> and fall back to PIO for the top 70Gb, but not yet a while.

OK, having actually read what dmesg says (instead of making assumptions),
I see:
    hda: max request size: 128KiB
    hda: cannot use LBA48 - full capacity 390721968 sectors (200049 MB)
    hda: 268435456 sectors (137438 MB) w/8192KiB Cache, CHS=16709/255/63, UDMA(100)
     hda: hda1 hda2 hda3 hda4

and fdisk reports:
   # /sbin/fdisk -l

   Disk /dev/hda: 137.4 GB, 137438953472 bytes
   255 heads, 63 sectors/track, 16709 cylinders
   Units = cylinders of 16065 * 512 = 8225280 bytes

      Device Boot    Start       End    Blocks   Id  System
   /dev/hda1   *         1        13    104391   83  Linux
   /dev/hda2            14      1057   8385930   83  Linux
   /dev/hda3          1058      1188   1052257+  82  Linux swap
   /dev/hda4          1189      6169  40009882+  83  Linux

So the disk is being correctly downgraded to a non-lba48-compatible size.
In which case, why is the disk getting trashed?

Maybe there's a fault on the disk itself? I'll find a system that does lba48
and try it there...

Steve.

