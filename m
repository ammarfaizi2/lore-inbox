Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277117AbRJRBW3>; Wed, 17 Oct 2001 21:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277253AbRJRBWU>; Wed, 17 Oct 2001 21:22:20 -0400
Received: from cs.wustl.edu ([128.252.165.15]:48639 "EHLO
	taumsauk.cs.wustl.edu") by vger.kernel.org with ESMTP
	id <S277117AbRJRBWO>; Wed, 17 Oct 2001 21:22:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15310.11944.631551.254427@samba.doc.wustl.edu>
Date: Wed, 17 Oct 2001 20:21:44 -0500
From: Krishnakumar B <kitty@cs.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: kswapd becomes a zombie with 2.4.10-ac12
X-Mailer: VM 6.96 under 21.4 (patch 4) "Artificial Intelligence" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just saw this in my logs. I also noticed that kswapd has become a zombie.
The machine itself seems ok though I have 512MB RAM.

Please CC me on any replies.

-kitty.


samba> ksymoops -v /u/scratch/downloads/kernel/linux-2.4.10-ac12/vmlinux -m /boo
t/System.map ~/oops.txt 
ksymoops 2.4.3 on i686 2.4.10-ac12.  Options used
     -v /u/scratch/downloads/kernel/linux-2.4.10-ac12/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-ac12/ (default)
     -m /boot/System.map (specified)

 WARNING: unexpected IO-APIC, please mail
cpu: 0, clocks: 1329902, slice: 443300
cpu: 1, clocks: 1329902, slice: 443300
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)
Unable to handle kernel paging request at virtual address 36282062
c014d806
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c014d806>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013202
eax: 36282052   ebx: d5a41200   ecx: d5a41210   edx: db9f9e40
esi: 36282052   edi: d5a41200   ebp: fffffd4d   esp: dfe6ff60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 6, stackpage=dfe6f000)
Stack: db9f9e58 db9f9e40 c014b254 d5a41200 d5a41200 c013be2d 00000000 c19f1000 
       c102afc4 000000c0 c0130207 c102afe0 c102afc4 00000000 00000007 c0130738 
       c102afc4 0000c03f 000000c0 000000c0 0008e000 c014b601 00000000 c0130f0b 
Call Trace: [<c014b254>] [<c013be2d>] [<c0130207>] [<c0130738>] [<c014b601>] 
   [<c0130f0b>] [<c0130f95>] [<c0105000>] [<c0105676>] [<c0130f40>] 
Code: 8b 46 10 85 c0 74 04 53 ff d0 58 68 20 cb 23 c0 8d 43 24 50 

>>EIP; c014d806 <iput+26/220>   <=====
Trace; c014b254 <prune_dcache+f4/170>
Trace; c013be2c <try_to_free_buffers+14c/190>
Trace; c0130206 <try_to_release_page+26/50>
Trace; c0130738 <page_launder+508/950>
Trace; c014b600 <shrink_dcache_memory+20/40>
Trace; c0130f0a <do_try_to_free_pages+1a/50>
Trace; c0130f94 <kswapd+54/d0>
Trace; c0105000 <_stext+0/0>
Trace; c0105676 <kernel_thread+26/30>
Trace; c0130f40 <kswapd+0/d0>
Code;  c014d806 <iput+26/220>
00000000 <_EIP>:
Code;  c014d806 <iput+26/220>   <=====
   0:   8b 46 10                  mov    0x10(%esi),%eax   <=====
Code;  c014d808 <iput+28/220>
   3:   85 c0                     test   %eax,%eax
Code;  c014d80a <iput+2a/220>
   5:   74 04                     je     b <_EIP+0xb> c014d810 <iput+30/220>
Code;  c014d80c <iput+2c/220>
   7:   53                        push   %ebx
Code;  c014d80e <iput+2e/220>
   8:   ff d0                     call   *%eax
Code;  c014d810 <iput+30/220>
   a:   58                        pop    %eax
Code;  c014d810 <iput+30/220>
   b:   68 20 cb 23 c0            push   $0xc023cb20
Code;  c014d816 <iput+36/220>
  10:   8d 43 24                  lea    0x24(%ebx),%eax
Code;  c014d818 <iput+38/220>
  13:   50                        push   %eax

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
