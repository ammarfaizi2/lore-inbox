Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130267AbRBNQK4>; Wed, 14 Feb 2001 11:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbRBNQKr>; Wed, 14 Feb 2001 11:10:47 -0500
Received: from irz301.inf.tu-dresden.de ([141.76.2.1]:52287 "EHLO
	irz301.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S129299AbRBNQK2>; Wed, 14 Feb 2001 11:10:28 -0500
Date: Wed, 14 Feb 2001 17:10:25 +0100
From: Adam Lackorzynski <al10@inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac10: Oooops in SCSI
Message-ID: <20010214171025.A5133@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've got an ooops today on a 2.4.1-ac10 running three bonnie++ in
parallel on the RAID-Array. The machine is a IBM Netfinity 7100-8666
with 2.5G RAM and 4 CPUs, the RAID-Controller is an IBM ServeRAID 4L using the
ips driver. All filesystems on this machine are ext2.


(ips0) Resetting controller. (several times)
Unable to handle kernel NULL pointer dereference at virtual address 00000178f889b9e3
*pde = 00000000
Oops: 0002
CPU:    3
EIP:    0010:[<f889b9e3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: c02d5640   ecx: f720c6b8   edx: 00000000
esi: 00000002   edi: f720c6cc   ebp: 00000000   esp: c3ab5da0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c3ab5000)
Stack: f720c6b8 f6dcce00 f720c678 f720c600 c3ab5dfc f6dd7c00 f720c6b8 f720c680 
       f6dcce00 3a8a6121 000d06e7 f889a564 f720c678 00000001 00000202 f78484d8 
       f6dd7c00 f720c600 00000000 00000000 00000001 c3ab5e08 c3ab5e08 00000000 
Call Trace: [<f889a564>] [<c01be446>] [<c01beab0>] [<c01c558c>] [<c01c4c26>] [<c01c4e28>] [<c01c5072>] 
       [<c01e18b2>] [<c01beefb>] [<c01bed96>] [<c011ab41>] [<c011aa27>] [<c011a8cc>] [<c010a7c5>] [<c0107170>] 
       [<c0107170>] [<c010900c>] [<c0107170>] [<c0107170>] [<c0100018>] [<c010719c>] [<c0107202>] [<c0116c36>] 
Code: c7 85 78 01 00 00 00 00 00 00 c7 85 74 01 00 00 00 00 00 00 

>>EIP; f889b9e3 <END_OF_CODE+38578913/????>   <=====
Trace; f889a564 <END_OF_CODE+38577494/????>
Trace; c01be446 <scsi_dispatch_cmd+152/268>
Trace; c01beab0 <scsi_done+0/ec>
Trace; c01c558c <scsi_request_fn+2f0/334>
Trace; c01c4c26 <scsi_queue_next_request+4e/110>
Trace; c01c4e28 <__scsi_end_request+140/14c>
Trace; c01c5072 <scsi_io_completion+18a/370>
Trace; c01e18b2 <rw_intr+1d2/1e0>
Trace; c01beefb <scsi_finish_command+d3/dc>
Trace; c01bed96 <scsi_bottom_half_handler+1fa/210>
Trace; c011ab41 <bh_action+4d/b4>
Trace; c011aa27 <tasklet_hi_action+4f/7c>
Trace; c011a8cc <do_softirq+5c/8c>
Trace; c010a7c5 <do_IRQ+e5/f4>
Trace; c0107170 <default_idle+0/34>
Trace; c0107170 <default_idle+0/34>
Trace; c010900c <ret_from_intr+0/20>
Trace; c0107170 <default_idle+0/34>
Trace; c0107170 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cb>
Trace; c010719c <default_idle+2c/34>
Trace; c0107202 <cpu_idle+3e/54>
Trace; c0116c36 <printk+16e/17c>
Code;  f889b9e3 <END_OF_CODE+38578913/????>
00000000 <_EIP>:
Code;  f889b9e3 <END_OF_CODE+38578913/????>   <=====
   0:   c7 85 78 01 00 00 00      movl   $0x0,0x178(%ebp)   <=====
Code;  f889b9ea <END_OF_CODE+3857891a/????>
   7:   00 00 00 
Code;  f889b9ed <END_OF_CODE+3857891d/????>
   a:   c7 85 74 01 00 00 00      movl   $0x0,0x174(%ebp)
Code;  f889b9f4 <END_OF_CODE+38578924/????>
  11:   00 00 00 

Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

1 warning and 2 errors issued.  Results may not be reliable.


Adam
-- 
Adam                 al10@inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
