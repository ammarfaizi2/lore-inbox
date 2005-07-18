Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVGRUOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVGRUOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 16:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVGRUOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 16:14:38 -0400
Received: from web30312.mail.mud.yahoo.com ([68.142.201.230]:64374 "HELO
	web30312.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261683AbVGRUOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 16:14:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=riu4F9OdGAziNtIxucR+RC2zE/TUcK29IKdphzY/aTT63+kiwBy5nf0wLZaduzK8z3DXhE6NzlVMyjXokEvdaW0IRhGJhzkrxhuXs2i2urIqUYkLRj4Ixuz0ussSzzzDx4wUrj11Ljsd6VCqwLW83Unr2/SMuZ/XloAkwp01Dqg=  ;
Message-ID: <20050718201429.82565.qmail@web30312.mail.mud.yahoo.com>
Date: Mon, 18 Jul 2005 21:14:28 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Linux 2.6.11.5 on R3912 problems
To: LKML <linux-kernel@vger.kernel.org>,
       "'Linux/MIPS Development'" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have now been trying to get Linux 2.6.11.5 (built
with gcc 3.3.3 and binutils 2.15.91.0.2) up and
running on my Helio PDA, a MIPS R3912 based ASSP (the
emulator to be exact) and have been stuck at the last
step for a while now :-(. 

The kernel runs up fine, the problem starts when init
is started. Bellow is my kernel log up to freeing
init.

Uncompressing
Linux............................................
done, booting the kernel.
done decompressing kernel.
e_entry: 8016b000, e_ehsize: 52, e_phentsize 32,
e_phnum 2,
e_shentsize 40, e_shnum 25
copying 0x10c320 bytes from file offset 0x80 to
address 0x80040000
zeroing from 8014c320 to to 8014c320, 0x0 bytes
copying 0x36084 bytes from file offset 0x10e000 to
address 0x8014e000
zeroing from 80184084 to to 80198b58, 0x14ad4 bytes
done loading kernel, about to jump in!
mips_machgroup 0x00000017, mips_machtype 0x00000000
arcs_cmdline: root=1f01 console=ttyS0,115200n8
Linux version 2.6.11.5 (mark@stargate) (gcc version
3.3.3) #297 Mon Jul 18 20:19
:39 UTC 2005
V nasty hack. The Emulator doesn't report which subset
of the TX39 family it bel
ongs to :,-(. I hope the hardware does!
Forcing cpu type to CPU_TX3912
CPU revision is: 00002200
Determined physical RAM map:
 memory: 00267000 @ 00199000 (usable)
 memory: 00400000 @ 02000000 (usable)
 memory: 00200000 @ 9fc00000 (ROM data)
Built 1 zonelists
Kernel command line: root=1f01 console=ttyS0,115200n8
Primary instruction cache 1kB, linesize 16 bytes
Primary data cache 1kB, linesize 4 bytes
Synthesized TLB handler (17 instructions).
Synthesized TLB load handler fastpath (37
instructions).
Synthesized TLB store handler fastpath (37
instructions).
Synthesized TLB modify handler fastpath (29
instructions).
PID hash table entries: 256 (order: 8, 4096 bytes)
r39xx_set_termios
Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384
bytes)
Memory: 6168k/6556k available (981k kernel code, 348k
reserved, 212k data, 104k
init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
Checking for 'wait' instruction...  unavailable.
cpu_wait = 0x0
Linux NoNET1.0 for Linux 2.6
schedule = 0x801327f8. ret = 0
Can't analyze prologue code at 80133ea0
schedule_timeout = 0x80133ea0. ret = -1
sleep_on = 0x8013395c. ret = 0
sleep_on_timeout = 0x80133a54. ret = 0
wait_for_completion = 0x80133148. ret = 0
Serial: r39xx internal UART driver $
r39xx_config_port
r39xx_request_port
ttyS0 at MMIO 0x0r39xx_type
 (irq = 74) is a R39XX
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
Helio Boot ROM: 0x00200000 at 0x9fc00000
helio_mtd_map.virt 0x9fc00000
Helio Boot ROM: probing for ROM
Creating 2 MTD partitions on "Helio Boot ROM":
0x00000000-0x00097eec : "Bootloader + Kernel"
mtd: Giving out device 0 to Bootloader + Kernel
0x00097eec-0x0013deec : "cramfs Filesystem"
mtd: Giving out device 1 to cramfs Filesystem
block2mtd: version $Revision: 1.23 $
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 104k freed

I have had to write a UART driver so I thought the
problem might be with that so I put lots of debug in
tty layer, serial_core and my driver to see what was
going on. After doing this and changing the interrupt
handler (int-handler.S) I saw the echo that I had put
in my inittab.
So I started to remove debug and found it stopped
working. The strange thing is that it stops before it
gets as far as sending the echo from inittab.
If I don’t have enough debug the kernel stops just
before printing out:

Algorithmics/MIPS FPU Emulator v1.5

When I connect to the emulator with GDB and look at
the registers I find the CPU is still running and is
in cpu_idle.
I wondered if it might be a timer/task scheduler
related problem but as it gets passed the bogomips
calculation the timer must be working.

Any help would be great as I have been stuck here for
a while.

Many Thanks,

Mark



		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
