Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSJHW6s>; Tue, 8 Oct 2002 18:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbSJHW5g>; Tue, 8 Oct 2002 18:57:36 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:19410 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S261321AbSJHW4l>; Tue, 8 Oct 2002 18:56:41 -0400
Date: Wed, 9 Oct 2002 01:02:18 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: experiences with 2.5.40 on a busy usenet news server
Message-ID: <20021009010218.A26428@cistron.nl>
References: <anu60s$oev$1@ncc1701.cistron.net> <3DA2A233.88525FE4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DA2A233.88525FE4@digeo.com>; from akpm@digeo.com on Tue, Oct 08, 2002 at 02:15:31AM -0700
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Andrew Morton:
> You'll probably find that 2.5.41-mm1 does not swap at all; but
> I'd need to see meminfo to know.

2.5.41-mm1 panics on boot for me. I applied 2 patches to it;
the first is the mremap fix you talked about earlier, the second
is the raid0 fix posted by Peter Chubb <peter@chubb.wattle.id.au>
last friday, which works fine on 2.5.40. Ofcourse I ported it
to 2.5.41-mm1, but both code paths are not used at the time
of the panic AFAICS

Below is the boot log, which shows the panic, followed by the
patches I used.

I can't experiment further since a) this is a production machine
and b) I really have to go to bed now :|

Loading 2.5.41........................
Linux version 2.5.41 (root@wormhole) (gcc version 2.95.4 20011006 (Debian prerelease)) #3 SMP Wed Oct 9 00:42:56 CEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb460
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 262144
  DMA zone: 4096 pages
  Normal zone: 225280 pages
  HighMem zone: 32768 pages
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440BX        APIC at: 0xFEE00000
Processor #0 6:7 APIC version 17
Processor #1 6:7 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.5.41 root=801 ioapic_level=9,10,15 rootfstype=ext2 panic=30 console=tty0 console=ttyS0,9600n8
IO-APIC-level enabling for IRQ9 IRQ10 IRQ15
Initializing CPU#0
Detected 449.298 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 884.73 BogoMIPS
Memory: 1033152k/1048576k available (1458k kernel code, 13928k reserved, 644k data, 108k init, 131072k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU0: Intel Pentium III (Katmai) stepping 02
per-CPU timeslice cutoff: 1461.26 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 897.02 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU1: Intel Pentium III (Katmai) stepping 02
Total of 2 processors activated (1781.76 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
, 2-11<7>Forcing IRQ15 to level
, 2-16, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 449.0163 MHz.
..... host bus clock speed is 99.0813 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Debug: sleeping function called from illegal context at kernel/sched.c:1177
Call Trace:
 [<c0115da4>] __might_sleep+0x54/0x58
 [<c011462b>] wait_for_completion+0x1b/0x104
 [<c011360b>] wake_up_process+0xb/0x10
 [<c0115996>] set_cpus_allowed+0x14a/0x16c
 [<c0115a08>] migration_thread+0x50/0x32c
 [<c01159b8>] migration_thread+0x0/0x32c
 [<c01054ed>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0114061>] schedule+0x3d/0x404
 [<c0115da4>] __might_sleep+0x54/0x58
 [<c01146c5>] wait_for_completion+0xb5/0x104
 [<c011446c>] default_wake_function+0x0/0x34
 [<c011446c>] default_wake_function+0x0/0x34
 [<c0115996>] set_cpus_allowed+0x14a/0x16c
 [<c0115a08>] migration_thread+0x50/0x32c
 [<c01159b8>] migration_thread+0x0/0x32c
 [<c01054ed>] kernel_thread_helper+0x5/0xc

CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0132d94
*pde = 00000000
Oops: 0000
 
CPU:    1
EIP:    0060:[<c0132d94>]    Not tainted
EFLAGS: 00010002
EIP is at kmem_cache_alloc+0x18/0x48
eax: 00000004   ebx: 00000246   ecx: c02cff40   edx: 00000000
esi: 00000138   edi: 00000000   ebp: 00000000   esp: f7fa5f80
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=f7fa4000 task=f7fc7020)
Stack: f7fa4000 c0131ce8 c02cff40 000001d0 f7fa4000 00000000 00000000 00000000 
       f7fa4000 ffffe1e5 c0118a4c c040e83b 00000246 c02ce6c0 0000003b c0324d0a 
       c02ad2d1 00000138 00000000 00002000 00000000 00000000 c0324cb2 c0310862 
Call Trace:
 [<c0131ce8>] kmem_cache_create+0x6c/0x5c4
 [<c0118a4c>] release_console_sem+0xa4/0xdc
 [<c01050ab>] init+0x47/0x1ac
 [<c0105064>] init+0x0/0x1ac
 [<c01054ed>] kernel_thread_helper+0x5/0xc

Code: 8b 02 85 c0 74 16 c7 42 0c 01 00 00 00 48 89 02 8b 44 82 10 
 <0>Kernel panic: Attempted to kill init!
 <0>Rebooting in 30 seconds..


--- linux-2.5.41-mm1/mm/mremap.c.orig	Tue Oct  8 23:56:22 2002
+++ linux-2.5.41-mm1/mm/mremap.c	Wed Oct  9 00:05:15 2002
@@ -54,7 +54,7 @@
 	return pte;
 }
 
