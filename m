Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbQJ0IbP>; Fri, 27 Oct 2000 04:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbQJ0Ia4>; Fri, 27 Oct 2000 04:30:56 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:60164 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129137AbQJ0Iay>; Fri, 27 Oct 2000 04:30:54 -0400
Date: Fri, 27 Oct 2000 02:27:34 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test10-pre6
Message-ID: <20001027022734.A3000@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.10.10010262345530.1231-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10010262345530.1231-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Oct 26, 2000 at 11:58:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 11:58:03PM -0700, Linus Torvalds wrote:
> 
> Thanks to everybody who has been testing.
> 
> pre6 has tons of small fixes, the most noticeable of which are
> 
>  (a) the new compiler requirements (sorry, but it turned out that 2.7.2.3
>      really is too subtly broken with named structure initializers that
>      are very heavily used these days inside the kernel)
> 
>      Suggested stable compiler: gcc-2.91.66, aka egcs-1.1.2, which is the
>      one most vendors have been shipping for a long time, and while sure
>      to be buggy too has not been found to be seriously so at least yet.
> 
>      Other modern gcc versions may well work too.
> 
>  (b) various PCI fixes that used to make 2.4.0 completely unboot/usable on
>      certain machines (ALI chipsets with certain PIRQ routing tables and
>      laptops with some docking bridges. Oh, and PIIX4 chipsets with USB
>      enabled and certain other magic things going on).
> 
>      Let's hope that there aren't too many more of these. The ALI one in
>      particular was "interesting" to chase down. More interesting than I
>      personally need in my old age.
> 
> The rest of the changes should be mostly unnoticeable.
> 
> Still known: the same old "page->mapping = NULL" thing that has not seen
> an acceptable fix yet. If it wasn't for that, I'd have called this test10

Almost ready to ship.  I have not seen this bug show up here in any 2.4 
kernel I have tested.  Wonder if it's specific to certain hardware 
(Paging or stale TLB bug?).

> already and be done with it. Super-Al to the rescue (and no, that was not
> a reference to the current sad state of US politics).

(not meant to offend) Al Gore's definition of a family unit in America
is the same as Clinton's -- a family can be defined as a man and a goat.
There's some web sites showing that in 1988 and 1989, Al Gore was an
extreme right wing conservative.  Things have sure changed ....

:-)

Jeff


