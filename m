Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161724AbWKPEVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161724AbWKPEVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 23:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162282AbWKPEVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 23:21:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161724AbWKPEVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 23:21:05 -0500
Date: Wed, 15 Nov 2006 20:21:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.19-rc6
Message-ID: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 there's nothing earth-shattering here (and there shouldn't be), but we've 
hopefully made good progress on the regression list (and thanks again to 
Adrian Bunk for reminding people, especially when they thought *cough* 
that some particular regression had already been fixed)..

So with -rc6, we hopefully should leave the irq-related regressions behind 
us. There were issues both with devices that started enabling MSI (which 
seem to trigger hardware bugs, although there's also been discussion about 
what we should do to make things safer) and with the new genirq layer that 
showed problems with edge-triggered irq's (notably legacy ISA interrupts, 
or, more commonly these days, the 16-bit PCMCIA interrupts that are 
basically just ISA in another formfactor).

Thanks for everybody involved in whittling down that regression list.

Also, apart from the regression tracking, we've had some other updates, eg 
infiniband and DVB fixes, network driver fixes, some networking fixes etc.

The ShortLog is appended, and gives a mostly readable picture of what has 
been going on. But the main thing to take away is: regressions fixed, and 
not a whole lot of changes since -rc5 (it may not look that way, but a lot 
of these things are essentially one-liners or close to it, so the total 
diff between -rc5 and -rc6 is actually just about 5k lines, which is not 
a whole lot, considering).

		Linus

---
Aaron Durbin (1):
      x86-64: Fix partial page check to ensure unusable memory is not being marked usable.

Adrian Bunk (2):
      bcm43xx: Add error checking in bcm43xx_sprom_write()
      drivers/telephony/ixj: fix an array overrun

Alan Cox (1):
      hpt37x: Check the enablebits

Alan Stern (1):
      SCSI core: always store >= 36 bytes of INQUIRY data

Alasdair G Kergon (2):
      dm: fix find_device race
      dm: suspend: fix error path

Alexey Dobriyan (4):
      ipmi_si_intf.c: fix "&& 0xff" typos
      V4L/DVB (4795): Tda826x: use correct max frequency
      V4L/DVB (4818): Flexcop-usb: fix debug printk
      pata_artop: fix "& (1 >>" typo

Andi Kleen (6):
      Revert "MMCONFIG and new Intel motherboards"
      x86-64: Fix PTRACE_[SG]ET_THREAD_AREA regression with ia32 emulation.
      x86-64: Handle reserve_bootmem_generic beyond end_pfn
      x86: Add acpi_user_timer_override option for Asus boards
      x86-64: Fix vgetcpu when CONFIG_HOTPLUG_CPU is disabled
      x86-64: Fix race in exit_idle

Andrew Morton (2):
      setup_irq(): better mismatch debugging
      revert "PCI: quirk for IBM Dock II cardbus controllers"

Arjan van de Ven (1):
      Regression in 2.6.19-rc microcode driver

Benjamin Herrenschmidt (2):
      [POWERPC] Fix cell "new style" mapping and add debug
      powerpc: windfarm shall request it's sub modules

Brian King (1):
      libata: Convert from module_init to subsys_initcall

Bryan O'Sullivan (1):
      IB/ipath - program intconfig register using new HT irq hook

Chris Lalancette (1):
      [NETPOLL]: Compute checksum properly in netpoll_send_udp().

Corey Minyard (3):
      IPMI: Clean up the waiting message queue properly on unload
      IPMI: retry messages on certain error returns
      IPMI: Fix more && typos

Daniel Ritz (1):
      fix via586 irq routing for pirq 5

Darrick J. Wong (1):
      libata: fix double-completion on error

David Brownell (1):
      usb: MAINTAINERS updates

David Chinner (3):
      [XFS] Clean up i_flags and i_flags_lock handling.
      [XFS] Prevent a deadlock when xfslogd unpins inodes.
      [XFS] Remove KERNEL_VERSION macros from xfs_dmapi.h

David Gibson (1):
      hugetlb: check for brk() entering a hugepage region

David Miller (1):
      pci: don't try to remove sysfs files before they are setup.

David Rientjes (1):
      drivers cris: return on NULL dev_alloc_skb()

Eric Dumazet (1):
      vmalloc: optimization, cleanup, bugfixes

Eric W. Biederman (4):
      sysctl: Undeprecate sys_sysctl
      htirq: refactor so we only have one function that writes to the chip
      htirq: allow buggy drivers of buggy hardware to write the registers
      Use delayed disable mode of ioapic edge triggered interrupts

Franck Bui-Huu (1):
      .gitignore: add miscellaneous files

Geoff Levand (1):
      [POWERPC] cell: set ARCH_SPARSEMEM_DEFAULT in Kconfig

Herbert Xu (1):
      [NET]: Set truesize in pskb_copy

Hermann Pitton (1):
      V4L/DVB (4802): Cx88: fix remote control on WinFast 2000XP Expert

Hoang-Nam Nguyen (3):
      IB/ehca: Assure 4K alignment for firmware control blocks
      IB/ehca: Use named constant for max mtu
      IB/ehca: Activate scaling code by default

Hugh Dickins (2):
      hugetlb: prepare_hugepage_range check offset too
      hugetlb: fix error return for brk() entering a hugepage region

