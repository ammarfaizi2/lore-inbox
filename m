Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbQLTR1T>; Wed, 20 Dec 2000 12:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbQLTR1K>; Wed, 20 Dec 2000 12:27:10 -0500
Received: from iris.kkt.bme.hu ([152.66.114.1]:15108 "HELO iris.kkt.bme.hu")
	by vger.kernel.org with SMTP id <S129911AbQLTR07>;
	Wed, 20 Dec 2000 12:26:59 -0500
Date: Wed, 20 Dec 2000 17:56:31 +0100 (CET)
From: PALFFY Daniel <dpalffy@kkt.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: panic with squid's pinger
Message-ID: <Pine.LNX.4.21.0012201735020.11725-100000@iris.kkt.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Reproducible panic when squid gets the first request. Always at the same
place in the pinger process. test12, test13-pre3 fail, but test12 runs
fine on another machine with nearly the same config (netcard and disk
drivers differ, and the failing machine has devfs).

Hardware: Compaq proliant dl360 with a quad starfire card, UP 
(Serverworks chipset), cpqarray.


Unable to handle kernel NULL pointer dereference at virtual address 0000003c
c01a20de
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a20de>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c7b5e9e0   edx: c7b5e9e0
esi: 00001fb1   edi: c7b09c00   ebp: 00001df0   esp: c6e4bc40
ds: 0018   es: 0018   ss: 0018
Process pinger (pid: 289, stackpage=c6e4b000)
Stack: c7b5e9e0 00000000 00008b5e 0100007f 00000014 00000000 c01a2453 c7b5e9e0 
       c7b09c00 c6e4e500 c7b09c00 c01a4db8 c6e4bd44 11e4bc84 00000000 c01c5770 
       c7b09c00 c6e4bd34 c029d998 c01c5089 c7b09c00 c6e4bd34 c029d998 c01a4db8 
Call Trace: [<c01a2453>] [<c01a4db8>] [<c01c5770>] [<c01c5089>] [<c01a4db8>] [<c0108dc8>] [<c01c44e0>] 
       [<c01a4db8>] [<c018ea5c>] [<c01a4db8>] [<c01a4db8>] [<c018ec73>] [<c01a4db8>] [<c01a440b>] [<c01a4db8>] 
       [<c01b82cc>] [<c01a450e>] [<c01b82cc>] [<c01b8725>] [<c01b82cc>] [<c018815b>] [<c0188db0>] [<c01b7aec>] 
       [<c01bd5d6>] [<c01857d5>] [<c018641c>] [<c0128a37>] [<c0128a72>] [<c013a6da>] [<c013a9d8>] [<c018645a>] 
       [<c0186bb1>] [<c0108d1f>] 
Code: 8b 40 3c 89 41 3c 8b 47 5c c7 47 18 00 00 00 00 01 41 18 8b 

>>EIP; c01a20de <ip_frag_queue+20a/254>   <=====
Trace; c01a2453 <ip_defrag+b3/130>
Trace; c01a4db8 <output_maybe_reroute+0/14>
Trace; c01c5770 <ip_ct_gather_frags+1c/94>
Trace; c01c5089 <ip_conntrack_in+39/2cc>
Trace; c01a4db8 <output_maybe_reroute+0/14>
Trace; c0108dc8 <ret_from_intr+0/20>
Trace; c01c44e0 <ip_conntrack_local+54/58>
Trace; c01a4db8 <output_maybe_reroute+0/14>
Trace; c018ea5c <nf_iterate+30/84>
Trace; c01a4db8 <output_maybe_reroute+0/14>
Trace; c01a4db8 <output_maybe_reroute+0/14>
Trace; c018ec73 <nf_hook_slow+3f/b0>
Trace; c01a4db8 <output_maybe_reroute+0/14>
Trace; c01a440b <ip_build_xmit_slow+3cf/484>
Trace; c01a4db8 <output_maybe_reroute+0/14>
Trace; c01b82cc <udp_getfrag+0/c4>
Trace; c01a450e <ip_build_xmit+4e/318>
Trace; c01b82cc <udp_getfrag+0/c4>
Trace; c01b8725 <udp_sendmsg+351/3cc>
Trace; c01b82cc <udp_getfrag+0/c4>
Trace; c018815b <kfree_skbmem+23/6c>
Trace; c0188db0 <skb_free_datagram+1c/20>
Trace; c01b7aec <raw_recvmsg+114/12c>
Trace; c01bd5d6 <inet_sendmsg+3a/40>
Trace; c01857d5 <sock_sendmsg+69/88>
Trace; c018641c <sys_sendto+d0/f0>
Trace; c0128a37 <__free_pages+13/14>
Trace; c0128a72 <free_pages+3a/3c>
Trace; c013a6da <poll_freewait+3a/44>
Trace; c013a9d8 <do_select+1c4/1dc>
Trace; c018645a <sys_send+1e/24>
Trace; c0186bb1 <sys_socketcall+115/1fc>
Trace; c0108d1f <system_call+33/38>
Code;  c01a20de <ip_frag_queue+20a/254>
00000000 <_EIP>:
Code;  c01a20de <ip_frag_queue+20a/254>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c01a20e1 <ip_frag_queue+20d/254>
   3:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c01a20e4 <ip_frag_queue+210/254>
   6:   8b 47 5c                  mov    0x5c(%edi),%eax
Code;  c01a20e7 <ip_frag_queue+213/254>
   9:   c7 47 18 00 00 00 00      movl   $0x0,0x18(%edi)
Code;  c01a20ee <ip_frag_queue+21a/254>
  10:   01 41 18                  add    %eax,0x18(%ecx)
Code;  c01a20f1 <ip_frag_queue+21d/254>
  13:   8b 00                     mov    (%eax),%eax

Kernel panic: Aiee, killing interrupt handler!

Does anyone know, what this can be? If any other information would be
needed, please tell me! Thanks.

--
Dani
			...and Linux for all.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
