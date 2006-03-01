Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWCAKfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWCAKfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWCAKfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:35:44 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:36823 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S964904AbWCAKfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:35:44 -0500
Message-ID: <440578F6.5060107@free.fr>
Date: Wed, 01 Mar 2006 11:35:34 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050920
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Laurent Riffard <laurent.riffard@free.fr>
CC: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Martin Bligh <mbligh@mbligh.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>	<4404CE39.6000109@liberouter.org>	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>	<4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org> <4405723E.5060606@free.fr>
In-Reply-To: <4405723E.5060606@free.fr>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/mixed;
 boundary="------------060201010608010003000509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201010608010003000509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit


Le 01.03.2006 11:06, Laurent Riffard a écrit :
> Le 01.03.2006 01:21, Andrew Morton a écrit :
> 
>>Laurent Riffard <laurent.riffard@free.fr> wrote:
>>
>>
>>>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000034
>>
>>
>>I booted that thing on five machines, four architectures :(
>>
>>Could people please test a couple more patchsets, see if we can isolate it?
>>
>>http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
>>
>>is 2.6.16-rc5-mm1 minus:
>>
>>proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
>>tref-implement-task-references.patch
>>proc-dont-lock-task_structs-indefinitely.patch
>>proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
>>proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
>>proc-optimize-proc_check_dentry_visible.patch
> 
> 
> Ok, 2.6.16-rc5-mm1.1 works for me:
> - I can run java from command line in runlevel 1
> - I can launch Mozilla in X
> 

Well, I should have check my logs... There is a bunch of BUGs  
when I launch Gnome:

BUG: warning at fs/inotify.c:533/inotify_d_instantiate()
 [<c0103c01>] show_trace+0xd/0xf
 [<c0103c18>] dump_stack+0x15/0x17
 [<c0165f52>] inotify_d_instantiate+0x2e/0x4e
 [<c015aa42>] d_splice_alias+0x6f/0x91
 [<e09ed0a6>] reiserfs_lookup+0xc8/0xd7 [reiserfs]
 [<c0152a8e>] do_lookup+0x9d/0x131
 [<c0153173>] __link_path_walk+0x651/0xa30
 [<c01535a0>] link_path_walk+0x4e/0xc6
 [<c01539e7>] do_path_lookup+0x196/0x1b0
 [<c0153e30>] __path_lookup_intent_open+0x44/0x76
 [<c0153ebe>] path_lookup_open+0x10/0x12
 [<c0154935>] open_namei+0x61/0x504
 [<c014743b>] do_filp_open+0x1f/0x35
 [<c0147535>] do_sys_open+0x3f/0xb7
 [<c01475d9>] sys_open+0x16/0x18
 [<c01029bb>] sysenter_past_esp+0x54/0x75

I attached the (almost) full dmesg.

>>and http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.2.gz is
>>2.6.16-rc5-mm1 minus:
>>
>>trivial-cleanup-to-proc_check_chroot.patch
>>proc-fix-the-inode-number-on-proc-pid-fd.patch
>>proc-remove-useless-bkl-in-proc_pid_readlink.patch
>>proc-remove-unnecessary-and-misleading-assignments.patch
>>proc-simplify-the-ownership-rules-for-proc.patch
>>proc-replace-proc_inodetype-with-proc_inodefd.patch
>>proc-remove-bogus-proc_task_permission.patch
>>proc-kill-proc_mem_inode_operations.patch
>>proc-properly-filter-out-files-that-are-not-visible.patch
>>proc-fix-the-link-count-for-proc-pid-task.patch
>>proc-move-proc_maps_operations-into-task_mmuc.patch
>>dcache-add-helper-d_hash_and_lookup.patch
>>proc-rewrite-the-proc-dentry-flush-on-exit.patch
>>proc-close-the-race-of-a-process-dying-durning.patch
>>proc-refactor-reading-directories-of-tasks.patch
>>#
>>proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
>>tref-implement-task-references.patch
>>proc-dont-lock-task_structs-indefinitely.patch
>>proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
>>proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
>>proc-optimize-proc_check_dentry_visible.patch
>>
>>
>>Thanks.
> 
> I guess you don't need me to test 2.6.16-rc5-mm1.2 since 
> 2.6.16-rc5-mm1.1 is OK.
> 
> thanks

Finally I'm going to give it a try...
-- 
laurent

--------------060201010608010003000509
Content-Type: text/plain;
 name="dmesg-2.6.16-rc5-mm1.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.16-rc5-mm1.1"

Host Controller Interface driver v3.0
ACPI (acpi_bus-0200): Device 'USB0' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 5, io base 0x0000d400
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-rc5-mm1 uhci_hcd
usb usb1: SerialNumber: 0000:00:04.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI (acpi_bus-0200): Device 'USB1' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:04.3: irq 5, io base 0x0000d000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-rc5-mm1 uhci_hcd
usb usb2: SerialNumber: 0000:00:04.3
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[d5800000-d58007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
usb 1-2: new device found, idVendor=044f, idProduct=b303
usb 1-2: new device strings: Mfr=4, Product=30, SerialNumber=0
usb 1-2: Product: FireStorm Dual Analog 2
usb 1-2: Manufacturer: THRUSTMASTER
usb 1-2: configuration #1 chosen from 1 choice
input: THRUSTMASTER FireStorm Dual Analog 2 as /class/input/input2
input: USB HID v1.10 Gamepad [THRUSTMASTER FireStorm Dual Analog 2] on usb-0000:00:04.2-2
usbcore: registered new driver usbhid
usbhid: v2.6:USB HID core driver
Using specific hotkey driver
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00308d0120e085ca]
EXT3 FS on dm-4, internal journal
Adding 257000k swap on /dev/hdb6.  Priority:1 extents:1 across:257000k
Adding 64220k swap on /dev/hda5.  Priority:2 extents:1 across:64220k
Adding 795208k swap on /dev/hdb7.  Priority:2 extents:1 across:795208k
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 32M @ 0xe6000000
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: md0 stopped.
md: bind<hdb9>
md: bind<hda7>
md: raid1 personality registered for level 1
raid1: raid set md0 active with 2 out of 2 mirrors
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
Loading Reiser4. See www.namesys.com for a description of Reiser4.
ps_hash_table: 32 buckets
d_cursor_hash_table: 256 buckets
ef_hash_table: 8192 buckets
z_hash_table: 8192 buckets
z_hash_table: 8192 buckets
j_hash_table: 16384 buckets
loading reiser4 bitmap......done (19 jiffies)
ReiserFS: hda9: found reiserfs format "3.6" with standard journal
ReiserFS: hda9: using ordered data mode
ReiserFS: hda9: journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda9: checking transaction log (hda9)
ReiserFS: hda9: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
hdc: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
hda: cache flushes not supported
md: md0 in immediate safe mode
Using specific hotkey driver
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET: Registered protocol family 17
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport0: Printer, HEWLETT-PACKARD DESKJET 710C
parport_pc: VIA parallel port: io=0x378, irq=7
lp0: using parport0 (interrupt-driven).
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
i2c_adapter i2c-9191: sensors disabled - enable with force_addr=0xe200
pktcdvd: writer pktcdvd0 mapped to hdc
BUG: warning at fs/inotify.c:533/inotify_d_instantiate()
 [<c0103c01>] show_trace+0xd/0xf
 [<c0103c18>] dump_stack+0x15/0x17
 [<c0165f52>] inotify_d_instantiate+0x2e/0x4e
 [<c015aa42>] d_splice_alias+0x6f/0x91
 [<e09ed0a6>] reiserfs_lookup+0xc8/0xd7 [reiserfs]
 [<c0152a8e>] do_lookup+0x9d/0x131
 [<c0153173>] __link_path_walk+0x651/0xa30
 [<c01535a0>] link_path_walk+0x4e/0xc6
 [<c01539e7>] do_path_lookup+0x196/0x1b0
 [<c0153e30>] __path_lookup_intent_open+0x44/0x76
 [<c0153ebe>] path_lookup_open+0x10/0x12
 [<c0154935>] open_namei+0x61/0x504
 [<c014743b>] do_filp_open+0x1f/0x35
 [<c0147535>] do_sys_open+0x3f/0xb7
 [<c01475d9>] sys_open+0x16/0x18
 [<c01029bb>] sysenter_past_esp+0x54/0x75
BUG: warning at fs/inotify.c:533/inotify_d_instantiate()
 [<c0103c01>] show_trace+0xd/0xf
 [<c0103c18>] dump_stack+0x15/0x17
 [<c0165f52>] inotify_d_instantiate+0x2e/0x4e
 [<c015aa42>] d_splice_alias+0x6f/0x91
 [<e09ed0a6>] reiserfs_lookup+0xc8/0xd7 [reiserfs]
 [<c0152a8e>] do_lookup+0x9d/0x131
 [<c0153173>] __link_path_walk+0x651/0xa30
 [<c01535a0>] link_path_walk+0x4e/0xc6
 [<c01539e7>] do_path_lookup+0x196/0x1b0
 [<c0153e30>] __path_lookup_intent_open+0x44/0x76
 [<c0153ebe>] path_lookup_open+0x10/0x12
 [<c0154935>] open_namei+0x61/0x504
 [<c014743b>] do_filp_open+0x1f/0x35
 [<c0147535>] do_sys_open+0x3f/0xb7
 [<c01475d9>] sys_open+0x16/0x18
 [<c01029bb>] sysenter_past_esp+0x54/0x75
BUG: warning at fs/inotify.c:533/inotify_d_instantiate()
 [<c0103c01>] show_trace+0xd/0xf
 [<c0103c18>] dump_stack+0x15/0x17
 [<c0165f52>] inotify_d_instantiate+0x2e/0x4e
 [<c015aa42>] d_splice_alias+0x6f/0x91
 [<c017c666>] ext3_lookup+0x74/0x7a
 [<c0152a8e>] do_lookup+0x9d/0x131
 [<c0153173>] __link_path_walk+0x651/0xa30
 [<c01535a0>] link_path_walk+0x4e/0xc6
 [<c01539e7>] do_path_lookup+0x196/0x1b0
 [<c0153e30>] __path_lookup_intent_open+0x44/0x76
 [<c0153ebe>] path_lookup_open+0x10/0x12
 [<c0154935>] open_namei+0x61/0x504
 [<c014743b>] do_filp_open+0x1f/0x35
 [<c0147535>] do_sys_open+0x3f/0xb7
 [<c01475d9>] sys_open+0x16/0x18
 [<c01029bb>] sysenter_past_esp+0x54/0x75
BUG: warning at fs/inotify.c:533/inotify_d_instantiate()
 [<c0103c01>] show_trace+0xd/0xf
 [<c0103c18>] dump_stack+0x15/0x17
 [<c0165f52>] inotify_d_instantiate+0x2e/0x4e
 [<c015aa42>] d_splice_alias+0x6f/0x91
 [<e09ed0a6>] reiserfs_lookup+0xc8/0xd7 [reiserfs]
 [<c0152a8e>] do_lookup+0x9d/0x131
 [<c0153173>] __link_path_walk+0x651/0xa30
 [<c01535a0>] link_path_walk+0x4e/0xc6
 [<c01539e7>] do_path_lookup+0x196/0x1b0
 [<c0153e30>] __path_lookup_intent_open+0x44/0x76
 [<c0153ebe>] path_lookup_open+0x10/0x12
 [<c0154935>] open_namei+0x61/0x504
 [<c014743b>] do_filp_open+0x1f/0x35
 [<c0147535>] do_sys_open+0x3f/0xb7
 [<c01475d9>] sys_open+0x16/0x18
 [<c01029bb>] sysenter_past_esp+0x54/0x75
BUG: warning at fs/inotify.c:533/inotify_d_instantiate()
 [<c0103c01>] show_trace+0xd/0xf
 [<c0103c18>] dump_stack+0x15/0x17
 [<c0165f52>] inotify_d_instantiate+0x2e/0x4e
 [<c015aa42>] d_splice_alias+0x6f/0x91
 [<e09ed0a6>] reiserfs_lookup+0xc8/0xd7 [reiserfs]
 [<c0152a8e>] do_lookup+0x9d/0x131
 [<c0153173>] __link_path_walk+0x651/0xa30
 [<c01535a0>] link_path_walk+0x4e/0xc6
 [<c01539e7>] do_path_lookup+0x196/0x1b0
 [<c0153e30>] __path_lookup_intent_open+0x44/0x76
 [<c0153ebe>] path_lookup_open+0x10/0x12
 [<c0154935>] open_namei+0x61/0x504
 [<c014743b>] do_filp_open+0x1f/0x35
 [<c0147535>] do_sys_open+0x3f/0xb7
 [<c01475d9>] sys_open+0x16/0x18
 [<c01029bb>] sysenter_past_esp+0x54/0x75
BUG: warning at fs/inotify.c:533/inotify_d_instantiate()
 [<c0103c01>] show_trace+0xd/0xf
 [<c0103c18>] dump_stack+0x15/0x17
 [<c0165f52>] inotify_d_instantiate+0x2e/0x4e
 [<c015aa42>] d_splice_alias+0x6f/0x91
 [<e09ed0a6>] reiserfs_lookup+0xc8/0xd7 [reiserfs]
 [<c0152a8e>] do_lookup+0x9d/0x131
 [<c0153173>] __link_path_walk+0x651/0xa30
 [<c01535a0>] link_path_walk+0x4e/0xc6
 [<c01539e7>] do_path_lookup+0x196/0x1b0
 [<c0153e30>] __path_lookup_intent_open+0x44/0x76
 [<c0153ebe>] path_lookup_open+0x10/0x12
 [<c0154935>] open_namei+0x61/0x504
 [<c014743b>] do_filp_open+0x1f/0x35
 [<c0147535>] do_sys_open+0x3f/0xb7
 [<c01475d9>] sys_open+0x16/0x18
 [<c01029bb>] sysenter_past_esp+0x54/0x75

--------------060201010608010003000509--
