Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQKLDWn>; Sat, 11 Nov 2000 22:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbQKLDWe>; Sat, 11 Nov 2000 22:22:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33040 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129930AbQKLDWW> convert rfc822-to-8bit; Sat, 11 Nov 2000 22:22:22 -0500
Date: Sat, 11 Nov 2000 19:22:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test11-pre3
Message-ID: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id TAA23909
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Drivers, drivers, drivers. IrDA and ISDN. PPC.

The most interesting part is probably the exclusive wait-queue patch.
David Miller noticed that exclusivity doesn't nest correctly the way we
used to do it: being on multiple wait-queues would potentially cause lost
wake-up events if a non-exclusive waiter got mistaken for an exclusive one
because the exclusive bit was a per-process thing.

Moving the exclusivity bit from the process into the wait-queue cleaned up
the interfaces and also made it nest properly.

No known uses were actually buggy, but at least one case was apparently ok
only by pure luck. 

		Linus

-----
 - pre3:
    - James Simmons: vgacon "printk()" deadlock with global irq lock.
    - don't poke blanked console on console output
    - Ching-Ling: get channels right on ALI audio driver
    - Dag Brattli and Jean Tourrilhes: big IrDA update
    - Paul Mackerras: PPC updates
    - Randy Dunlap: USB ID table support, LEDs with usbkbd, belkin
      serial converter. 
    - Jeff Garzik: pcnet32 and lance net driver fix/cleanup
    - Mikael Pettersson: clean up x86 ELF_PLATFORM
    - Bartlomiej Zolnierkiewicz: sound and drm driver init fixes and
      cleanups
    - Al Viro: Jeff missed some kmap()'s. sysctl cleanup
    - Kai Germaschewski: ISDN updates
    - Alan Cox: SCSI driver NULL ptr checks
    - David Miller: networking updates, exclusive waitqueues nest properly,
      SMP i_shared_lock/page_table_lock lock order fix.

 - pre2:
    - Stephen Rothwell: directory notify could return with the lock held
    - Richard Henderson: CLOCKS_PER_SEC on alpha.
    - Jeff Garzik: ramfs and highmem: kmap() the page to clear it
    - Asit Mallick: enable the APIC in the official order
    - Neil Brown: avoid rd deadlock on io_request_lock by using a
      private rd-request function. This also avoids unnecessary
      request merging at this level.
    - Ben LaHaise: vmalloc threadign and overflow fix
    - Randy Dunlap: USB updates (plusb driver). PCI cacheline size.
    - Neil Brown: fix a raid1 on top of lvm bug that crept in in pre1
    - Alan Cox: various (Athlon mmx copy, NULL ptr checks for
      scsi_register etc). 
    - Al Viro: fix /proc permission check security hole.
    - Can-Ru Yeou: SiS301 fbcon driver
    - Andrew Morton: NMI oopser and kernel page fault punch through
      both console_lock and timerlist_lock to make sure it prints out..
    - Jeff Garzik: clean up "kmap()" return type (it returns a kernel
      virtual address, ie a "void *").
    - Jeff Garzik: network driver docs, various one-liners.
    - David Miller: add generic "special" flag to page flags, to be
      used by architectures as they see fit. Like keeping track of
      cache coherency issues.
    - David Miller: sparc64 updates, make sparc32 boot again
    - Davdi Millner: spel "synchronous" correctly
    - David Miller: networking - fix some bridge issues, and correct
      IPv6 sysctl entries.
    - Dan Aloni: make fork.c use proper macro rather than doing
      get_exec_domain() by hand. 

 - pre1:
    - me: make PCMCIA work even in the absense of PCI irq's
    - me: add irq mapping capabilities for Cyrix southbridges
    - me: make IBMMCA compile right as a module
    - me: uhhuh. Major atomic-PTE SMP race boo-boo. Fixed.
    - Andrea Arkangeli: don't allow people to set security-conscious
      bits in mxcsr through ptrace SETFPXREGS.
    - Jürgen Fischer: aha152x update
    - Andrew Morton, Trond Myklebust: file locking fixes
    - me: TLB invalidate race with highmem
    - Paul Fulghum: synclink/n_hdlc driver updates
    - David Miller: export sysctl_jiffies, and have the proper no-sysctl
      version handy
    - Neil Brown: RAID driver deadlock and nsfd read access to
      execute-only files fix
    - Keith Owens: clean up module information passing, remove
      "get_module_symbol()".
    - Jeff Garzik: network (and other) driver fixes and cleanups
    - Andrea Arkangeli: scheduler cleanup.
    - Ching-Ling Li: fix ALi sound driver memory leak
    - Anton Altaparmakov: upcase fix for NTFS
    - Thomas Woller: CS4281 audio update

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