Ian Kent (1):
      autofs4: panic after mount fail

J. Bruce Fields (3):
      nfsd4: reindent do_open_lookup()
      nfsd4: fix open-create permissions
      nfsd: fix spurious error return from nfsd_create in async case

Jean Delvare (2):
      V4L/DVB (4817): Fix uses of "&&" where "&" was intended
      RDMA/amso1100: Fix && typo

Jeff Garzik (1):
      [libata] sata_via: fix obvious typo

Jens Axboe (4):
      Fix bad data direction in SG_IO
      ide-cd: only set rq->errors SCSI style for block pc requests
      cciss: fix iostat
      cpqarray: fix iostat

Jes Sorensen (1):
      mspec driver build fix

Jiri Slaby (2):
      [NET]: kconfig, correct traffic shaper
      Char: isicom, fix close bug

John Heffner (1):
      [TCP]: Don't use highmem in tcp hash size calculation.

John Rose (1):
      [POWERPC] pseries: Force 4k update_flash block and list sizes

Jonathan E Brassow (2):
      dm: multipath: fix rr_add_path order
      dm: raid1: fix waiting for io on suspend

Julian Anastasov (1):
      [IPVS]: More endianness fixed.

Kalle Pokki (2):
      [POWERPC] CPM_UART: Fix non-console transmit
      [POWERPC] CPM_UART: Fix non-console initialisation

KAMEZAWA Hiroyuki (1):
      ia64: select ACPI_NUMA if ACPI

Linus Torvalds (6):
      Revert "i386: Add MMCFG resources to i386 too"
      x86-64: clean up io-apic accesses
      x86-64: write IO APIC irq routing entries in correct order
      [dvb saa7134] Fix missing 'break' for avermedia card case
      Revert "fix Data Acess error in dup_fd"
      Linux 2.6.19-rc6

Magnus Damm (1):
      x86-64: setup saved_max_pfn correctly (kdump)

Masami Hiramatsu (1):
      kretprobe: fix kretprobe-booster to save regs and set status

Mauro Carvalho Chehab (1):
      V4L/DVB (4804): Fix missing i2c dependency for saa7110

Michael Buesch (1):
      bcm43xx: Drain TX status before starting IRQs

Michael Chan (1):
      [TG3]: Fix array overrun in tg3_read_partno().

Nathan Lynch (1):
      nvidiafb: fix unreachable code in nv10GetConfig

NeilBrown (2):
      md: change ONLINE/OFFLINE events to a single CHANGE event
      md: fix sizing problem with raid5-reshape and CONFIG_LBD=n

Nicolas Kaiser (1):
      drivers/ide: stray bracket

Oleg Nesterov (1):
      A minor fix for set_mb() in Documentation/memory-barriers.txt

pasky@ucw.cz (3):
      V4L/DVB (4814): Remote support for Avermedia 777
      V4L/DVB (4815): Remote support for Avermedia A16AR
      V4L/DVB (4816): Change tuner type for Avermedia A16AR

Paul Mackerras (1):
      [POWERPC] Make sure initrd and dtb sections get into zImage correctly

Pavel Emelianov (1):
      Fix misrouted interrupts deadlocks

Peter Zijlstra (1):
      bonding: lockdep annotation

Rafael J. Wysocki (1):
      md: do not freeze md threads for suspend

Randy Dunlap (1):
      com20020 build fix

Roland Dreier (1):
      IB/mad: Fix race between cancel and receive completion

Russell King (1):
      Fix missing parens in set_personality()

Sharyathi Nagesh (1):
      fix Data Acess error in dup_fd

Simon Horman (1):
      [IPVS]: Compile fix for annotations in userland.

Stephen Hemminger (1):
      [PKT_SCHED] sch_htb: Use hlist_del_init().

Stephen Rothwell (2):
      [POWERPC] Add the thread_siblings files to sysfs
      [POWERPC] Wire up sys_move_pages

Steve French (4):
      [CIFS] NFS stress test generates flood of "close with pending write" messages
      [CIFS] Explicitly set stat->blksize
      [CIFS]  Fix mount failure when domain not specified
      [CIFS] Fix minor problem with previous patch

Steven Rostedt (1):
      x86-64: shorten the x86_64 boot setup GDT to what the comment says

Steven Whitehouse (1):
      [DECNET]: Endianess fixes (try #2)

Takashi Iwai (1):
      ALSA: hda-intel - Disable MSI support by default

Tigran Aivazian (1):
      Tigran has moved

Tim Shimmin (1):
      [XFS] Keep lockdep happy.

Timo Teras (2):
      MMC: Poll card status after rescanning cards
      MMC: Do not set unsupported bits in OCR response

Tom Tucker (1):
      RDMA/amso1100: Fix unitialized pseudo_netdev accessed in c2_register_device

Vivek Goyal (1):
      i386: Force data segment to be 4K aligned

Vlad Apostolov (3):
      [XFS] 956618: Linux crashes on boot with XFS-DMAPI filesystem when
      [XFS] rename uio_read() to xfs_uio_read()
      [XFS] 956664: dm_read_invis() changes i_atime

Wink Saville (1):
      Patch for nvidia divide by zero error for 7600 pci-express card

