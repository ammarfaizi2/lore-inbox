Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263342AbTIWKmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 06:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTIWKmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 06:42:17 -0400
Received: from pop.gmx.net ([213.165.64.20]:34231 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261939AbTIWKmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 06:42:13 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2003 12:42:22 +0200
MIME-Version: 1.0
Subject: How to understand an oops?
Message-ID: <3F703FAE.32215.13B8E21F@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

using samba 2.2.8a with kernel 2.4.20 or 2.4.23pre1 ends in an oops. 
In several mailings to the lkml I tried to get help but unfortunately 
nobody did answer me.

I'm trying to interpret all the oopses myself. I reproduced the 
kernel panic in different configurations - with or without LVM or 
RAID. What all oopses do have common is the "Code" section. 
skb_drop_fraglist is listed herein. skb_drop_fraglist is defined in 
net/core/skbuff.c.

Does the code section mean that the kernel panic occurred during 
execution of this code?
How likely is it that a bug in net/core/skbuff.c is causing the 
kernel panic?
How can I find other code/modules from which skb_drop_fraglist is 
called and used?
What is the best way interpreting such an oops?

################## oops #####################
Oops: 0000
CPU:    0
EIP:    0010:[<c0219cd7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c40866a0   ebx: 00200000   ecx: c40866a0   edx: 00200000
esi: cec57360   edi: fffffff9   ebp: 00000046   esp: c0303f2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0303000)
Stack: cec57360 c0219d6e cec57360 cec57360 cec57360 c0219dab cec57360 
cec57360
       c0219efc cec57360 cf49cb20 c021e173 cec57360 00000003 c032c568 
c0120629
       c032c568 00000006 0000000e c0303f98 d3e02e40 c010a091 c0106f40 
c0302000
Call Trace:    [<c0219d6e>] [<c0219dab>] [<c0219efc>] [<c021e173>] 
[<c0120629>]
  [<c010a091>] [<c0106f40>] [<c010c4e8>] [<c0106f40>] [<c0106f64>] 
[<c0106fd2>]
  [<c0105000>]
Code: 8b 1b 8b 42 74 48 74 0a ff 4a 74 0f 94 c0 84 c0 74 07 52 e8


>>EIP; c0219cd7 <skb_drop_fraglist+17/40>   <=====

>>eax; c40866a0 <_end+3cf81fc/14e64bbc>
>>ecx; c40866a0 <_end+3cf81fc/14e64bbc>
>>esi; cec57360 <_end+e8c8ebc/14e64bbc>
>>esp; c0303f2c <init_task_union+1f2c/2000>

Trace; c0219d6e <skb_release_data+4e/80>
Trace; c0219dab <kfree_skbmem+b/70>
Trace; c0219efc <__kfree_skb+ec/150>
Trace; c021e173 <net_tx_action+33/a0>
Trace; c0120629 <do_softirq+99/a0>
Trace; c010a091 <do_IRQ+a1/b0>
Trace; c0106f40 <default_idle+0/30>
Trace; c010c4e8 <call_do_IRQ+5/d>
Trace; c0106f40 <default_idle+0/30>
Trace; c0106f64 <default_idle+24/30>
Trace; c0106fd2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c0219cd7 <skb_drop_fraglist+17/40>
00000000 <_EIP>:
Code;  c0219cd7 <skb_drop_fraglist+17/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c0219cd9 <skb_drop_fraglist+19/40>
   2:   8b 42 74                  mov    0x74(%edx),%eax
Code;  c0219cdc <skb_drop_fraglist+1c/40>
   5:   48                        dec    %eax
Code;  c0219cdd <skb_drop_fraglist+1d/40>
   6:   74 0a                     je     12 <_EIP+0x12>
Code;  c0219cdf <skb_drop_fraglist+1f/40>
   8:   ff 4a 74                  decl   0x74(%edx)
Code;  c0219ce2 <skb_drop_fraglist+22/40>
   b:   0f 94 c0                  sete   %al
Code;  c0219ce5 <skb_drop_fraglist+25/40>
   e:   84 c0                     test   %al,%al
Code;  c0219ce7 <skb_drop_fraglist+27/40>
  10:   74 07                     je     19 <_EIP+0x19>
Code;  c0219ce9 <skb_drop_fraglist+29/40>
  12:   52                        push   %edx
Code;  c0219cea <skb_drop_fraglist+2a/40>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <0>Kernel panic: Aiee, killing interrupt handler!
#################################

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

