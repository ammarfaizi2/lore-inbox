Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271870AbTGRPvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271872AbTGRPuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:50:04 -0400
Received: from mail.cmedia.tv ([66.45.82.183]:57867 "EHLO mail.respond2.com")
	by vger.kernel.org with ESMTP id S271870AbTGRPt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:49:28 -0400
Date: Fri, 18 Jul 2003 09:04:38 -0700
From: jak@easystreet.com
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/slab.c:1695!
Message-ID: <20030718160438.GI8487@foundry.respond2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this is an oops, or what.  I've been getting these errors 
frequently when trying to move large directories through scp.  The 
command that triggered this trace is:
scp -r tanis:/mnt/data/media/music .
It seems random, but not sure yet.  Earlier I scp'ied another large 
dir, got a similar error, and then my second try seemed to work 
successfully?!? . . .

Here is the stack trace:
-----------------
------------[ cut here ]------------
kernel BUG at mm/slab.c:1695!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014b4e6>]    Not tainted
EFLAGS: 00010002
EIP is at cache_alloc_refill+0x1b6/0x410
eax: 00000003   ebx: 0000003d   ecx: d1b1d000   edx: d1b1d018
esi: 0000003e   edi: d1b1d018   ebp: dcaabd5c   esp: dcaabd24
ds: 007b   es: 007b   ss: 0068
Process scp (pid: 254, threadinfo=dcaaa000 task=dcad6000)
Stack: 00000000 df7ed920 00000286 df7de014 0000003d df7ed92c 0000003d 
df7ed92c
        d1b1d000 df7ed934 00000296 d1b1d018 df7de004 00000002 dcaabd80 
c014bb75
        df7ed920 00000050 00000000 00000000 00001000 00000472 c12c6be0 
dcaabd98
Call Trace:
  [<c014bb75>] kmem_cache_alloc+0x65/0x180
  [<c016bf14>] alloc_buffer_head+0x14/0x50
  [<c01692db>] create_buffers+0x1b/0x90
  [<c0169ed8>] create_empty_buffers+0x18/0x1d0
  [<c01e5f2c>] reiserfs_prepare_file_region_for_write+0xfc/0x8e0
  [<c01fb096>] journal_end+0x16/0x20
  [<c01e6b84>] reiserfs_file_write+0x474/0x687
  [<c0176795>] pipe_read+0x205/0x220
  [<c0165f5e>] vfs_write+0x9e/0xd0
  [<c0166010>] sys_write+0x30/0x50
  [<c0109c67>] syscall_call+0x7/0xb
  Code: 0f 0b 9f 06 37 05 32 c0 89 f6 85 c0 7c 04 39 d8 72 08 0f 0b
  <6>note: scp[254] exited with preempt_count 1
Debug: sleeping function called from illegal context at include/asm/
semaphore.h:119
Call Trace:
  [<c011ed13>] __might_sleep+0x63/0x70
  [<c015664b>] remove_shared_vm_struct+0x2b/0x80
  [<c01584cc>] exit_mmap+0x1fc/0x240
  [<c011f8cd>] mmput+0xdd/0x100
  [<c0125136>] do_exit+0x2a6/0x9b0
  [<c010ad6c>] die+0x1cc/0x1d0
  [<c010af90>] do_invalid_op+0x0/0x90
  [<c010b009>] do_invalid_op+0x79/0x90
  [<c014b4e6>] cache_alloc_refill+0x1b6/0x410
  [<c024ee7c>] tulip_interrupt+0xa9c/0xb10
  [<c02906e0>] netif_receive_skb+0x170/0x1c0
  [<c029079f>] process_backlog+0x6f/0x100
  [<c02908a2>] net_rx_action+0x72/0x130
  [<c010a671>] error_code+0x2d/0x38
  [<c014b4e6>] cache_alloc_refill+0x1b6/0x410
  [<c014bb75>] kmem_cache_alloc+0x65/0x180
  [<c016bf14>] alloc_buffer_head+0x14/0x50
  [<c01692db>] create_buffers+0x1b/0x90
  [<c0169ed8>] create_empty_buffers+0x18/0x1d0
  [<c01e5f2c>] reiserfs_prepare_file_region_for_write+0xfc/0x8e0
  [<c01fb096>] journal_end+0x16/0x20
  [<c01e6b84>] reiserfs_file_write+0x474/0x687
  [<c0176795>] pipe_read+0x205/0x220
  [<c0165f5e>] vfs_write+0x9e/0xd0
  [<c0166010>] sys_write+0x30/0x50
  [<c0109c67>] syscall_call+0x7/0xb
  mm/slab.c:2406: spin_lock(mm/slab.c:df7ed964) already locked by mm/
slab.c/1751
------------------------------

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 1700+
stepping        : 0
cpu MHz         : 1462.078
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2875.39


-----------------------------
lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT8361 [KLE133] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8361 [KLE133] AGP Bridge
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC 
Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
AC97 Audio Controller (rev 50)
00:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 
(rev 08)
00:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 08)
00:0f.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 
10/100 model NC100 (rev 11)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1
-------------------------

Please Advise!!
jak
