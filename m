Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUGSJ1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUGSJ1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 05:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUGSJ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 05:27:34 -0400
Received: from relay1.aspec.ru ([217.14.198.4]:21000 "EHLO mail.aspec.ru")
	by vger.kernel.org with ESMTP id S264882AbUGSJ11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 05:27:27 -0400
Message-ID: <40FB9119.5030507@belkam.com>
Date: Mon, 19 Jul 2004 14:15:05 +0500
From: Dmitry Melekhov <dm@belkam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.26, sundance, oops
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I run 2.4.26 (patched with ebtables) with quad-head D-link DFE-580TX 
with sundance driver, shipped with kernel.
Two of card ports (eth0 and eth1) are in bridge device (br0).
eth1 is 100Mbit/half duplex, eth0 is in 100Mbit/full duplex.
Crash happened when I tried to move eth0 to half duplex too and 
disconnected it from switch...
(btw, this computer crashed 2 days ago, but I were out of office, so I 
have no opps info).
And I'm not good enough programmer to read kernel sources... :-(
Please, help me!

Here is ksymoops output:

skput:under: ce861f35:1518 put:14 dev:eth1kernel BUG at skbuff

CPU:    0
EIP:    0010:[<c020a4d9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000002a   ebx: ca97e320   ecx: 00000000   edx: cd7f8000
esi: ca3c8010   edi: 00000009   ebp: caa0ea80   esp: c0301b38
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0301000)
Stack: c02a3140 ce861f35 000005ee 0000000e cd898000 ce861f3e ca97e320 
0000000e
       ce861f35 ca97e320 c02280ef ca97e320 00000014 00000000 000005c8 
000005c8
       0000001c 000005c8 ce8680c0 000005dc c0301c1c ce868220 ce861ed0 
ce861ed0
Call Trace:    [<ce861f35>] [<ce861f3e>] [<ce861f35>] [<c02280ef>] 
[<ce8680c0>]
  [<ce868220>] [<ce861ed0>] [<ce861ed0>] [<ce8c743c>] [<ce861ed0>] 
[<c0215b78>]
  [<ce861ed0>] [<c0215e85>] [<ce861ed0>] [<ce8cd0d0>] [<ce865e2f>] 
[<ce861ed0>]
  [<ce861ed0>] [<c0215b78>] [<ce861ed0>] [<c0215e85>] [<ce861ed0>] 
[<ce868340>]
  [<ce861fca>] [<ce861ed0>] [<c0215ec5>] [<ce86596e>] [<ce861f90>] 
[<c0215ec5>]
  [<ce861f90>] [<ce865adc>] [<ce865910>] [<c0215b78>] [<ce861f90>] 
[<c0215e85>]
  [<ce861f90>] [<ce868310>] [<ce862056>] [<ce861f90>] [<ce862b8e>] 
[<c0215ec5>]
  [<ce86544d>] [<ce862ad0>] [<ce865380>] [<c0215e85>] [<c0215ec5>] 
[<ce862ad0>]
  [<ce865801>] [<ce865380>] [<c0215b78>] [<ce862ad0>] [<c0215e85>] 
[<ce862ad0>]
  [<ce8682e0>] [<ce862cf3>] [<ce862ad0>] [<c020ed09>] [<c020ee70>] 
[<c020ef8f>]
  [<c011bc09>] [<c0109f51>] [<c0106f30>] [<c010c3a8>] [<c0106f30>] 
[<c0106f54>]
  [<c0106fc2>] [<c0105000>]
Code: 0f 0b 6d 00 0f 17 2a c0 83 c4 14 c3 8d 74 26 00 8d bc 27 00


 >>EIP; c020a4d9 <skb_under_panic+29/40>   <=====

 >>ebx; ca97e320 <_end+a6221dc/e4b0f6c>
 >>edx; cd7f8000 <_end+d49bebc/e4b0f6c>
 >>esi; ca3c8010 <_end+a06becc/e4b0f6c>
 >>ebp; caa0ea80 <_end+a6b293c/e4b0f6c>
 >>esp; c0301b38 <init_task_union+1b38/c5b6>

