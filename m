Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbQL1U4I>; Thu, 28 Dec 2000 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131256AbQL1Uz6>; Thu, 28 Dec 2000 15:55:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7437 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129913AbQL1Uzz>; Thu, 28 Dec 2000 15:55:55 -0500
Date: Thu, 28 Dec 2000 12:25:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test13-pre5
Message-ID: <Pine.LNX.4.10.10012281220470.17769-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The main notables are the network fixes (uninitialized skb->dev could and
did cause oopses in ip_defrag) and the mm fixes (dirty pages without
mappings etc, causing problems in page_launder).

The mm cleanups also include removing "swapout()" as a VM operation, as
nobody can sanely do anything more than just marking the page dirty anyway
(the real work is done by writepage() these days), and doing that
explicitly simplifies VM scanning considerably.

This still doesn't tell "sync()" about dirty pages (ie the "innd loses the
active file after a reboot" bug), but now the places that mark pages dirty
are under control. Next step..

		Linus

-----

 - pre5:
   - NIIBE Yutaka: SuperH update
   - Geert Uytterhoeven: m68k update
   - David Miller: TCP RTO calc fix, UDP multicast fix etc
   - Duncan Laurie: ServerWorks PIRQ routing definition.
   - mm PageDirty cleanups, added sanity checks, and don't lose the bit. 

 - pre4:
   - Christoph Rohland: shmfs cleanup
   - Nicolas Pitre: don't forget loop.c flags
   - Geert Uytterhoeven: new-style m68k Makefiles
   - Neil Brown: knfsd cleanups, raid5 re-org
   - Andrea Arkangeli: update to LVM-0.9
   - LC Chang: sis900 driver doc update
   - David Miller: netfilter oops fix
   - Andrew Grover: acpi update

 - pre3:
   - Christian Jullien: smc9194: proper dev_kfree_skb_irq
   - Cort Dougan: new-style PowerPC Makefiles
   - Andrew Morton, Petr Vandrovec: fix run_task_queue
   - Christoph Rohland: shmfs for shared memory handling

 - pre2:
   - Kai Germaschewski: ISDN update (including Makefiles)
   - Jens Axboe: cdrom updates
   - Petr Vandrovec; Matrox G450 support
   - Bill Nottingham: fix FAT32 filesystems on 64-bit platforms
   - David Miller: sparc (and other) Makefile fixup
   - Andrea Arkangeli: alpha SMP TLB context fix (and cleanups)
   - Niels Kristian Bech Jensen: checkconfig, USB warnings
   - Andrew Grover: large ACPI update

 - pre1:
   - me: drop support for old-style Makefiles entirely. Big.
   - me: check b_end_io at the IO submission path
   - me: fix "ptep_mkdirty()" (so that swapoff() works correctly)
   - fix fault case in copy_from_user() with a constant size, where
     ((size & 3) == 3)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
