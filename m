Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTEVTem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTEVTem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:34:42 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:18391 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S263183AbTEVTei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:34:38 -0400
From: Frank Dekervel <kervel-lkml@drie.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: kernel panic on heavily loaded 2.4.20 router
Date: Thu, 22 May 2003 21:47:39 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305222147.39687.kervel-lkml@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

a linux-2.4.20 (vanilla) machine we use as a router/iptables firewall 
crashes once a month in what seems to be the IP stack 
(see the lspci/lsmod/ksymoops output below). Does somebody know
what the cause could be ?

thanks,
greetings,
Frank


---- lspci

00:00.0 Host bridge: Intel Corp. 430FX - 82437FX TSC [Triton I] (rev 01)
00:07.0 ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 02)
00:07.1 IDE interface: Intel Corp. 82371FB PIIX IDE [Triton I] (rev 02)
00:11.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:13.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
00:14.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100] (rev 06)

---- modules

Module                  Size  Used by    Not tainted
ipt_limit                960  19  (autoclean)
ip_conntrack_ftp        3776   0  (unused)
ipt_state                608   4  (autoclean)
ipt_LOG                 3232  13  (autoclean)
iptable_nat            14452   1  (autoclean)
ip_conntrack           16716   3  (autoclean) [ip_conntrack_ftp ipt_state iptable_nat]
iptable_filter          1728   1  (autoclean)
ip_tables              10624   7  [ipt_limit ipt_state ipt_LOG iptable_nat iptable_filter]
serial                 42336   0  (autoclean)
ne2k-pci                4832   2
8390                    5952   0  [ne2k-pci]
via-rhine              11912   1
mii                     2288   0  [via-rhine]
3c59x                  24712   1

---- decoded panic

ksymoops 2.4.5 on i586 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (specified)

CPU: 0
EIP:    0010:[<c01cc5fd>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c0246a40   ebx: c0dd34e0     ecx: c0b118a0       edx: 00000000
esi: c1380300   edi: c07e4220     ebp: c0dc4800       esp: c024bdf0
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c024b000)
Stack:  c1380300 00000000 00000004 c01d886c c01d88fd c1380300 00000001 c0dc4800
        c01ce9c6 c1380300 c1380300 c0dc4800 00000002 c01d5f1c 00000000 c02aee80
        c01d8852 00000002 00000004 c1380300 00000000 c0dc4800 c01d886c c1380300
Call Trace:     [<c01d886c>] [<c01d88fd>] [<c01ce9c6>] [<c01d5f1c>] [<c01d8852>]
   [<c01d886c>] [<c01d5f6a>] [<c01ce9c6>] [<c01d05dc>] [<c01d5ec4>] [<c01d5f1c>]
   [<c01d5178>] [<c01d52f9>] [<c01d5178>] [<c01ce9c6>] [<c01d5006>] [<c01d5178>]
   [<c01c9593>] [<c01c962d>] [<c01c9740>] [<c0116cda>] [<c0109cad>] [<c0106e10>]
   [<c010be38>] [<c0106e10>] [<c0106e33>] [<c0106e97>] [<c0105000>] [<c0105027>]
Code: 62 8b 40 02 25 ff ff 00 04 50 53 57 e8 ee fd ff 83 c4 0c


>>EIP; c01cc5fd <neigh_resolve_output+91/19c>   <=====

>>eax; c0246a40 <ipv4_dst_ops+0/2c>
>>ebx; c0dd34e0 <_end+b2288c/25583ac>
>>ecx; c0b118a0 <_end+860c4c/25583ac>
>>esi; c1380300 <_end+10cf6ac/25583ac>
>>edi; c07e4220 <_end+5335cc/25583ac>
>>ebp; c0dc4800 <_end+b13bac/25583ac>
>>esp; c024bdf0 <init_task_union+1df0/2000>

Trace; c01d886c <ip_finish_output2+0/d0>
Trace; c01d88fd <ip_finish_output2+91/d0>
Trace; c01ce9c6 <nf_hook_slow+ee/144>
Trace; c01d5f1c <ip_forward_finish+0/54>
Trace; c01d8852 <ip_finish_output+fa/100>
Trace; c01d886c <ip_finish_output2+0/d0>
Trace; c01d5f6a <ip_forward_finish+4e/54>
Trace; c01ce9c6 <nf_hook_slow+ee/144>
Trace; c01d05dc <netlink_sendmsg+70/218>
Trace; c01d5ec4 <ip_forward+1a4/1fc>
Trace; c01d5f1c <ip_forward_finish+0/54>
Trace; c01d5178 <ip_rcv_finish+0/1b8>
Trace; c01d52f9 <ip_rcv_finish+181/1b8>
Trace; c01d5178 <ip_rcv_finish+0/1b8>
Trace; c01ce9c6 <nf_hook_slow+ee/144>
Trace; c01d5006 <ip_rcv+336/36c>
Trace; c01d5178 <ip_rcv_finish+0/1b8>
Trace; c01c9593 <netif_receive_skb+ff/12c>
Trace; c01c962d <process_backlog+6d/110>
Trace; c01c9740 <net_rx_action+70/108>
Trace; c0116cda <do_softirq+5a/ac>
Trace; c0109cad <do_IRQ+a1/b4>
Trace; c0106e10 <default_idle+0/28>
Trace; c010be38 <call_do_IRQ+5/d>
Trace; c0106e10 <default_idle+0/28>
Trace; c0106e33 <default_idle+23/28>
Trace; c0106e97 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>

Code;  c01cc5fd <neigh_resolve_output+91/19c>
00000000 <_EIP>:
Code;  c01cc5fd <neigh_resolve_output+91/19c>   <=====
   0:   62 8b 40 02 25 ff         bound  %ecx,0xff250240(%ebx)   <=====
Code;  c01cc603 <neigh_resolve_output+97/19c>
   6:   ff 00                     incl   (%eax)
Code;  c01cc605 <neigh_resolve_output+99/19c>
   8:   04 50                     add    $0x50,%al
Code;  c01cc607 <neigh_resolve_output+9b/19c>
   a:   53                        push   %ebx
Code;  c01cc608 <neigh_resolve_output+9c/19c>
   b:   57                        push   %edi
Code;  c01cc609 <neigh_resolve_output+9d/19c>
   c:   e8 ee fd ff 83            call   83fffdff <_EIP+0x83fffdff> 441cc3fc Before first symbol
Code;  c01cc60e <neigh_resolve_output+a2/19c>
  11:   c4 0c 00                  les    (%eax,%eax,1),%ecx

 <0>Kernel panic: Aiee, killing interrupt handler!



-- 
Frank Dekervel - frank.dekervel@student.kuleuven.ac.be
Mechelsestraat 88
3000 Leuven (Belgium)
