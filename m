Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbQLYWaX>; Mon, 25 Dec 2000 17:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131140AbQLYWaN>; Mon, 25 Dec 2000 17:30:13 -0500
Received: from 5dyn231.com21.casema.net ([212.64.96.231]:30224 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130127AbQLYW3y>;
	Mon, 25 Dec 2000 17:29:54 -0500
Date: Mon, 25 Dec 2000 22:59:25 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [bug] test13-pre4 nfs/ip_defrag crash (smp)
Message-ID: <20001225225925.A1276@spaans.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am having some reproducible crashes with 2.4.0-test13-pre4, whenever I
do some 'heavy' nfs-ing.. decoded oops:

ksymoops 2.3.4 on i686 2.4.0-test13-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test13-pre4/ (default)
     -m /boot/System.map-2.4.0-test13-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address eabc089f
c01e263e
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01e263e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: eabc0863   ebx: c40c53e0   ecx: c54a1824   edx: c28079a0
esi: 00000b90   edi: c5a0df40   ebp: 000005c8   esp: ce699c4c
ds: 0018   es: 0018   ss: 0018
Process rpciod (pid: 2358, stackpage=ce699000)
Stack: c28079a0 00000000 00000a2b 0700000a 00000014 00000000 c01e2a2d c28079a0 
       c5a0df40 c02ce7ac ce698000 c36f9c40 c5a0df40 eabc0863 c54a1810 d1147a82 
       c5a0df40 ce699d48 c02f6878 c01e549c ce699d58 d11471c9 c5a0df40 ce699d48 
Call Trace: [<c01e2a2d>] [<eabc0863>] [<d1147a82>] [<c01e549c>] [<d11471c9>] [<c01e549c>] [<c012f810>] 
       [<d114640a>] [<c01e549c>] [<c01dc838>] [<c01e549c>] [<c01e549c>] [<c01dcab7>] [<c01e549c>] [<d114913c>] 
       [<c01e4a3b>] [<c01e549c>] [<c01fa5f8>] [<c01d71d5>] [<c01e4b66>] [<c01fa5f8>] [<ea00000a>] [<c01d50ae>] 
       [<c01faa8e>] [<c01fa5f8>] [<ea00000a>] [<ea00000a>] [<ea00000a>] [<c0200236>] [<c01d21e5>] [<d110b84a>] 
       [<c01e1cd6>] [<c01e1e0c>] [<d11677d0>] [<d1170ee8>] [<d110e7e9>] [<d110b6f5>] [<d11099f3>] [<d110cf3b>] 
       [<d110d264>] [<d110d339>] [<d110dc2b>] [<d1116cc4>] [<d1116cc4>] [<d1116cbc>] [<d1116cbc>] [<c0107480>] 
       [<d1116cc4>] [<d1116cd0>] 
Code: 8b 40 3c 8b 4c 24 1c 89 41 3c c7 47 18 00 00 00 00 8b 54 24 

>>EIP; c01e263e <ip_frag_queue+20a/260>   <=====
Trace; c01e2a2d <ip_defrag+dd/180>
Trace; eabc0863 <END_OF_CODE+19a50de0/????>
Trace; d1147a82 <[8139too]rtl8139_set_rx_mode+56/270>
Trace; c01e549c <output_maybe_reroute+0/14>
Trace; d11471c9 <[8139too]rtl8139_rx_interrupt+151/24c>
Trace; c01e549c <output_maybe_reroute+0/14>
Trace; c012f810 <__alloc_pages+12c/2d4>
Trace; d114640a <[8139too]rtl8139_hw_start+226/574>
Trace; c01e549c <output_maybe_reroute+0/14>
Trace; c01dc838 <nf_iterate+34/88>
Trace; c01e549c <output_maybe_reroute+0/14>
Trace; c01e549c <output_maybe_reroute+0/14>
Trace; c01dcab7 <nf_hook_slow+3f/b8>
Trace; c01e549c <output_maybe_reroute+0/14>
Trace; d114913c <[8139too].data.end+51d/43e1>
Trace; c01e4a3b <ip_build_xmit_slow+3cf/4ac>
Trace; c01e549c <output_maybe_reroute+0/14>
Trace; c01fa5f8 <udp_getfrag+0/c4>
Trace; c01d71d5 <netif_rx+89/f0>
Trace; c01e4b66 <ip_build_xmit+4e/334>
Trace; c01fa5f8 <udp_getfrag+0/c4>
Trace; ea00000a <END_OF_CODE+18e90587/????>
Trace; c01d50ae <__kfree_skb+132/138>
Trace; c01faa8e <udp_sendmsg+38a/414>
Trace; c01fa5f8 <udp_getfrag+0/c4>
Trace; ea00000a <END_OF_CODE+18e90587/????>
Trace; ea00000a <END_OF_CODE+18e90587/????>
Trace; ea00000a <END_OF_CODE+18e90587/????>
Trace; c0200236 <inet_sendmsg+3e/44>
Trace; c01d21e5 <sock_sendmsg+69/88>
Trace; d110b84a <[uhci]uhci_show_queues+13e/228>
Trace; c01e1cd6 <ip_rcv+33e/388>
Trace; c01e1e0c <ip_rcv_finish+0/214>
Trace; d11677d0 <[ipt_LOG].data.end+3bd9/b469>
Trace; d1170ee8 <.bss.end+1465/????>
Trace; d110e7e9 <[uhci]alloc_uhci+2c1/310>
Trace; d110b6f5 <[uhci]uhci_is_skeleton_qh+19/30>
Trace; d11099f3 <[usbcore]usbdevfs_root_inode_operations+13/40>
Trace; d110cf3b <[uhci]uhci_submit_bulk+1b3/238>
Trace; d110d264 <[uhci]uhci_result_isochronous+4/a4>
Trace; d110d339 <[uhci]uhci_find_urb_ep+35/d0>
Trace; d110dc2b <[uhci]rh_submit_urb+7b/670>
Trace; d1116cc4 <[sunrpc]xprt_reserve_status+74/7c>
Trace; d1116cc4 <[sunrpc]xprt_reserve_status+74/7c>
Trace; d1116cbc <[sunrpc]xprt_reserve_status+6c/7c>
Trace; d1116cbc <[sunrpc]xprt_reserve_status+6c/7c>
Trace; c0107480 <kernel_thread+28/38>
Trace; d1116cc4 <[sunrpc]xprt_reserve_status+74/7c>
Trace; d1116cd0 <[sunrpc]xprt_request_init+4/90>
Code;  c01e263e <ip_frag_queue+20a/260>
00000000 <_EIP>:
Code;  c01e263e <ip_frag_queue+20a/260>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c01e2641 <ip_frag_queue+20d/260>
   3:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c01e2645 <ip_frag_queue+211/260>
   7:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c01e2648 <ip_frag_queue+214/260>
   a:   c7 47 18 00 00 00 00      movl   $0x0,0x18(%edi)
Code;  c01e264f <ip_frag_queue+21b/260>
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx

Kernel panic: Aiee, killing interrupt handler!

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
