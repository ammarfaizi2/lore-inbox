Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272233AbRIKAuP>; Mon, 10 Sep 2001 20:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272234AbRIKAuE>; Mon, 10 Sep 2001 20:50:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2053 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272233AbRIKAtp>; Mon, 10 Sep 2001 20:49:45 -0400
Date: Mon, 10 Sep 2001 17:49:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.10-pre8
Message-ID: <Pine.LNX.4.33.0109101745440.1145-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The most noticeable thing here is how the three-argument form of
"min()/max()" are a thing of the past, and instead we have a regular
two-argument form that is _really_ anal about type-checking. It will warn
if the two arguments are of different types.

The old three-argument form is still available as "min_t()/max_t()", and
pretty much all old three-argument users have just been moved over to this
one. For all the people who hate the three-argument version, if you send
patches to turn things into the two-argument one, I'll certainly apply
them. I only ask that you verify that you don't get any warnings in the
process..

(And the number of type clashes was quite surprising. A lot of the users
of min/max I looked at looked rather suspicious and definitely did NOT
have the same types or even signs).

Other minor changes too.

		Linus

-----
pre8:
 - Christoph Hellwig: clean up personality handling a bit
 - Robert Love: update sysctl/vm documentation
 - make the three-argument (that everybody hates) "min()" be "min_t()",
   and introduce a type-anal "min()" that complains about arguments of
   different types.

pre7:
 - Alan Cox: big driver/mips sync
 - Andries Brouwer, Christoph Hellwig: more gendisk fixups
 - Tobias Ringstrom: tulip driver workaround for DC21143 erratum

pre6:
 - Jens Axboe: remove trivially dead io_request_lock usage
 - Andrea Arcangeli: softirq cleanup and ARM fixes. Slab cleanups
 - Christoph Hellwig: gendisk handling helper functions/cleanups
 - Nikita Danilov: reiserfs dead code pruning
 - Anton Altaparmakov: NTFS update to 1.1.18
 - firestream network driver: patch reverted on authors request
 - NIIBE Yutaka: SH architecture update
 - Paul Mackerras: PPC cleanups, PPC8xx update.
 - me: reverse broken bootdata allocation patch that went into pre5

pre5:
 - Merge with Alan
 - Trond Myklebust: NFS fixes - kmap and root inode special case
 - Al Viro: more superblock cleanups, inode leak in rd.c, minix
   directories in page cache
 - Paul Mackerras: clean up rubbish from sl82c105.c
 - Neil Brown: md/raid cleanups, NFS filehandles
 - Johannes Erdfelt: USB update (usb-2.0 support, visor fix, Clie fix,
   pl2303 driver update)
 - David Miller: sparc and net update
 - Eric Biederman: simplify and correct bootdata allocation - don't
   overwrite ramdisks
 - Tim Waugh: support multiple SuperIO devices, parport doc updates

pre4:
 - Hugh Dickins: swapoff cleanups and speedups
 - Matthew Dharm: USB storage update
 - Keith Owens: Makefile fixes
 - Tom Rini: MPC8xx build fix
 - Nikita Danilov: reiserfs update
 - Jakub Jelinek: ELF loader fix for ET_DYN
 - Andrew Morton: reparent_to_init() for kernel threads
 - Christoph Hellwig: VxFS and SysV updates, vfs_permission fix

pre3:
 - Johannes Erdfelt, Oliver Neukum: USB printer driver race fix
 - John Byrne: fix stupid i386-SMP irq stack layout bug
 - Andreas Bombe, me: yenta IO window fix
 - Neil Brown: raid1 buffer state fix
 - David Miller, Paul Mackerras: fix up sparc and ppc respectively for kmap/kbd_rate
 - Matija Nalis: umsdos fixes, and make it possible to boot up with umsdos
 - Francois Romieu: fix bugs in dscc4 driver
 - Andy Grover: new PCI config space access functions (eventually for ACPI)
 - Albert Cranford: fix incorrect e2fsprog data from ver_linux script
 - Dave Jones: re-sync x86 setup code, fix macsonic kmalloc use
 - Johannes Erdfelt: remove obsolete plusb USB driver
 - Andries Brouwer: fix USB compact flash version info, add blksize ioctls

pre2:
 - Al Viro: block device cleanups
 - Marcelo Tosatti: make bounce buffer allocations more robust (it's ok
   for them to do IO, just not cause recursive bounce IO. So allow them)
 - Anton Altaparmakov: NTFS update (1.1.17)
 - Paul Mackerras: PPC update (big re-org)
 - Petko Manolov: USB pegasus driver fixes
 - David Miller: networking and sparc updates
 - Trond Myklebust: Export atomic_dec_and_lock
 - OGAWA Hirofumi: find and fix umsdos "filldir" users that were broken
   by the 64-bit-cleanups. Fix msdos warnings.
 - Al Viro: superblock handling cleanups and race fixes
 - Johannes Erdfelt++: USB updates

pre1:
 - Jeff Hartmann: DRM AGP/alpha cleanups
 - Ben LaHaise: highmem user pagecopy/clear optimization
 - Vojtech Pavlik: VIA IDE driver update
 - Herbert Xu: make cramfs work with HIGHMEM pages
 - David Fennell: awe32 ram size detection improvement
 - Istvan Varadi: umsdos EMD filename bug fix
 - Keith Owens: make min/max work for pointers too
 - Jan Kara: quota initialization fix
 - Brad Hards: Kaweth USB driver update (enable, and fix endianness)
 - Ralf Baechle: MIPS updates
 - David Gibson: airport driver update
 - Rogier Wolff: firestream ATM driver multi-phy support
 - Daniel Phillips: swap read page referenced set - avoid swap thrashing

