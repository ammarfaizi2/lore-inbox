Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133034AbRAQL5O>; Wed, 17 Jan 2001 06:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133035AbRAQL5E>; Wed, 17 Jan 2001 06:57:04 -0500
Received: from libra.cyb.it ([212.11.95.209]:48653 "EHLO relay2.flashnet.it")
	by vger.kernel.org with ESMTP id <S133034AbRAQL4o>;
	Wed, 17 Jan 2001 06:56:44 -0500
Date: Wed, 17 Jan 2001 12:54:17 +0100
From: David Santinoli <u235@libero.it>
To: linux-kernel@vger.kernel.org
Subject: Partition renumbering under 2.4.0
Message-ID: <20010117125417.A717@aidi.santinoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I've noticed that some logical partitions get different numbering under 2.2.16
and 2.4.0. Here's my /dev/hdb layout:

  hdb1: fat32
  hdb2: Solaris partition (contains 4 Solaris slices)
  hdb3: ext2
  hdb4: extended partition (contains 1 ext2 logical partition)

and here's how it gets detected by the kernels:

2.2.16:
  hdb: hdb1 hdb2 <solaris: [s0] hdb5 [s1] hdb6 [s2] hdb7 [s7] hdb8 > hdb3 hdb4 <
 hdb9 >

2.4.0:
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 >
 hdb2: <solaris: [s0] hdb6 [s1] hdb7 [s2] hdb8 [s7] hdb9 >

Note that the ext2 logical partition is called "hdb9" by 2.2.16 and "hdb5" by
2.4.0.
This makes it difficult to manage multi-boot systems with 2.2.x and 2.4.x
kernels, as it requires updating fstab between boots. Switching to other
identification strategies such as ext2 labels - as discussed in other threads -
could be a workaround, as far as I know.

Cheers,
 David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