-#ifdef CONFIG_HIGHPTE	/* Save a few cycles on the sane machines */
+#ifdef CONFIG_HIGHMEM	/* Save a few cycles on the sane machines */
 static inline int page_table_present(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;



--- linux-2.5.41-mm1/drivers/md/raid0.c.orig	Tue Oct  8 23:56:14 2002
+++ linux-2.5.41-mm1/drivers/md/raid0.c	Wed Oct  9 00:00:58 2002
@@ -162,6 +162,29 @@
 	return 1;
 }
 
+/**
+ *	raid0_mergeable_bvec -- tell bio layer if a two requests can be merged
+ *	@q: request queue
+ *	@bio: the buffer head that's been built up so far
+ *	@biovec: the request that could be merged to it.
+ *
+ *	Return 1 if the merge is not permitted (because the
+ *	result would cross a chunk boundary), 0 otherwise.
+ */
+static int raid0_mergeable_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *biovec)
+{
+	mddev_t *mddev = q->queuedata;
+	sector_t block;
+	unsigned int chunk_size;
+	unsigned int bio_sz;
+
+	chunk_size = mddev->chunk_size >> 10;
+	block = bio->bi_sector >> 1;
+	bio_sz = (bio->bi_size + biovec->bv_len) >> 10;
+
+	return chunk_size < ((block & (chunk_size - 1)) + bio_sz);
+}
+
 static int raid0_run (mddev_t *mddev)
 {
 	unsigned  cur=0, i=0, nb_zone;
@@ -233,6 +256,8 @@
 		conf->hash_table[i++].zone1 = conf->strip_zone + cur;
 		size -= (conf->smallest->size - zone0_size);
 	}
+	blk_queue_max_sectors(&mddev->queue, mddev->chunk_size >> 9);
+	blk_queue_merge_bvec(&mddev->queue, raid0_mergeable_bvec);
 	return 0;
 
 out_free_zone_conf:
@@ -262,13 +287,6 @@
 	return 0;
 }
 
-/*
- * FIXME - We assume some things here :
- * - requested buffers NEVER bigger than chunk size,
- * - requested buffers NEVER cross stripes limits.
- * Of course, those facts may not be valid anymore (and surely won't...)
- * Hey guys, there's some work out there ;-)
- */
 static int raid0_make_request (request_queue_t *q, struct bio *bio)
 {
 	mddev_t *mddev = q->queuedata;
@@ -291,8 +309,8 @@
 		hash = conf->hash_table + x;
 	}
 
-	/* Sanity check */
-	if (chunk_size < (block & (chunk_size - 1)) + (bio->bi_size >> 10))
+	/* Sanity check -- queue functions should prevent this happening */
+	if (unlikely(chunk_size < (block & (chunk_size - 1)) + (bio->bi_size >> 10)))
 		goto bad_map;
  
 	if (!hash)

