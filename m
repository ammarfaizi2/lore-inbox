Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSE1QKu>; Tue, 28 May 2002 12:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSE1QKt>; Tue, 28 May 2002 12:10:49 -0400
Received: from vulcan.alphanet.ch ([62.2.159.14]:5986 "EHLO vulcan.alphanet.ch")
	by vger.kernel.org with ESMTP id <S314529AbSE1QKt>;
	Tue, 28 May 2002 12:10:49 -0400
Date: Tue, 28 May 2002 18:02:36 +0200 (MEST)
From: Marc SCHAEFER <schaefer@alphanet.ch>
To: linux-kernel@vger.kernel.org
Subject: IDE hotswap
Message-ID: <Pine.LNX.3.96.1020528180129.20664B-100000@defian.alphanet.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to implement real hotswapping support with IDE drives in the
following setup:

   Asus A7V motherboard (has 2 standard IDE bus, and 2 additional bus)
   cheap/standard hotswap IDE hardware

   00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
   00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)

Simply removing and replacing the disk drive will cause hangs in normal
operation.

I have noticed, by creating a simple boot floppy with IDE modules
(ide_mod, ide_disk, ide_probe_mod), that if you remove ide_probe_mod, 
replace the disk, and reinsert ide_probe_mod, the disk is detected
correctly (geometry, size, etc).

My questions:

   - assuming one-disk-per-bus (ie 4 disks in the above IDE+promise
     configuration), is it at all feasible ?  (ie IDE masters only)

   - should I expect the IDE chips to hardware-fail after a few
     inserts/removes ?

   - would modifying drivers/ide/ide_probe.c to add a new function
     drop_bus(bus_id), scan_bus(bus_id) be a good idea, along with
     a /proc interface from ide_probe.c or another to be developped
     module ?

   - is there already work in progress in the topic ?  or a simpler
     way to do the above ?

The initial case is to assume that inserting/removing must be done in a
software-controlled way.

The next step will be to see if the IDE subsystem can detect a failing
drive / removed drive without warning. Reinsertion could be done by
polling every 30 seconds or manual user intervention. 

Thank you for any comments.


