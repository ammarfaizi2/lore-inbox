Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUAQVWb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 16:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUAQVWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 16:22:31 -0500
Received: from [217.73.129.129] ([217.73.129.129]:45278 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S266153AbUAQVWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 16:22:30 -0500
Date: Sat, 17 Jan 2004 23:22:17 +0200
Message-Id: <200401172122.i0HLMHCn024145@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: 2.4.24 may be bug in prints.c:341
To: condor@vereya.net, linux-kernel@vger.kernel.org
References: <00e201c3dd32$25bde0d0$8648493e@ixip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

"Condor" <condor@vereya.net> wrote:

C> Jan 15 19:59:20 heaven kernel: sd(8,1):Using r5 hash to sort names
C> Jan 15 21:34:03 heaven kernel: 3w-xxxx: scsi0: Command failed: status =
C> 0xc7, flags = 0x1b, unit #2.
C> Jan 15 21:34:03 heaven last message repeated 27 times
C> Jan 15 21:34:07 heaven kernel: 3w-xxxx: scsi0: Command failed: status =
C> 0xc7, flags = 0xd0, unit #2.
C> Jan 15 21:34:31 heaven kernel: 3w-xxxx: scsi0: Reset succeeded.
C> Jan 16 01:53:39 heaven kernel: Device busy for revalidation (usage=2)

These indicate problems with your hard drive or disk controller.

C> Jan 16 01:55:17 heaven kernel: is_tree_node: node level 0 does not match to
C> the expected one -1
C> Jan 16 01:55:17 heaven kernel: sd(8,1):vs-5150: search_by_key: invalid
C> format found in block 0. Fsck?
C> Jan 16 01:55:17 heaven kernel: sd(8,1):vs-13050: reiserfs_update_sd: i/o
C> failure occurred trying to update [403 8975 0x0 SD] stat data
C> Jan 16 01:55:18 heaven kernel: is_tree_node: node level 0 does not match to
C> the expected one -1
C> Jan 16 01:55:18 heaven kernel: sd(8,1):vs-5150: search_by_key: invalid
C> format found in block 0. Fsck?
C> Jan 16 01:55:18 heaven kernel: sd(8,1):vs-13050: reiserfs_update_sd: i/o
C> failure occurred trying to update [403 8975 0x0 SD] stat data

Some garbage was returned for READ requests and reiserfs was not able
to find metadata it expected to find.

C> Jan 16 01:55:19 heaven kernel: journal-003: journal_end: j_start (4757) is
C> too high

Now somehow superblock data that is pinned in memory also got corrupted
and reiserfs panicked because of that.

So you have a hardware problem.

Bye,
    Oleg
