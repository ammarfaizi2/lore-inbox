Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273747AbRIXCgw>; Sun, 23 Sep 2001 22:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273748AbRIXCgk>; Sun, 23 Sep 2001 22:36:40 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:29873 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273747AbRIXCgd>; Sun, 23 Sep 2001 22:36:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Naren Devaiah <naren.devaiah@home.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10
Date: Sun, 23 Sep 2001 19:35:02 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010924023657.XIGX23549.femail28.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After configuring with 'make menuconfig'  doing 'make bzImage'  results in a 
16K compressed kernel image.

atlantis:/usr/src/linux-2.4.10> ls -l arch/i386/boot/bzImage 
-rw-r--r--    1 root     root        18764 Sep 23 18:30 arch/i386/boot/bzImage

But the vmlinux file is about 2.2Mb

atlantis:/usr/src/linux-2.4.10> ls -l vmlinux
-rwxr-xr-x    1 root     root      2279307 Sep 23 18:30 vmlinux*

Anybody know why?

This is on a Slackware 8.0 machine.
The linux tarball was from kernel.org.

TIA
-Naren


On Sunday 23 September 2001 11:54 am, Linus Torvalds wrote:
> Ok, I released a real 2.4.10, let the fun begin..
>
> This is an uncomfortably large changeset, largely because I was away in
> Finland twice during the 2.4.9->2.4.10 development, and partly of course
> because I've tried to aggressively sync up especially with Alan.
>
> In addition to the VM changes that have gotten so much attention there are
> architecture updates, various major filesystem updates (jffs2 and NTFS),
> ACPI updates, and tons of driver merges. And, of course, the min()/max()
> changes.
>
> Give it hell,
>
> 		Linus
>
> -----
> final:
>  - Andrew Grover: ACPI update
>  - Al Viro: block devices..
>  - Andrea Arcangeli: fix list manipulation bogosity
>  - Trond Myklebust: 64-bit file locking fixes
>  - Brad Hards: USB CDC ethernet
>  - Chris Mason: reiserfs speedup
>  - Robert Love: re-merge AMD 761 GART support that was lost in -ac merge
>  - Adam Richter: check pci_module_init() return value
>
> pre15:
>  - Jan Harkes: make Coda work with arbitrary host filesystems, not
>    just filesystems that use generic_file_read/write
>  - Al Viro: block device cleanups
>  - Hugh Dickins: swap device lock fixes - fix swap readahead race
>  - me, Andrea: more reference bit cleanups
>
> pre14:
>  - Richard Gooch: devfs update
>  - Andrea Arcangeli: clean up/fix ramdisk handling now that it's in page
> cache - Al Viro: follow up the above with initrd cleanups
>  - Keith Owens: get rid of drivers/scsi/53c700-mem.c file
>  - Trond Myklebust: RPC over TCP race fix
>  - Greg KH: USB update (ohci understands USB_ZERO_PACKET)
>  - me: clean up reference bit handling, fix silly GFP_ATOMIC allocation bug
>
> pre13:
>  - Manfred Spraul: /proc/pid/maps cleanup (and bugfix for non-x86)
>  - Al Viro: "block device fs" - cleanup of page cache handling
>  - Hugh Dickins: VM/shmem cleanups and swap search speedup
>  - David Miller: sparc updates, soc driver typo fix, net updates
>  - Jeff Garzik: network driver updates (dl2k, yellowfin and tulip)
>  - Neil Brown: knfsd cleanups and fixues
>  - Ben LaHaise: zap_page_range merge from -ac
>
> pre12:
>  - Alan Cox: much more merging
>  - Pete Zaitcev: ymfpci race fixes
>  - Andrea Arkangeli: VM race fix and OOM tweak.
>  - Arjan Van de Ven: merge RH kernel fixes
>  - Andi Kleen: use more readable 'likely()/unlikely()' instead of
> __builtin_expect() - Keith Owens: fix 64-bit ELF types
>  - Gerd Knorr: mark more broken PCI bridges, update btaudio driver
>  - Paul Mackerras: powermac driver update
>  - me: clean up PTRACE_DETACH to use common infrastructure
>
> pre11:
>  - Neil Brown: md cleanups/fixes
>  - Andrew Morton: console locking merge
>  - Andrea Arkangeli: major VM merge
>
> pre10:
>  - Alan Cox: continued merging
>  - Mingming Cao: make msgrcv/shmat check the queue/segment ID's properly
>  - Greg KH: USB serial init failure fix, Xircom serial converter driver
>  - Neil Brown: nsfd/raid/md/lockd cleanups
>  - Ingo Molnar: multipath RAID personality, raid xor update
>  - Hugh Dickins/Marcelo Tosatti: swapin read-ahead race fix
>  - Vojtech Pavlik: fix up some of the infrastructure for x86-64
>  - Robert Love: AMD 761 AGP GART support
>  - Jens Axboe: fix SCSI-generic queue handling race
>  - me: be sane about page reference bits
>
> pre9:
>  - Greg KH: start migration to new "min()/max()"
>  - Roman Zippel: move affs over to "min()/max()".
>  - Vojtech Pavlik: VIA update (make sure not to IRQ-unmask a vt82c576)
>  - Jan Kara: quota bug-fix (don't decrement quota for non-counted inode)
>  - Anton Altaparmakov: more NTFS updates
>  - Al Viro: make nosuid/noexec/nodev be per-mount flags, not per-filesystem
>  - Alan Cox: merge input/joystick layer differences, driver and alpha merge
>  - Keith Owens: scsi Makefile cleanup
>  - Trond Myklebust: fix oopsable race in locking code
>  - Jean Tourrilhes: IrDA update
>
> pre8:
>  - Christoph Hellwig: clean up personality handling a bit
>  - Robert Love: update sysctl/vm documentation
>  - make the three-argument (that everybody hates) "min()" be "min_t()",
>    and introduce a type-anal "min()" that complains about arguments of
>    different types.
>
> pre7:
>  - Alan Cox: big driver/mips sync
>  - Andries Brouwer, Christoph Hellwig: more gendisk fixups
>  - Tobias Ringstrom: tulip driver workaround for DC21143 erratum
>
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
>  - David Miller, Paul Mackerras: fix up sparc and ppc respectively for
> kmap/kbd_rate - Matija Nalis: umsdos fixes, and make it possible to boot up
> with umsdos - Francois Romieu: fix bugs in dscc4 driver
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
>  - Al Viro: superblock handling cleanups and race fixes
>  - Johannes Erdfelt++: USB updates
>
> pre1:
>  - Jeff Hartmann: DRM AGP/alpha cleanups
>  - Ben LaHaise: highmem user pagecopy/clear optimization
>  - Vojtech Pavlik: VIA IDE driver update
>  - Herbert Xu: make cramfs work with HIGHMEM pages
>  - David Fennell: awe32 ram size detection improvement
>  - Istvan Varadi: umsdos EMD filename bug fix
>  - Keith Owens: make min/max work for pointers too
>  - Jan Kara: quota initialization fix
>  - Brad Hards: Kaweth USB driver update (enable, and fix endianness)
>  - Ralf Baechle: MIPS updates
>  - David Gibson: airport driver update
>  - Rogier Wolff: firestream ATM driver multi-phy support
>  - Daniel Phillips: swap read page referenced set - avoid swap thrashing
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
