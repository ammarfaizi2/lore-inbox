Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbTDCV6A 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263560AbTDCV6A 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:58:00 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:6753 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S263559AbTDCV55 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 16:57:57 -0500
Message-ID: <00bf01c2fa2d$afafedd0$2e77c23e@pentium4>
From: "Jonathan Vardy" <jonathanv@explainerdc.com>
To: "Peter L. Ashford" <ashford@sdsc.edu>,
       "Stephan van Hienen" <raid@a2000.nu>
Cc: "Jonathan Vardy" <jonathan@explainerdc.com>, <linux-raid@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.30.0304031334070.20118-100000@multivac.sdsc.edu>
Subject: Re: RAID 5 performance problems
Date: Fri, 4 Apr 2003 00:09:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK.  We've found a potential issue.  Are the disks being identified as
> UDMA-33 or UDMA-66/100/133?  The performance numbers agree too closely for
> this to be a coincidence.  Check the boot logs.

I looked into /var/log/dmesg and found this:

blk: queue c0393144, I/O limit 4095Mb (mask 0xffffffff)
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63, UDMA(33)
blk: queue c03934a8, I/O limit 4095Mb (mask 0xffffffff)
hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(33)
blk: queue c039380c, I/O limit 4095Mb (mask 0xffffffff)
hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(33)
blk: queue c0393b70, I/O limit 4095Mb (mask 0xffffffff)
hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(33)
blk: queue c0393ed4, I/O limit 4095Mb (mask 0xffffffff)
hdi: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(33)
blk: queue c0394238, I/O limit 4095Mb (mask 0xffffffff)
hdk: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(33)

This is what you meant?

but after the boot I set hdparm manually for each drive with the following
settings:

hdparm -a8 -A1 -c1 -d1 -m16 -u1 /dev/hdc.

