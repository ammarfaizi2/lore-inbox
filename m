Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314454AbSEQLx0>; Fri, 17 May 2002 07:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314465AbSEQLxZ>; Fri, 17 May 2002 07:53:25 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:59664 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314454AbSEQLxZ>; Fri, 17 May 2002 07:53:25 -0400
Date: Fri, 17 May 2002 13:53:20 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Linux 2.4/2.5 SCSI considerably slower than FreeBSD
Message-ID: <20020517115319.GA3204@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Marco Flohrer has posted an inquiry to de.comp.os.unix.linux.hardware
[German] <slrnae8q66.go4.marco.flohrer@diamond.csn.tu-chemnitz.de> that his
Seagate 36ES2 was slow with a DawiControl 2976UW (SYM53C875), only
around 25 MB/s. I have the same observation with a Fujitsu MAH3182MP
with an Adaptec 2940UW Pro which is not much faster. Either bus has an
active LVD/SE terminator.

Single-user mode,
time dd if=/dev/XXX of=/dev/null bs=65536 count=10240
(671,1 MB) linear read.

Table shows throughput in decimal MB/s (M = 1,000,000)

                               2.5  2.4  FBSD        max.
UWSCSI Fuj MAH3182MP  7200/min 32,1 29,4 35,1 TQ     40
UDMA66 Max 4W060H4    5400/min 27,1 26,7 25,7        66
UDMA66 IBM DTLA307045 7200/min 37,2 37,5 37,2 TQ 2.5 66
UDMA66 WDC AC420400D  5400/min 15,5 15,5 15,5 TQ 2.5 66
                               --------------
table is in decimal MB/s.

2.4:  Linux 2.4.19-pre2-ac3
2.5:  Linux 2.5.15
FBSD: FreeBSD 4.6-RC (Tagged Queueing Broken)

The IDE drives are attached to a VIA 82C686 (KT133), the Fujitsu
(actually an U-160 drive) to the mentioned Adaptec.

FBSD gets about 20% better throughput. It's far from perfect, but 90% of
the maximum is probably almost as good as we can get.

Why is Linux SCSI so slow?

-- 
Matthias Andree
