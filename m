Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVAUHrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVAUHrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVAUHrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:47:04 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:349 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262267AbVAUHqz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:46:55 -0500
Date: Fri, 21 Jan 2005 08:46:20 +0100 (CET)
From: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
X-X-Sender: lukasz@lt.wsisiz.edu.pl
To: chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd)
In-Reply-To: <200501181659.j0IGx7km019753@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.61L.0501210835270.6993@lt.wsisiz.edu.pl>
References: <200501181659.j0IGx7km019753@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (portraits.wsisiz.edu.pl [0.0.0.0]); Fri, 21 Jan 2005 08:46:38 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, chas williams - CONTRACTOR wrote:

> the system keeps running right?  the error is a 'warning' that the
> fore200e is driver is sleeping when it should not (probably while holding
> interrupts).  the schedule() around like 1782 is not a good idea since
> the fore200e_send() might not be running in a sleepable context.  just
> try commenting that line for now.

Sorry, but I don;t understand, what line, i am not kernel guru. :/

oceanic:/usr/src/linux-2.4.29$ grep  fore200e_send * -r
drivers/atm/fore200e.c:fore200e_send(struct atm_vcc *vcc, struct sk_buff 
*skb)
drivers/atm/fore200e.c: send:         fore200e_send,


Is was happened on 2.4.29, too. It is a interrupt problem?

Below Oops from 2.4.29:

ksymoops 2.4.11 on i686 2.4.29.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.29/ (default)
      -m /lib/modules/2.4.29/System.map (specified)

kernel BUG at sched.c:564!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0114f57>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000018   ebx: f76d2088   ecx: c02b2000   edx: f7651f7c
esi: 00000000   edi: 00000000   ebp: c02b3cdc   esp: c02b3cac
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b3000)
Stack: c026b646 376e8c01 f8888470 00000054 c02b2000 f7c95494 c02b2000 00000000
        00000054 f76d2088 00000246 f76d3084 f76d00e8 f8843d42 f76d0000 f8888950
        00000038 00000001 f67d7c10 00000038 00000000 00000038 00000000 0000001f
Call Trace:    [<f8843d42>] [<c02599d6>] [<c01fe4a9>] [<c01f36df>] [<c020fa03>]
   [<c01fda4f>] [<c020f920>] [<c020e3c2>] [<c020f920>] [<c020d060>] [<c01fda4f>]
   [<c020d010>] [<c020cf4a>] [<c020d010>] [<c020bd09>] [<c01fda4f>] [<c020bb00>]
   [<c020b920>] [<c020bb00>] [<c01f3cb4>] [<c01f3e0d>] [<c01f3f55>] [<c011d0a6>]
   [<c0109296>] [<c0105330>] [<c010b938>] [<c0105330>] [<c0105359>] [<c01053f2>]
   [<c0105000>]
Code: 0f 0b 34 02 3e b6 26 c0 e9 17 fb ff ff 0f 0b 2d 02 3e b6 26


>>EIP; c0114f57 <schedule+527/550>   <=====

>>ebx; f76d2088 <_end+3738b1bc/384fb194>
>>ecx; c02b2000 <init_task_union+0/2000>
>>edx; f7651f7c <_end+3730b0b0/384fb194>
>>ebp; c02b3cdc <init_task_union+1cdc/2000>
>>esp; c02b3cac <init_task_union+1cac/2000>

Trace; f8843d42 <[fore_200e]fore200e_send+172/6d0>
Trace; c02599d6 <clip_start_xmit+186/220>
Trace; c01fe4a9 <qdisc_restart+69/190>
Trace; c01f36df <dev_queue_xmit+23f/320>
Trace; c020fa03 <ip_finish_output2+e3/120>
Trace; c01fda4f <nf_hook_slow+11f/230>
Trace; c020f920 <ip_finish_output2+0/120>
Trace; c020e3c2 <ip_finish_output+42/50>
Trace; c020f920 <ip_finish_output2+0/120>
Trace; c020d060 <ip_forward_finish+50/60>
Trace; c01fda4f <nf_hook_slow+11f/230>
Trace; c020d010 <ip_forward_finish+0/60>
Trace; c020cf4a <ip_forward+13a/200>
Trace; c020d010 <ip_forward_finish+0/60>
Trace; c020bd09 <ip_rcv_finish+209/269>
Trace; c01fda4f <nf_hook_slow+11f/230>
Trace; c020bb00 <ip_rcv_finish+0/269>
Trace; c020b920 <ip_rcv+1a0/200>
Trace; c020bb00 <ip_rcv_finish+0/269>
Trace; c01f3cb4 <netif_receive_skb+e4/1b0>
Trace; c01f3e0d <process_backlog+8d/130>
Trace; c01f3f55 <net_rx_action+a5/140>
Trace; c011d0a6 <do_softirq+d6/e0>
Trace; c0109296 <do_IRQ+e6/f0>
Trace; c0105330 <default_idle+0/50>
Trace; c010b938 <call_do_IRQ+5/d>
Trace; c0105330 <default_idle+0/50>
Trace; c0105359 <default_idle+29/50>
Trace; c01053f2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

Code;  c0114f57 <schedule+527/550>
00000000 <_EIP>:
Code;  c0114f57 <schedule+527/550>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0114f59 <schedule+529/550>
    2:   34 02                     xor    $0x2,%al
Code;  c0114f5b <schedule+52b/550>
    4:   3e                        ds
Code;  c0114f5c <schedule+52c/550>
    5:   b6 26                     mov    $0x26,%dh
Code;  c0114f5e <schedule+52e/550>
    7:   c0 e9 17                  shr    $0x17,%cl
Code;  c0114f61 <schedule+531/550>
    a:   fb                        sti 
Code;  c0114f62 <schedule+532/550>
    b:   ff                        (bad) 
Code;  c0114f63 <schedule+533/550>
    c:   ff 0f                     decl   (%edi)
Code;  c0114f65 <schedule+535/550>
    e:   0b 2d 02 3e b6 26         or     0x26b63e02,%ebp

  <0>Kernel panic: Aiee, killing interrupt handler!

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
