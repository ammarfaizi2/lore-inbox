Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136263AbRAJTFT>; Wed, 10 Jan 2001 14:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136265AbRAJTFJ>; Wed, 10 Jan 2001 14:05:09 -0500
Received: from [24.65.192.120] ([24.65.192.120]:63731 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S136234AbRAJTEy>;
	Wed, 10 Jan 2001 14:04:54 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101101904.f0AJ4St12593@webber.adilger.net>
Subject: Re: EXT2-fs error in 2.4.0
In-Reply-To: <20010110171535.A206@elektroni.ee.tut.fi> "from Petri Kaukasoina
 at Jan 10, 2001 05:15:35 pm"
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Date: Wed, 10 Jan 2001 12:04:28 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> Got these in 2.4.0. Sorry if it's a known problem: I haven't been following
> the list very closely. This is a 100 MHz pentium and the kernel was compiled
> with gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release). After
> booting to 2.2.latest.latest fsck did its fscking without telling anything.
> 
> Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 779318387, count = 1 
> Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1600484464, count = 1 
> Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1852403827, count = 1 
> Jan 10 16:28:22 elektroni kernel: EXT2-fs error (device ide0(3,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1801678700, count = 1 

Decoding the first few words to hex, then ASCII gives
sts.pte_spinlock
#define pgtable_cache_size      (pgt_quicklists.pgtable_cache_sz)
#define pgd_

and I it continues.  The defines are from include/asm-sparc/pgalloc.h
and it is possible the first few words are out-of-order frees of indirect
blocks or something.  In any case, were you just untarring a 2.4 kernel
tree at the time of this problem?  That would be a bad thing, since it
would point to a bug still in the 2.4.0 kernel.

Alternately, were you just rm -r an old kernel tree?  Is it possible you
have not fsck'd this filesystem since running one of 2.4.0-test10 through
2.4.0-test12 (or maybe even test13)?  In this case, it is possible that
the filesystem was corrupted with the older kernels, but you just didn't
notice it if it was in an unused kernel tree.

The sequence of events leading to this bug would help a great deal...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
