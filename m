Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWEORql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWEORql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWEORqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:46:39 -0400
Received: from mail.unixshell.com ([207.210.106.37]:61877 "EHLO
	mail.unixshell.com") by vger.kernel.org with ESMTP id S965021AbWEORqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:46:35 -0400
Message-ID: <4468BE70.7030802@tektonic.net>
Date: Mon, 15 May 2006 13:46:24 -0400
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Panic in ipt_do_table with 2.6.16.13-xen
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been noticing this same problem dozens of times and have finally 
caught a full trace.  I have run it through ksymoops, but there is no 
/proc/ksyms.  Is there a better method for getting information out of 
the Code line than using ksymoops in 2.6 kernels?

The kernel is for Xen, but it does not appear to be related to Xen.

ksymoops run:

# ksymoops -m System.map -k /proc/kallsyms </root/xen-oops.log
ksymoops 2.4.9 on i686 2.6.16.13-xen.  Options used
      -V (default)
      -k /proc/kallsyms (specified)
      -l /proc/modules (default)
      -o /lib/modules/2.6.16.13-xen/ (default)
      -m System.map (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a 
valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual addr
c03d96a9
008c2000 -> *pde = 00000001:aeead001
00e1f000 -> *pme = 00000000:eb2ef067
0faef000 -> *pte = 00000000:00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0061:[<c03d96a9>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.16.13-xen #1)
eax: 00000002   ebx: cfcc6020   ecx: cfcc6020   edx: 00000000
esi: d1320000   edi: 00004000   ebp: d1324a00   esp: c0517d8c
ds: 007b   es: 007b   ss: 0069
Stack: <0>c04d056c 00000000 cfcc6020 00000000 cffa8000 c7f4fc00 d1320000 
0000000
00000001 00000000 c0517e2c 80000000 c03acc04 c7f4fc00 c03da724 c0517e70
00000002 cffa8000 c7f4fc00 c04d0540 00000000 c03a2e50 00000002 c0517e70
Call Trace:
[<c03acc04>] ip_forward_finish+0x0/0x36
[<c03da724>] ipt_hook+0x1c/0x20
[<c03a2e50>] nf_iterate+0x2c/0x5e
[<c03acc04>] ip_forward_finish+0x0/0x36
[<c03acc04>] ip_forward_finish+0x0/0x36
[<c03a2f4b>] nf_hook_slow+0x3c/0xc3
[<c03acc04>] ip_forward_finish+0x0/0x36
[<c03acdd8>] ip_forward+0x19e/0x22e
[<c03acc04>] ip_forward_finish+0x0/0x36
[<c03abcf7>] ip_rcv+0x40e/0x48f
[<c037dcb5>] netif_receive_skb+0x255/0x294
[<c02e82e6>] tg3_poll+0x532/0x76c
[<c037bd82>] net_rx_action+0xaa/0x17c
[<c011ea17>] __do_softirq+0x73/0xf0
[<c011ead4>] do_softirq+0x40/0x64
[<c010606b>] do_IRQ+0x1f/0x25
[<c02fc87f>] evtchn_do_upcall+0x60/0x96
[<c0104a2c>] hypervisor_callback+0x2c/0x34
[<c010342e>] xen_idle+0x5e/0x7d
[<c0103509>] cpu_idle+0xbc/0xd5
[<c05184e0>] start_kernel+0x344/0x34b
Code: 89 44 24 18 89 c6 8b 44 24 40 8b 6c 24 18 03 74 83 0c 03 6c 83 20 
c7 44 24


 >>EIP; c03d96a9 <ipt_do_table+ad/2d0>   <=====

 >>esp; c0517d8c <init_thread_union+1d8c/2000>

Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03da724 <ipt_hook+1c/20>
Trace; c03a2e50 <nf_iterate+2c/5e>
Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03a2f4b <nf_hook_slow+3c/c3>
Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03acdd8 <ip_forward+19e/22e>
Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03abcf7 <ip_rcv+40e/48f>
Trace; c037dcb5 <netif_receive_skb+255/294>
Trace; c02e82e6 <tg3_poll+532/76c>
Trace; c037bd82 <net_rx_action+aa/17c>
Trace; c011ea17 <__do_softirq+73/f0>
Trace; c011ead4 <do_softirq+40/64>
Trace; c010606b <do_IRQ+1f/25>
Trace; c02fc87f <evtchn_do_upcall+60/96>
Trace; c0104a2c <hypervisor_callback+2c/34>
Trace; c010342e <xen_idle+5e/7d>
Trace; c0103509 <cpu_idle+bc/d5>
Trace; c05184e0 <start_kernel+344/34b>

Code;  c03d96a9 <ipt_do_table+ad/2d0>
00000000 <_EIP>:
Code;  c03d96a9 <ipt_do_table+ad/2d0>   <=====
    0:   89 44 24 18               mov    %eax,0x18(%esp)   <=====
Code;  c03d96ad <ipt_do_table+b1/2d0>
    4:   89 c6                     mov    %eax,%esi
Code;  c03d96af <ipt_do_table+b3/2d0>
    6:   8b 44 24 40               mov    0x40(%esp),%eax
Code;  c03d96b3 <ipt_do_table+b7/2d0>
    a:   8b 6c 24 18               mov    0x18(%esp),%ebp
Code;  c03d96b7 <ipt_do_table+bb/2d0>
    e:   03 74 83 0c               add    0xc(%ebx,%eax,4),%esi
Code;  c03d96bb <ipt_do_table+bf/2d0>
   12:   03 6c 83 20               add    0x20(%ebx,%eax,4),%ebp
Code;  c03d96bf <ipt_do_table+c3/2d0>
   16:   c7 44 24 00 00 00 00      movl   $0x0,0x0(%esp)
Code;  c03d96c6 <ipt_do_table+ca/2d0>
   1d:   00


1 warning issued.  Results may not be reliable.
