Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbSKQFvv>; Sun, 17 Nov 2002 00:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbSKQFvv>; Sun, 17 Nov 2002 00:51:51 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:57306 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S267443AbSKQFvr>;
	Sun, 17 Nov 2002 00:51:47 -0500
From: Justin A <ja6447@albany.edu>
To: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@digeo.com>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pnpbios oops on boot w/ 2.5.47
Date: Sun, 17 Nov 2002 01:00:53 -0500
User-Agent: KMail/1.4.3
References: <200211161700.29653.ja6447@albany.edu> <3DD6F655.4214A594@digeo.com> <20021116232528.GA1273@neo.rr.com>
In-Reply-To: <20021116232528.GA1273@neo.rr.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_H1IPD4NQVF7I4BHPRRG0"
Message-Id: <200211170100.53986.ja6447@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_H1IPD4NQVF7I4BHPRRG0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 16 November 2002 06:25 pm, Adam Belay wrote:

> Oops.  I put the pnpbios_kmalloc in the wrong place.  It's amazing it s=
till
> worked on my test box.  Here's a patch that should fix it.  Justin: cou=
ld
> you please try it.
>
> Thanks,
> Adam
I had a fealing that call_pnp_bios was doing something with data so I tri=
ed it=20
anyway with:

CONFIG_PNP=3Dy
CONFIG_PNP_NAMES=3Dy
CONFIG_PNP_DEBUG=3Dy
CONFIG_ISAPNP=3Dy
CONFIG_PNPBIOS=3Dy

and it booted ok.  You were right, it was a serial port(even though that =
port=20
always worked without pnp:))

I didn't have NAMES and DEBUG on before, so hopefully neither of those is=
 what=20
fixed it in this case.

Here is the new dmseg, you can ignore the crap at the end, thats just pcm=
cia=20
being broken, it goes away if I move /l/m/2/k/d/pcmcia out of the way.

--=20
-Justin

