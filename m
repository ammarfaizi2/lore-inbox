Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271574AbRHZUwT>; Sun, 26 Aug 2001 16:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271573AbRHZUwK>; Sun, 26 Aug 2001 16:52:10 -0400
Received: from f137.pav1.hotmail.com ([64.4.31.137]:22282 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S271574AbRHZUv7>;
	Sun, 26 Aug 2001 16:51:59 -0400
X-Originating-IP: [64.229.254.92]
From: "Feyr Tlincail" <feyr_t@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops! iptables and kernel 2.4.5
Date: Sun, 26 Aug 2001 20:52:11 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1379BekWo76UaiRNhF00012c3c@hotmail.com>
X-OriginalArrivalTime: 26 Aug 2001 20:52:11.0492 (UTC) FILETIME=[FA606240:01C12E70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for a few months now my gateway box keeps Oops'ing under some circumstance 
(i'm thinking when there's a lot of packets being passed back and forth). 
the box is an HP Vectra VL2 4/66 (486 DX 66 mhz) with 16 megs of ram and a 
500 megs hard disk (150 swap). it has 2 network card (one 3com using driver 
3c509 and the other is a no name using module "ne"), both are ISA (no pci 
bus at all). the connection to the net is an Alcatel Speedtouch Home modem 
(ADSL) connected to eth1 (the "ne" card)

here is what i have found, im using nmap -sT -sU ip:
if I nmap a box on the internet from my gateway it works fine (50ish 
seconds). if i nmap the gateway from a local box it also work (1000ish 
seconds) but if i nmap a box on the internet from a local box, i get an Oops 
on the gateway (pasted at the end)

nmap is how i can replicate it easily, but it does that with a lot of other 
applications too (kazaa being one)

---Oops---
Warning (compare_maps): ksyms_base symbol 
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring 
ksyms_base entry
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01e0ec7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c02f5dc0 ebx: 0000385f ecx: 00000000 edx: 0000385f
esi: c0773950 edi: c02f5e60 ebp: 00000060 esp: c029fddc
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c029f000)
Stack: 00000100 c01e0f6b c0773950 00000100 c0773950 c01e1533 c0773950 
c0773950
       c0eb8800 c0c15200 c0eb8800 ffffffe6 c01e4516 c0773950 00000002 
c093d6f0
       c0773950 c01e77d3 c0773950 c0773950 00000000 00000004 c01f1d30 
c01f1dad
Call Trace: [<c01e0f6b>] [<c01e1533>] [<c01e4516>] [<c01e77d3>] [<c01f1d30>] 
[<c01f1dad>] [<c01e99b7>] [<c01ef3f0>]
[<c01f1d02>] [<c01f1d30>] [<c01ef43a>] [<c01e99b7>] [<c01e05dc>] 
[<c01ef394>] [<c01ef3f0>] [<c01ee620>] [<c01ee7a9>]
[<c01ee620>] [<c01e99b7>] [<c01ee466>] [<c01ee620>] [<c01e4b3d>] 
[<c011317f>] [<c0108071>] [<c0105140>] [<c0106c60>]
[<c0105140>] [<c0105163>] [<c01051c8>] [<c0105000>] [<c0100197>]
Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09

>>EIP; c01e0ec7 <skb_drop_fraglist+17/40>   <=====
Trace; c01e0f6b <skb_release_data+5b/70>
Trace; c01e1533 <skb_linearize+d3/140>
Trace; c01e4516 <dev_queue_xmit+26/1f0>
Trace; c01e77d3 <neigh_resolve_output+113/190>
Trace; c01f1d30 <ip_finish_output2+0/c0>
Trace; c01f1dad <ip_finish_output2+7d/c0>
Trace; c01e99b7 <nf_hook_slow+e7/130>
Trace; c01ef3f0 <ip_forward_finish+0/50>
Trace; c01f1d02 <ip_finish_output+e2/f0>
Trace; c01f1d30 <ip_finish_output2+0/c0>
Trace; c01ef43a <ip_forward_finish+4a/50>
Trace; c01e99b7 <nf_hook_slow+e7/130>
Trace; c01e05dc <__lock_sock+5c/a0>
Trace; c01ef394 <ip_forward+1a4/200>
Trace; c01ef3f0 <ip_forward_finish+0/50>
Trace; c01ee620 <ip_rcv_finish+0/1c0>
Trace; c01ee7a9 <ip_rcv_finish+189/1c0>
Trace; c01ee620 <ip_rcv_finish+0/1c0>
Trace; c01e99b7 <nf_hook_slow+e7/130>
Trace; c01ee466 <ip_rcv+336/370>
Trace; c01ee620 <ip_rcv_finish+0/1c0>
Trace; c01e4b3d <net_rx_action+19d/280>
Trace; c011317f <do_softirq+3f/70>
Trace; c0108071 <do_IRQ+a1/b0>
Trace; c0105140 <default_idle+0/30>
Trace; c0106c60 <ret_from_intr+0/20>
Trace; c0105140 <default_idle+0/30>
Trace; c0105163 <default_idle+23/30>
Trace; c01051c8 <cpu_idle+38/50>
Trace; c0105000 <prepare_namespace+0/10>
Trace; c0100197 <L6+0/2>
Code;  c01e0ec7 <skb_drop_fraglist+17/40>
00000000 <_EIP>:
Code;  c01e0ec7 <skb_drop_fraglist+17/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c01e0ec9 <skb_drop_fraglist+19/40>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c01e0ecc <skb_drop_fraglist+1c/40>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c01e0ecf <skb_drop_fraglist+1f/40>
   8:   74 0a                     je     14 <_EIP+0x14> c01e0edb 
<skb_drop_fraglist+2b/40>
Code;  c01e0ed1 <skb_drop_fraglist+21/40>
   a:   ff 4a 70                  decl   0x70(%edx)
Code;  c01e0ed4 <skb_drop_fraglist+24/40>
   d:   0f 94 c0                  sete   %al
Code;  c01e0ed7 <skb_drop_fraglist+27/40>
  10:   84 c0                     test   %al,%al
Code;  c01e0ed9 <skb_drop_fraglist+29/40>
  12:   74 09                     je     1d <_EIP+0x1d> c01e0ee4 
<skb_drop_fraglist+34/40>

Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.




_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

