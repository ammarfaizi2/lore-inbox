Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSLBXBs>; Mon, 2 Dec 2002 18:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSLBXBs>; Mon, 2 Dec 2002 18:01:48 -0500
Received: from [81.2.122.30] ([81.2.122.30]:1540 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265108AbSLBXBr>;
	Mon, 2 Dec 2002 18:01:47 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212022320.gB2NKS2J000315@darkstar.example.net>
Subject: More intellegent bad block reallocation in software?
To: linux-kernel@vger.kernel.org
Date: Mon, 2 Dec 2002 23:20:28 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible, or at least feasible for certain disk devices, to
disable the firmware-level re-allocation of bad blocks, (note: I am
aware that disks typically have many bad blocks that are reliant on
ECC to function - I am refering to completely bad blocks, that are
replaced with a 'spare' block), and do this in software?

The reason I'm asking, is because presumably the 'spare' blocks are
kept at the end or the disk, or at least all in one place, (or
possibly throughout the disk in each ZBR zone).  If this is the case,
then reading a single large file which is, according to the
filesystem, all in consecutive blocks, could involve several seeks to
the area where the spare blocks are.

My idea is that we could allocate one block out of every ten to be a
spare block, (which would reduce disk capacity by 10%), and then if a
block needed to be re-allocated, we could allocate one from the same
cylinder, therefore removing the need for the heads to seek across the
disk.

How easily could this be added to existing filesystems?  Presumably
we'd need extra functionality in both filesystem code and the IDE and
SCSI code, and I realise that it might be completely impossible,
without custom firmware on the disk.  It's an interesting idea
though.

John.
