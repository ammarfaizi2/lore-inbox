Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVBZWFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVBZWFP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 17:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVBZWFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 17:05:14 -0500
Received: from elektron.ikp.physik.tu-darmstadt.de ([130.83.24.72]:35849 "EHLO
	elektron.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S261277AbVBZWFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 17:05:08 -0500
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
Date: Sat, 26 Feb 2005 23:04:59 +0100
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: torvalds@osdl.org, akpm@osdl.org, bon@elektron.ikp.physik.tu-darmstadt.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <20050226213459.GA21137@apps.cwi.nl>
References: <20050226213459.GA21137@apps.cwi.nl>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

Andrew,

    Andries> I think nobody uses such partitions seriously, but nevertheless
    Andries> this should probably live in -mm for a while to see if anybody
    Andries> complains.

the partition table of the USB stick in question is valid:

 1B0:  00 00 00 00 00 00 00 00   53 3F 3C B9 00 00 00 01 ........S?<.....
 1C0:  01 00 06 10 21 7D 25 00   00 00 DB F3 01 00 00 00 ....!}%.........
 1D0:  00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00 ................
   *
 1F0:  00 00 00 00 00 00 00 54   72 75 6D 70 4D 53 55 AA .......TrumpMSU.

Entry 1 is a FAT partition of exactly the size of the stick, and entries 2
to 4 are empty, marked by id zero. However the manufacturer decided to put a
name string  "Trump" ( /sbin/lsusb gives
Bus 004 Device 012: ID 090a:1bc0 Trumpion Microelectronics, Inc.) just before
the "55 AA" partition table magic and our code reads this string as a
(bogus) size for the fourth entry, taking it for real.

Please consider the patch for the main kernel distribution.

Cheers
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