--------------Boundary-00=_H1IPD4NQVF7I4BHPRRG0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.5.47-ac5 (root@s.bouncybouncy.net) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Sat Nov 16 23:38:39 EST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004800000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
72MB LOWMEM available.
On node 0 totalpages: 18432
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 14336 pages, LIFO batch:3
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=302 resume=/dev/hda1
Initializing CPU#0
Detected 119.731 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 235.00 BogoMIPS
Memory: 69968k/73728k available (1115k kernel code, 3284k reserved, 1046k data, 80k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Linux Plug and Play Support v0.9 (c) Adam Belay
pnp: the driver 'system' has been registered
PCI: PCI BIOS revision 2.10 entry at 0xfdaa0, last bus=6
PCI: Using configuration type 1
Registering system device cpu0
adding 'CPU 0' to cpu class interfaces
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 134 entries (12 bytes)
biovec pool[1]:   4 bvecs: 134 entries (48 bytes)
biovec pool[2]:  16 bvecs: 134 entries (192 bytes)
biovec pool[3]:  64 bvecs:  67 entries (768 bytes)
biovec pool[4]: 128 bvecs:  33 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  16 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe700
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe724, dseg 0xf0000
pnp: pnp: match found with the PnP device '00:10' and the driver 'system'
pnp: 00:10: ioport range 0x100-0x107 has been reserved
pnp: 00:10: ioport range 0x15ee-0x15ef has been reserved
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Registering system device pic0
Registering system device rtc0
slab: reap timer started for cpu 0
Starting kswapd
aio_setup: sizeof(struct page) = 40
[c4782040] eventpoll: driver installed.
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Capability LSM initialized
Initializing Cryptographic API
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: pnp: match found with the PnP device '00:13' and the driver 'serial'
pnp: the device '00:13' has been activated
PnPBIOS: set_dev_node: Unexpected status 0x85
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIXa: IDE controller at PCI slot 00:01.0
PIIXa: chipset revision 2
PIIXa: not 100% native mode: will probe irqs later
PIIXa: neither IDE port enabled (BIOS)
hda: TOSHIBA MK2109MAT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 4233600 sectors (2168 MB), CHS=525/128/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Resume Machine: resuming from /dev/hda1
Resuming from device ide0(3,1)
Resume Machine: This is normal swap space
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 80k freed
spurious 8259A interrupt: IRQ7.
Adding 145112k swap on /dev/hda1.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: No IRQ known for interrupt pin A of device 00:02.0. Please try using pci=biosirq.
PCI: No IRQ known for interrupt pin B of device 00:02.1. Please try using pci=biosirq.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc50232d4, data=0xc5024fc0
Call Trace:
 [<c011ac60>] check_timer_failed+0x40/0x4c
 [<c50232d4>] yenta_interrupt_wrapper+0x0/0x30 [yenta_socket]
 [<c5024fc0>] pci_socket_array+0x0/0x5c0 [yenta_socket]
 [<c5025038>] pci_socket_array+0x78/0x5c0 [yenta_socket]
 [<c011ac9a>] add_timer+0x2e/0xec
 [<c5025038>] pci_socket_array+0x78/0x5c0 [yenta_socket]
 [<c5024fc0>] pci_socket_array+0x0/0x5c0 [yenta_socket]
 [<c5024fc0>] pci_socket_array+0x0/0x5c0 [yenta_socket]
 [<c5023597>] yenta_open_bh+0x87/0xd4 [yenta_socket]
 [<c5025038>] pci_socket_array+0x78/0x5c0 [yenta_socket]
 [<c5025004>] pci_socket_array+0x44/0x5c0 [yenta_socket]
 [<c012015d>] worker_thread+0x18d/0x240
 [<c5024fc0>] pci_socket_array+0x0/0x5c0 [yenta_socket]
 [<c011ffd0>] worker_thread+0x0/0x240
 [<c5023510>] yenta_open_bh+0x0/0xd4 [yenta_socket]
 [<c01116c4>] default_wake_function+0x0/0x2c
 [<c01116c4>] default_wake_function+0x0/0x2c
 [<c0106f21>] kernel_thread_helper+0x5/0xc

Yenta IRQ list 06b8, PCI irq0
Socket status: 30000006
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc50232d4, data=0xc5025078
Call Trace:
 [<c011ac60>] check_timer_failed+0x40/0x4c
 [<c50232d4>] yenta_interrupt_wrapper+0x0/0x30 [yenta_socket]
 [<c5025078>] pci_socket_array+0xb8/0x5c0 [yenta_socket]
 [<c50250f0>] pci_socket_array+0x130/0x5c0 [yenta_socket]
 [<c011ac9a>] add_timer+0x2e/0xec
 [<c50250f0>] pci_socket_array+0x130/0x5c0 [yenta_socket]
 [<c5025078>] pci_socket_array+0xb8/0x5c0 [yenta_socket]
 [<c5025078>] pci_socket_array+0xb8/0x5c0 [yenta_socket]
 [<c5023597>] yenta_open_bh+0x87/0xd4 [yenta_socket]
 [<c50250f0>] pci_socket_array+0x130/0x5c0 [yenta_socket]
 [<c50250bc>] pci_socket_array+0xfc/0x5c0 [yenta_socket]
 [<c012015d>] worker_thread+0x18d/0x240
 [<c5025078>] pci_socket_array+0xb8/0x5c0 [yenta_socket]
 [<c011ffd0>] worker_thread+0x0/0x240
 [<c5023510>] yenta_open_bh+0x0/0xd4 [yenta_socket]
 [<c01116c4>] default_wake_function+0x0/0x2c
 [<c01116c4>] default_wake_function+0x0/0x2c
 [<c0106f21>] kernel_thread_helper+0x5/0xc

Yenta IRQ list 06b8, PCI irq0
Socket status: 30000020
cs: cb_alloc(bus 4): vendor 0x1317, device 0x1985
PCI: Enabling device 04:00.0 (0000 -> 0003)
PCI: No IRQ known for interrupt pin A of device 04:00.0. Please try using pci=biosirq.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x1a0-0x1af 0x268-0x26f 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: excluding 0xa68-0xa6f
Unable to handle kernel NULL pointer dereference at virtual address 00000034
 printing eip:
c01860c1
*pde = 00000000
Oops: 0000
ds yenta_socket pcmcia_core  
CPU:    0
EIP:    0060:[<c01860c1>]    Not tainted
EFLAGS: 00010046
EIP is at pci_bus_read_config_dword+0x1d/0x58
eax: 00000004   ebx: 00000246   ecx: 00000028   edx: 00000000
esi: 00000004   edi: c10d814c   ebp: c3df1cd4   esp: c3df1ae8
ds: 0068   es: 0068   ss: 0068
Process cardmgr (pid: 207, threadinfo=c3df0000 task=c448a0a0)
Stack: c3df1cb4 c3de8800 00000000 c5015b4f 00000004 00000000 00000028 c3df1b18 
       c3df1cb4 c10d814c c3df1d00 00000007 c4181080 c5017325 c10d814c c3df1cb4 
       8004640b c10d832c 00000000 00000000 00000000 00000000 c46ef800 00000000 
Call Trace:
 [<c5015b4f>] pcmcia_get_first_tuple+0x77/0x11c [pcmcia_core]
 [<c5017325>] pcmcia_validate_cis+0x65/0x180 [pcmcia_core]
 [<c017449b>] journal_cancel_revoke+0xf3/0x168
 [<c017012b>] do_get_write_access+0x4b3/0x4d8
 [<c01707ff>] journal_dirty_metadata+0x1a7/0x1c0
 [<c01661f0>] ext3_do_update_inode+0x338/0x3c8
 [<c0166254>] ext3_do_update_inode+0x39c/0x3c8
 [<c0166511>] ext3_mark_iloc_dirty+0x21/0x50
 [<c0166522>] ext3_mark_iloc_dirty+0x32/0x50
 [<c0166615>] ext3_mark_inode_dirty+0x29/0x34
 [<c017449b>] journal_cancel_revoke+0xf3/0x168
 [<c017012b>] do_get_write_access+0x4b3/0x4d8
 [<c017449b>] journal_cancel_revoke+0xf3/0x168
 [<c502bf9f>] ds_ioctl+0x397/0x58c [ds]
 [<c0166254>] ext3_do_update_inode+0x39c/0x3c8
 [<c0170c60>] journal_stop+0x260/0x270
 [<c012d1f5>] __pagevec_release+0x15/0x20
 [<c012d3a3>] __pagevec_lru_add+0x87/0x90
 [<c0128f63>] generic_file_write_nolock+0x997/0x9bc
 [<c017012b>] do_get_write_access+0x4b3/0x4d8
 [<c012eb9b>] buffered_rmqueue+0xb7/0xc4
 [<c0129003>] generic_file_write+0x57/0x6c
 [<c01271d6>] find_get_page+0x12/0x20
 [<c0127ed7>] filemap_nopage+0xe7/0x2a4
 [<c0127f07>] filemap_nopage+0x117/0x2a4
 [<c01255fe>] do_no_page+0x24a/0x288
 [<c01256a2>] handle_mm_fault+0x66/0xdc
 [<c0110207>] do_page_fault+0x127/0x457
 [<c01100e0>] do_page_fault+0x0/0x457
 [<c012c5d7>] kfree+0x1db/0x220
 [<c502bacc>] ds_read+0xc4/0xdc [ds]
 [<c0138fed>] vfs_read+0xc1/0x124
 [<c01467e9>] sys_ioctl+0x1fd/0x214
 [<c0108ebd>] error_code+0x2d/0x40
 [<c0108c47>] syscall_call+0x7/0xb

Code: 8b 56 30 8d 44 24 08 50 6a 04 51 8b 44 24 20 50 56 8b 02 ff 
 

--------------Boundary-00=_H1IPD4NQVF7I4BHPRRG0--

