Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTFQJHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTFQJHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:07:31 -0400
Received: from mail.skjellin.no ([80.239.42.67]:56740 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261188AbTFQJHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:07:24 -0400
Subject: Re: 2.4.21 oops second time
From: Andre Tomt <andre@tomt.net>
To: Robert Grzelak <rg@nix.ll.pl>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <00d801c3343a$9452aea0$083a0ed4@deltav>
References: <00d801c3343a$9452aea0$083a0ed4@deltav>
Content-Type: multipart/mixed; boundary="=-n2p0AZfGfpGJ532fVGiv"
Organization: 
Message-Id: <1055841673.7481.13.camel@slurv.ws.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 17 Jun 2003 11:21:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n2p0AZfGfpGJ532fVGiv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

(Added CC to netdev)

On man, 2003-06-16 at 21:07, Robert Grzelak wrote:
> Welcome!
> My colege Andrzej Sosnowski  in post "2.4.21 oops"
> has write about error in kernel 2.4.21 in time of using this script
> "#!/bin/sh
> for IP in `/usr/bin/seq 3 500`; do
>   ip addr add 3ffe:80ee:c1d::$IP/48 dev eth0
>   ip addr add 3ffe:80ee:c1d::a:$IP/48 dev eth0
> done"

I adapted this script a bit, and got it reproduced. It _seems_
(unverified) to not trigger as fast over ssh, as on local console, for
some reason.

You can wonder about the legitimacy of adding almost 1000 addresses to
one interface, however, it should not crash, rather return something
more useful when it happens and the kernel can not handle it.

Captured the OOPS over serial console, and decoded it, attached.

-- 
André Tomt
andre@tomt.net

--=-n2p0AZfGfpGJ532fVGiv
Content-Disposition: attachment; filename=oops.decode
Content-Type: text/plain; name=oops.decode; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.8 on i686 2.4.21-s2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-s2/ (default)
     -m /boot/System.map-2.4.21-s2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at sched.c:564!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011387f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000018   ebx: c15e5760   ecx: dd6bc000   edx: df57bf7c
esi: dd6bc000   edi: dd6bdb98   ebp: dd6bdb44   esp: dd6bdb1c
ds: 0018   es: 0018   ss: 0018
Process ip (pid: 6645, stackpage=dd6bd000)
Stack: c0261e8a 00000202 dd6bc000 00000000 dd6bc000 00000000 0000d424 c15e5760
       7fffffff dd6bdb98 dd6bdb80 c0113535 0000d400 c15e1d60 c15e1c00 c15a0fe0
       04000001 dd6bdbac 0000000a c0108e05 0000000a c15e1c00 dd6bdbac c15e5760
Call Trace:    [<c0113535>] [<c0108e05>] [<c01eeff2>] [<c01ef0a0>] [<c01fa933>]
  [<c01ef1ff>] [<c0244163>] [<c02444e6>] [<c0243938>] [<c02446f8>] [<c02323ec>]
  [<c010610b>] [<c023347e>] [<c010610b>] [<c02339d7>] [<c01fa211>] [<c01fa040>]
  [<c01f9e4b>] [<c01fc33a>] [<c01fbc47>] [<c01fc0aa>] [<c01ec725>] [<c01edc7b>]
  [<c0124f89>] [<c0125147>] [<c0112848>] [<c0125936>] [<c01269f5>] [<c01ee152>]
  [<c012582f>] [<c010738f>]
Code: 0f 0b 34 02 82 1e 26 c0 e9 0b fd ff ff 0f 0b 2d 02 82 1e 26


>>EIP; c011387f <schedule+32f/350>   <=====

>>ebx; c15e5760 <_end+12cd418/20562d18>
>>ecx; dd6bc000 <_end+1d3a3cb8/20562d18>
>>edx; df57bf7c <_end+1f263c34/20562d18>
>>esi; dd6bc000 <_end+1d3a3cb8/20562d18>
>>edi; dd6bdb98 <_end+1d3a5850/20562d18>
>>ebp; dd6bdb44 <_end+1d3a57fc/20562d18>
>>esp; dd6bdb1c <_end+1d3a57d4/20562d18>

Trace; c0113535 <schedule_timeout+a5/b0>
Trace; c0108e05 <handle_IRQ_event+45/70>
Trace; c01eeff2 <sock_wait_for_wmem+a2/d0>
Trace; c01ef0a0 <sock_alloc_send_pskb+80/1b0>
Trace; c01fa933 <qdisc_restart+53/f0>
Trace; c01ef1ff <sock_alloc_send_skb+2f/40>
Trace; c0244163 <igmp6_send+83/3c0>
Trace; c02444e6 <igmp6_join_group+46/100>
Trace; c0243938 <igmp6_group_added+68/c0>
Trace; c02446f8 <ipv6_mc_up+28/50>
Trace; c02323ec <ipv6_find_idev+4c/90>
Trace; c010610b <__down_failed_trylock+7/c>
Trace; c023347e <addrconf_add_dev+2e/80>
Trace; c010610b <__down_failed_trylock+7/c>
Trace; c02339d7 <inet6_addr_add+47/f0>
Trace; c01fa211 <rtnetlink_rcv_msg+161/23f>
Trace; c01fa040 <rtnetlink_rcv_skb+50/c0>
Trace; c01f9e4b <rtnetlink_rcv+6b/f0>
Trace; c01fc33a <netlink_data_ready+6a/80>
Trace; c01fbc47 <netlink_unicast+237/290>
Trace; c01fc0aa <netlink_sendmsg+19a/260>
Trace; c01ec725 <sock_sendmsg+75/c0>
Trace; c01edc7b <sys_sendmsg+18b/1f0>
Trace; c0124f89 <do_no_page+79/1c0>
Trace; c0125147 <handle_mm_fault+77/100>
Trace; c0112848 <do_page_fault+178/4de>
Trace; c0125936 <__vma_link+56/c0>
Trace; c01269f5 <do_brk+1c5/210>
Trace; c01ee152 <sys_socketcall+242/260>
Trace; c012582f <sys_brk+ef/130>
Trace; c010738f <system_call+33/38>

Code;  c011387f <schedule+32f/350>
00000000 <_EIP>:
Code;  c011387f <schedule+32f/350>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0113881 <schedule+331/350>
   2:   34 02                     xor    $0x2,%al
Code;  c0113883 <schedule+333/350>
   4:   82                        (bad)  
Code;  c0113884 <schedule+334/350>
   5:   1e                        push   %ds
Code;  c0113885 <schedule+335/350>
   6:   26                        es
Code;  c0113886 <schedule+336/350>
   7:   c0 e9 0b                  shr    $0xb,%cl
Code;  c0113889 <schedule+339/350>
   a:   fd                        std    
Code;  c011388a <schedule+33a/350>
   b:   ff                        (bad)  
Code;  c011388b <schedule+33b/350>
   c:   ff 0f                     decl   (%edi)
Code;  c011388d <schedule+33d/350>
   e:   0b 2d 02 82 1e 26         or     0x261e8202,%ebp

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--=-n2p0AZfGfpGJ532fVGiv--

