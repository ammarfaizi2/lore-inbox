Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271906AbRIIFXi>; Sun, 9 Sep 2001 01:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271905AbRIIFX2>; Sun, 9 Sep 2001 01:23:28 -0400
Received: from [24.0.95.84] ([24.0.95.84]:49086 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271906AbRIIFXQ>; Sun, 9 Sep 2001 01:23:16 -0400
Message-ID: <3B9AFE23.ACB3023E@home.com>
Date: Sun, 09 Sep 2001 01:29:07 -0400
From: John Kacur <jkacur@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en, ru, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre6, NTFS build break
In-Reply-To: <Pine.LNX.4.33.0109081949510.1097-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Most noticeable (except perhaps for the NTFS update if you're a NTFS user)
> is that the broken bootdata patch that could cause some spurious MM
> corruption due to a double page free of the bootdata got reverted. This is
> the one that caused BUG reports from mm/page_alloc.c..
> 
> Changelog appended..
> 
>                 Linus
> 
> -----
> pre6:
>  - Jens Axboe: remove trivially dead io_request_lock usage
>  - Andrea Arcangeli: softirq cleanup and ARM fixes. Slab cleanups
>  - Christoph Hellwig: gendisk handling helper functions/cleanups
>  - Nikita Danilov: reiserfs dead code pruning
>  - Anton Altaparmakov: NTFS update to 1.1.18
>  - firestream network driver: patch reverted on authors request
>  - NIIBE Yutaka: SH architecture update
>  - Paul Mackerras: PPC cleanups, PPC8xx update.
>  - me: reverse broken bootdata allocation patch that went into pre5
> 
> pre5:
>  - Merge with Alan
>  - Trond Myklebust: NFS fixes - kmap and root inode special case
>  - Al Viro: more superblock cleanups, inode leak in rd.c, minix
>    directories in page cache
>  - Paul Mackerras: clean up rubbish from sl82c105.c
>  - Neil Brown: md/raid cleanups, NFS filehandles
>  - Johannes Erdfelt: USB update (usb-2.0 support, visor fix, Clie fix,
>    pl2303 driver update)
>  - David Miller: sparc and net update
>  - Eric Biederman: simplify and correct bootdata allocation - don't
>    overwrite ramdisks
>  - Tim Waugh: support multiple SuperIO devices, parport doc updates
> 
> pre4:
>  - Hugh Dickins: swapoff cleanups and speedups
>  - Matthew Dharm: USB storage update
>  - Keith Owens: Makefile fixes
>  - Tom Rini: MPC8xx build fix
>  - Nikita Danilov: reiserfs update
>  - Jakub Jelinek: ELF loader fix for ET_DYN
>  - Andrew Morton: reparent_to_init() for kernel threads
>  - Christoph Hellwig: VxFS and SysV updates, vfs_permission fix
> 
> pre3:
>  - Johannes Erdfelt, Oliver Neukum: USB printer driver race fix
>  - John Byrne: fix stupid i386-SMP irq stack layout bug
>  - Andreas Bombe, me: yenta IO window fix
>  - Neil Brown: raid1 buffer state fix
>  - David Miller, Paul Mackerras: fix up sparc and ppc respectively for kmap/kbd_rate
>  - Matija Nalis: umsdos fixes, and make it possible to boot up with umsdos
>  - Francois Romieu: fix bugs in dscc4 driver
>  - Andy Grover: new PCI config space access functions (eventually for ACPI)
>  - Albert Cranford: fix incorrect e2fsprog data from ver_linux script
>  - Dave Jones: re-sync x86 setup code, fix macsonic kmalloc use
>  - Johannes Erdfelt: remove obsolete plusb USB driver
>  - Andries Brouwer: fix USB compact flash version info, add blksize ioctls
> 
> pre2:
>  - Al Viro: block device cleanups
>  - Marcelo Tosatti: make bounce buffer allocations more robust (it's ok
>    for them to do IO, just not cause recursive bounce IO. So allow them)
>  - Anton Altaparmakov: NTFS update (1.1.17)
>  - Paul Mackerras: PPC update (big re-org)
>  - Petko Manolov: USB pegasus driver fixes
>  - David Miller: networking and sparc updates
>  - Trond Myklebust: Export atomic_dec_and_lock
>  - OGAWA Hirofumi: find and fix umsdos "filldir" users that were broken
>    by the 64-bit-cleanups. Fix msdos warnings.
using egcs-2.91.66
line 25 of fs/ntfs/support.h
#define ntfs_debug(mask, fmt, ...)	do {} while (0)
causes a build break because "..." is not valid in the identifier-list
of a #define.

Perhaps this can just be turned into
static inline ntfs_debug(mask, fmt, ...)	do {} while(0)

or is something else required?
