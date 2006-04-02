Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWDBQji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWDBQji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWDBQji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:39:38 -0400
Received: from hegel.brightdsl.net ([66.219.128.245]:39592 "EHLO
	hegel.brightdsl.net") by vger.kernel.org with ESMTP id S932388AbWDBQji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:39:38 -0400
Subject: BUG: warning at kernel/mutex.c:281 for 2.6.16.-git8 thru git20
From: Donald Parsons <dparsons@brightdsl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 02 Apr 2006 12:39:25 -0400
Message-Id: <1143995965.4310.15.camel@danny.parsons.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been seeing this BUG: in dmesg.  It does not
cause any noticeable user problems.  Just let me know
if you want more details.  Distribution FC3 with no
tainting.  T43 Thinkpad laptop.

BUG: warning was not in .16-git7 or previous.


Linux version 2.6.16-git9 (don@danny.parsons.org) (gcc version 3.4.4
 20050721 (Red Hat 3.4.4-2)) #3 PREEMPT Fri Mar 24 14:45:55 EST 2006
.....
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
hdaps: device successfully initialized.
input: hdaps as /class/input/input2
hdaps: driver successfully loaded.
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Mar 24 2006
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:
LID SLPB UART EXP0 EXP1 EXP2 EXP3 PCI1 USB0 USB1 USB3 USB7 AC9M
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 160k freed
BUG: warning at kernel/mutex.c:281/__mutex_trylock_slowpath()
<7812af12> mutex_trylock+0x70/0x152   <7823370e> hdaps_mousedev_poll\
   +0xd/0xc5
<781205fa> run_timer_softirq+0x11f/0x159   <78233701>
   hdaps_mousedev_poll+0x0/0xc5
<7811d22c> __do_softirq+0x40/0x88   <781049af> do_softirq+0x44/0x4c
=======================
<7811d314> irq_exit+0x2d/0x37   <781048d1> do_IRQ+0x79/0x83
<781035ae> common_interrupt+0x1a/0x20   <7811680e> __might_sleep\
   +0x16/0x94
<7819e794> copy_to_user+0x18/0x5d   <7815c9be> filldir64+0x94/0xc3
<7817c08f> sysfs_readdir+0x17d/0x1c2   <7815c92a> filldir64+0x0/0xc3
<7815c92a> filldir64+0x0/0xc3   <7815c6ef> vfs_readdir+0x63/0x89
<7815ca53> sys_getdents64+0x66/0xb3   <78296f41> _spin_unlock+0xf/0x23
<7815be56> do_fcntl+0xc3/0x136   <78102be3> syscall_call+0x7/0xb
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ata: 0x170 IDE port busy
.....



and for git12  I see similar plus (strangely) 3 error messages:

Linux version 2.6.16-git12 (don@danny.parsons.org) (gcc version 3.4.4
 20050721 (Red Hat 3.4.4-2)) #4 PREEMPT Sun Mar 26 15:51:21 EST 2006
.....
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post\
 a report
Setting up standard PCI resources
initcall at 0x7834e423: pnp_system_init+0x0/0xa(): returned with error\
 code 2
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: a8100000-a81fffff
  PREFETCH window: c0000000-c7ffffff
.....
agpgart: AGP aperture is 256M @ 0x0
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
 pnp: Device 00:09 activated.
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
initcall at 0x7834fc7b: serial8250_pnp_init+0x0/0xa(): returned with
 error code 1
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 19
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
.....
mice: PS/2 mouse device common for all mice
hdaps: IBM ThinkPad T43 detected.
input: AT Translated Set 2 keyboard as /class/input/input0
hdaps: initial latch check good (0x01).
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
hdaps: device successfully initialized.
input: hdaps as /class/input/input2
hdaps: driver successfully loaded.
EDAC MC: Ver: 2.0.0 Mar 26 2006
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
BUG: warning at kernel/mutex.c:281/__mutex_trylock_slowpath()
 <7812af16> mutex_trylock+0x70/0x152   <78233b02> hdaps_mousedev_poll\
   +0xd/0xc5
 <781206a9> run_timer_softirq+0x11f/0x159   <78233af5>
   hdaps_mousedev_poll+0x0/0xc5
 <7811d2ec> __do_softirq+0x40/0x88   <781049d3> do_softirq+0x44/0x4c
 =======================
 <7811d3d4> irq_exit+0x2d/0x37   <781048f5> do_IRQ+0x79/0x83
 <781035aa> common_interrupt+0x1a/0x20   <7835007b>
   early_serial_console_init+0x1e/0x45
 <7835322a> tcp_init+0x1a2/0x2dc   <78353808> inet_init+0x116/0x169
 <7833a6d6> do_initcalls+0x53/0xda   <781778f9> proc_mkdir_mode\
   +0x37/0x49
 <7810029a> init+0x0/0x122   <781002d1> init+0x37/0x122
 <781012f9> kernel_thread_helper+0x5/0xb
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
initcall at 0x78342e63: acpi_cpufreq_init+0x0/0x1f(): returned with\
   error code -16
Using IPI Shortcut mode
ACPI wakeup devices:
 LID SLPB UART EXP0 EXP1 EXP2 EXP3 PCI1 USB0 USB1 USB3 USB7 AC9M
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 160k freed
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
.....



Linux version 2.6.16-git20 (don@danny.parsons.org) (gcc version 3.4.4
  20050721 (Red Hat 3.4.4-2)) #10 PREEMPT Sat Apr 1 11:19:42 EST 2006
.....
NET: Registered protocol family 17
initcall at 0x78346ec4: acpi_cpufreq_init+0x0/0x1f(): returned with\
   error code -16
Using IPI Shortcut mode
ACPI wakeup devices:
 LID SLPB UART EXP0 EXP1 EXP2 EXP3 PCI1 USB0 USB1 USB3 USB7 AC9M
ACPI: (supports S0 S3 S4 S5)
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 160k freed
BUG: warning at kernel/mutex.c:281/__mutex_trylock_slowpath()
 <7812ad0e> mutex_trylock+0x70/0x152   <78236012> hdaps_mousedev_poll
+0xd/0xc5
 <781206eb> run_timer_softirq+0x11f/0x159   <78236005>
hdaps_mousedev_poll+0x0/0xc5
 <7811d3e0> __do_softirq+0x40/0x88   <781049bf> do_softirq+0x44/0x4c
 =======================
 <7811d4c8> irq_exit+0x2d/0x37   <781048e1> do_IRQ+0x79/0x83
 <781035aa> common_interrupt+0x1a/0x20   <78136287> prep_new_page
+0x103/0x14e
 <78136800> buffered_rmqueue+0x12c/0x160   <7813694d>
get_page_from_freelist+0x7d/0x96
 <781369bf> __alloc_pages+0x59/0x273   <7813e053> do_anonymous_page
+0x4f/0x169
 <7813e513> __handle_mm_fault+0xef/0x1f6   <7829a5bb> do_page_fault
+0x23f/0x59f
 <7829a37c> do_page_fault+0x0/0x59f   <78103673> error_code+0x4f/0x54
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ata: 0x170 IDE port busy
.....


Thanks,
Don Parsons