Trace; ce861f35 <[bridge].text.start+ed5/5190>
Trace; ce861f3e <[bridge].text.start+ede/5190>
Trace; ce861f35 <[bridge].text.start+ed5/5190>
Trace; c02280ef <ip_fragment+2cf/580>
Trace; ce8680c0 <[bridge].data.start+60/4d7>
Trace; ce868220 <[bridge].data.start+1c0/4d7>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; ce8c743c <[ip_conntrack].text.start+3dc/36ef>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; c0215b78 <nf_getsockopt+88/c0>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; c0215e85 <nf_hook_slow+65/150>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; ce8cd0d0 <[ip_conntrack].data.start+30/893>
Trace; ce865e2f <[bridge].text.start+4dcf/5190>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; c0215b78 <nf_getsockopt+88/c0>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; c0215e85 <nf_hook_slow+65/150>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; ce868340 <[bridge].data.start+2e0/4d7>
Trace; ce861fca <[bridge].text.start+f6a/5190>
Trace; ce861ed0 <[bridge].text.start+e70/5190>
Trace; c0215ec5 <nf_hook_slow+a5/150>
Trace; ce86596e <[bridge].text.start+490e/5190>
Trace; ce861f90 <[bridge].text.start+f30/5190>
Trace; c0215ec5 <nf_hook_slow+a5/150>
Trace; ce861f90 <[bridge].text.start+f30/5190>
Trace; ce865adc <[bridge].text.start+4a7c/5190>
Trace; ce865910 <[bridge].text.start+48b0/5190>
Trace; c0215b78 <nf_getsockopt+88/c0>
Trace; ce861f90 <[bridge].text.start+f30/5190>
Trace; c0215e85 <nf_hook_slow+65/150>
Trace; ce861f90 <[bridge].text.start+f30/5190>
Trace; ce868310 <[bridge].data.start+2b0/4d7>
Trace; ce862056 <[bridge].text.start+ff6/5190>
Trace; ce861f90 <[bridge].text.start+f30/5190>
Trace; ce862b8e <[bridge].text.start+1b2e/5190>
Trace; c0215ec5 <nf_hook_slow+a5/150>
Trace; ce86544d <[bridge].text.start+43ed/5190>
Trace; ce862ad0 <[bridge].text.start+1a70/5190>
Trace; ce865380 <[bridge].text.start+4320/5190>
Trace; c0215e85 <nf_hook_slow+65/150>
Trace; c0215ec5 <nf_hook_slow+a5/150>
Trace; ce862ad0 <[bridge].text.start+1a70/5190>
Trace; ce865801 <[bridge].text.start+47a1/5190>
Trace; ce865380 <[bridge].text.start+4320/5190>
Trace; c0215b78 <nf_getsockopt+88/c0>
Trace; ce862ad0 <[bridge].text.start+1a70/5190>
Trace; c0215e85 <nf_hook_slow+65/150>
Trace; ce862ad0 <[bridge].text.start+1a70/5190>
Trace; ce8682e0 <[bridge].data.start+280/4d7>
Trace; ce862cf3 <[bridge].text.start+1c93/5190>
Trace; ce862ad0 <[bridge].text.start+1a70/5190>
Trace; c020ed09 <netif_receive_skb+a9/3d0>
Trace; c020ee70 <netif_receive_skb+210/3d0>
Trace; c020ef8f <netif_receive_skb+32f/3d0>
Trace; c011bc09 <do_softirq+99/a0>
Trace; c0109f51 <enable_irq+121/130>
Trace; c0106f30 <default_idle+0/b0>
Trace; c010c3a8 <disable_irq_nosync+1e98/3030>
Trace; c0106f30 <default_idle+0/b0>
Trace; c0106f54 <default_idle+24/b0>
Trace; c0106fc2 <default_idle+92/b0>
Trace; c0105000 <empty_zero_page+1000/2f10>

Code;  c020a4d9 <skb_under_panic+29/40>
00000000 <_EIP>:
Code;  c020a4d9 <skb_under_panic+29/40>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c020a4db <skb_under_panic+2b/40>
   2:   6d                        insl   (%dx),%es:(%edi)
Code;  c020a4dc <skb_under_panic+2c/40>
   3:   00 0f                     add    %cl,(%edi)
Code;  c020a4de <skb_under_panic+2e/40>
   5:   17                        pop    %ss
Code;  c020a4df <skb_under_panic+2f/40>
   6:   2a c0                     sub    %al,%al
Code;  c020a4e1 <skb_under_panic+31/40>
   8:   83 c4 14                  add    $0x14,%esp
Code;  c020a4e4 <skb_under_panic+34/40>
   b:   c3                        ret
Code;  c020a4e5 <skb_under_panic+35/40>
   c:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c020a4e9 <skb_under_panic+39/40>
  10:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi

 <0>Kernel panic: Aiee, killing interrupt handler!