> 
> 		Linus
> 
> -----
> 
>  - pre6:
>     - Jeremy Fitzhardinge: autofs4 expiry fix
>     - David Miller: sparc driver updates, networking updates
>     - Mathieu Chouquet-Stringer: buffer overflow in sg_proc_dressz_write
>     - Ingo Molnar: wakeup race fix (admittedly the window was basically
>       non-existent, but still..)
>     - Rasmus Andersen: notice that "this_slice" is no longer used for
>       scheduling - delete the code that calculates it.
>     - ALI pirq routing update. It's even uglier than we initially thought..
>     - Dimitrios Michailidis: fix ipip locking bugs
>     - Various: face it - gcc-2.7.2.3 miscompiles structure initializers.
>     - Paul Cassella: locking comments on dev_base
>     - Trond Myklebust: NFS locking atomicity. refresh inode properly.
>     - Andre Hedrick: Serverworks Chipset driver, IDE-tape fix
>     - Paul Gortmaker: kill unused code from 8390 support.
>     - Andrea Arcangeli: fix nfsv3d wrong truncates over 4G
>     - Maciej W. Rozycki: PIIX4 needs the same USB quirk handling as PIIX3.
>     - me: if we cannot figure out the PCI bridge windows, just "inherit"
>       the window from the parent. Better than not booting.
>     - Ching-Ling Lee: ALI 5451 Audio core support update
> 
>  - pre5:
>     - Mikael Pettersson: more Pentium IV cleanup.
>     - David Miller: non-x86 platforms missed "pte_same()".
>     - Russell King: NFS invalidate_inode_pages() can do bad things!
>     - Randy Dunlap: usb-core.c is gone - module fix
>     - Ben LaHaise: swapcache fixups for the new atomic pte update code
>     - Oleg Drokin: fix nm256_audio memory region confusion
>     - Randy Dunlap: USB printer fixes
>     - David Miller: sparc updates
>     - David Miller: off-by-one error in /proc socket dumper
>     - David Miller: restore non-local bind() behaviour.
>     - David Miller: wakeups on socket shutdown()
>     - Jeff Garzik: DEPCA net drvr fixes and CodingStyle
>     - Jeff Garzik: netsemi net drvr fix
>     - Jeff Garzik & Andrea Arkangeli: keyboard cleanup
>     - Jeff Garzik: VIA audio update
>     - Andrea Arkangeli: mxcsr initialization cleanup and fix
>     - Gabriel Paubert: better twd_i387_to_fxsr() emulation
>     - Andries Brouwer: proper error return in ext2 mkdir()
> 
>  - pre4:
>     - disable writing to /proc/xxx/mem. Sure, it works now, but it's still
>       a security risk.
>     - IDE driver update (Victroy66 SouthBridge support)
>     - i810 rng driver cleanup
>     - fix sbus Makefile
>     - named initializers in module..
>     - ppoe: remove explicit initializer - it's done with initcalls.
>     - x86 WP bit detection: do it cleanly with exception handling
>     - Arnaldo Carvalho de Melo: memory leaks in drivers/media/video
>     - Bartlomiej Zolnierkiewicz: video init functions get __init
>     - David Miller: get rid of net/protocols.c - they get to initialize themselves
>     - David Miller: get rid of dev_mc_lock - we hold dev->xmit_lock anyway.
>     - Geert Uytterhoeven: Zorro (Amiga) bus support update
>     - David Miller: work around gcc-2.7.2 bug
>     - Geert Uytterhoeven: mark struct consw's "const".
>     - Jeff Garzik: network driver cleanups, ns558 joystick driver oops fix
>     - Tigran Aivazian: clean up __alloc_pages(), kill_super() and
>       notify_change()
>     - Tigran Aivazian: move stuff from .data to .bss
>     - Jeff Garzik: divert.h typename cleanups
>     - James Simmons: mdacon using spinlocks
>     - Tigran Aivazian: fix BFS free block calculation
>     - David Miller: sparc32 works again
>     - Bernd Schmidt: fix undefined C code (set/use without a sequence point)
>     - Mikael Pettersson: nicer Pentium IV setup handling.
>     - Georg Acher: usb-uhci cpia oops fix
>     - Kanoj Sarcar: more node_data cleanups for [non]NUMA.
>     - Richard Henderson: alpha update to new vmalloc setup
>     - Ben LaHaise: atomic pte updates (don't lose dirty bit)
>     - David Brownell: ohci memory debugging (== use separate slabs for allocation)
> 
>  - pre3:
>     - update email address of Joerg Reuter
>     - Andries Brouwer: spelling fixes, missing atari brelse(), breada() fix
>     - Geert Uytterhoeven: used named initializers for "struct console".
>     - Carsten Paeth: ISDN capifs - iput() only once.
>     - Petr Vandrovec: VFAT short name generation fix
>     - Jeff Garzik: i810_rng cleanup, and i815 chipset added.
>     - Bartlomiej Zolnierkiewicz: clean up some remaining old-style Makefiles
>     - Dave Jones: x86 setup fixes (recognize Pentium IV etc).
>     - x86: do the "fast A20" setup too in setup.S
>     - NIIBE Yutaka: update SuperH for the global page table (vmalloc) change.
>     - David Miller: sparc updates (vmalloc stuff still pending)
>     - David Miller: CodaFS warnings and 64-bit warnings in pci_size()
>     - David Miller: pcnet32 - correct NULL test
>     - David Miller: vmlist lock -> page_table_lock clarification
>     - Trond Myklebust: Ouch. rpcauth_lookup_credcache() memory corruption bug
>     - Matthew Wilcox: file locking cleanups
>     - David Woodhouse: USB audio spinlock fixes
>     - Torben Mathiasen: tlan driver cleanups
>     - Randy Dunlap: Yenta: CACHE_LINE_SIZE is in dwords, not bytes.
>     - Randy Dunlap: more USB updates
>     - Kanoj Sarcar: clean up the NUMA interfaces (pg_data instead of nodes)
>     - "save_fpu()" was broken. Need to clear pending errors: save_init_fpu().
> 
>  - pre2:
>     - remember to change the kernel version ;)
>     - isapnp.txt bugfix
>     - ia64 update
>     - sparc update
>     - networking update (pppoe init, frame diverter, fix tcp_sendmsg,
>       fix udp_recvmsg).
>     - Compile for WinChip must _not_ use "-march=i686". It's a i586.
>     - Randy Dunlap: more USB updates
>     - clarify the Firewire AIC-5800 situation. It's not supported yet.
>     - PCI-space decode size fix. This is needed for some (broken?) hardware
>     - /proc/self/maps off-by-one error
>     - 3c501, 3c507, cs89x0 network drivers drop unnecessary check_region
>     - Asahi Kasei AK4540: new codec ID. Yamaha: new PCI ID's.
>     - ne2k-pci net driver documentation update
>     - Paul Gortmaker: delete paranoia check in rtc_exit
>     - scsi_merge: memset the right amount of memory.
>     - sun3fb: old __initfunc() not supported any more.
>     - synclink: remove unnecessary task state games
>     - xd.c: proper casting for 64-bit architectures
>     - vmalloc: page table update race condition.
> 
>  - pre1:
>     - Roger Larsson: ">=" instead of ">" to make the VM not get stuck.
>     - Gideon Glass: brw_kiovec() failure case oops fix
>     - Rik van Riel: better memory balancing and OOM killer
>     - Ivan Kokshaysky: alpha compile fixes
>     - Vojtech Pavlik: forgotten ENOUGH macro in via82cxxx ide driver
>     - Arnaldo Carvalho de Melo: acpi resource leak fix
>     - Brian Gerst: use mov's instead of xchg in kernel trap entry
>     - Torben Mathiasen: tlan timer being added twice bug
>     - Andrzej Krzysztofowicz: config file fixes
>     - Jean Tourrilhes: Wavelan lockup on SMP fix
>     - Roman Zippel: initdata must be initialized (even if it is to zero:
>       gcc is strange)
>     - Jean Tourrilhes: hp100 driver lockup at startup on SMP
>     - Russell King: fix silly minixfs uninitialized error bug
>     - (various): fix uid hashing to use "uid_t" instead of "unsigned short"
>     - Jaroslav Kysela: isapnp timeout fix. NULL ptr dereference fix.
>     - Alain Knaff: fdformat should work again.
>     - Randy Dunlap: USB - fix bluetooth, acm, printer, serial to work
>       with urb->dev changes. 
>     - Randy Dunlap: USB whiteheat serial driver firmware update.
>     - Randy Dunlap: USB hub memory corruption and pegasus driver update
>     - Andre Hedrick: IDE Makefile cleanup
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
