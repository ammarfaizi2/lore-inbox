Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265131AbRGAOIG>; Sun, 1 Jul 2001 10:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265133AbRGAOH4>; Sun, 1 Jul 2001 10:07:56 -0400
Received: from linux.kappa.ro ([194.102.255.131]:16612 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S265131AbRGAOHp>;
	Sun, 1 Jul 2001 10:07:45 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Sun, 1 Jul 2001 17:09:41 +0300
From: Mircea Damian <dmircea@kappa.ro>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: 2.4.6-pre[5-8] fails to boot on my computer but ...
Message-ID: <20010701170941.A10303@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


... 2.4.0 - 2.4.5-pre1 work just fine.

Since the last changes related to the softirq stuff I'm getting an OOPS at
boot after:

Calibrating delay loop... kernel BUG at softirq.c:206!

Here is the decode trace:

ksymoops 2.3.4 on i686 2.4.5-pre1.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.5-pre1/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0115e82>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001d   ebx: c02cc2c0   ecx: 00000001 edx: 00000001
esi: c02cc2c0   edi: 00000001   ebp: 00000000 esp: c027df60
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c027d000)
Stack: c0226bf1 c0226c8d 000000ce c02b6880 00000009 c02b6880 c027dfa4 c0115ca1
       c02b6880 00000000 00000000 c0269034 c0107ef1 00000001 000a0600 c0105000
       c02af900 0008e000 c0106be0 00000001 00000001 00000001 000a0600 c0105000
Call Trace: [<c0115ca1>] [<c0107ef1>] [<c0105000>] [<c0106be0>] [<c0105000>] [<c0105000>]
Code: 0f 0b 83 c4 0c 90 8b 43 08 85 c0 75 15 fb 8b 43 10 50 8b 43

>>EIP; c0115e82 <tasklet_hi_action+6a/ac>   <=====
Trace; c0115ca1 <do_softirq+45/68>
Trace; c0107ef1 <do_IRQ+9d/b0>
Trace; c0105000 <_stext+0/0>
Trace; c0106be0 <ret_from_intr+0/7>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Code;  c0115e82 <tasklet_hi_action+6a/ac>
0000000000000000 <_EIP>:
Code;  c0115e82 <tasklet_hi_action+6a/ac>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0115e84 <tasklet_hi_action+6c/ac>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0115e87 <tasklet_hi_action+6f/ac>
   5:   90                        nop    
Code;  c0115e88 <tasklet_hi_action+70/ac>
   6:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c0115e8b <tasklet_hi_action+73/ac>
   9:   85 c0                     test   %eax,%eax
Code;  c0115e8d <tasklet_hi_action+75/ac>
   b:   75 15                     jne    22 <_EIP+0x22> c0115ea4 <tasklet_hi_action+8c/ac>
Code;  c0115e8f <tasklet_hi_action+77/ac>
   d:   fb                        sti    
Code;  c0115e90 <tasklet_hi_action+78/ac>
   e:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c0115e93 <tasklet_hi_action+7b/ac>
  11:   50                        push   %eax
Code;  c0115e94 <tasklet_hi_action+7c/ac>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

Kernel panic: Aiee, killing interrupt handler!


If you need any other info please see my previous post:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0106.2/0790.html

(about the same problem and the OOPS is almost the same) 

or just drop me an e-mail.

Please advise!


-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
