Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVILOhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVILOhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVILOhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:37:07 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:26046 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1751059AbVILOhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:37:06 -0400
Date: Mon, 12 Sep 2005 16:37:04 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
cc: "David S. Miller" <davem@redhat.com>, sparclinux@vger.kernel.org,
       Aurora development <aurora-sparc-devel@lists.auroralinux.org>
Subject: [2.6.13-rc6-git13/sparc64]: Slab corruption (possible stack or
 buffer-cache corruption)
Message-ID: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1001190459-1126534341=:5000"
Content-ID: <Pine.BSO.4.62.0509121612490.5000@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1001190459-1126534341=:5000
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0509121612491.5000@rudy.mif.pg.gda.pl>


Hardware: Sun E250 SMP (2x400MHz), 1.5GB RAM.
Kernel: 2.6.12-1.1505sp3 (from Aurora corona repo).

On first it looks like stack or buffer-cache corruption.

  Slab corruption: (Not tainted) start=fffff8005d9be708, len=808
  Redzone: 0x5a2cf071/0x5a2cf071.
  Last user: [destroy_inode+100/144](destroy_inode+0x64/0x90)
  Call Trace:
   [00000000004759f4] free_block+0x160/0x1b4
   [0000000000475bb8] cache_flusharray+0x98/0x128
   [0000000000475704] kmem_cache_free+0x68/0x94
   [00000000004a56c4] destroy_inode+0x64/0x90
   [00000000004a68f4] dispose_list+0xf0/0x12c
   [00000000004a6af8] shrink_icache_memory+0x1c8/0x22c
   [0000000000478c74] shrink_slab+0xc8/0x148
   [000000000047a298] kswapd+0x2ec/0x42c
   [0000000000415800] kernel_thread+0x30/0x48
  [0000000000714dc8] kswapd_init+0x24/0x6c
  090: 6b 6b 6b 6b 6b 6b 6b 6b ff ff f8 00 5d 17 61 50
  Prev obj: start=fffff8005d9be3c8, len=808
  Redzone: 0x5a2cf071/0x5a2cf071.
  Last user: [destroy_inode+100/144](destroy_inode+0x64/0x90)
  000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
  010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
  Next obj: start=fffff8005d9bea48, len=808
  Redzone: 0x5a2cf071/0x5a2cf071.
  Last user: [destroy_inode+100/144](destroy_inode+0x64/0x90)
  000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
  010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1001190459-1126534341=:5000--
