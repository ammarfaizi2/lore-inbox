Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVCEMfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVCEMfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVCEMfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:35:17 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:8465 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262355AbVCEMfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:35:01 -0500
Date: Sat, 5 Mar 2005 13:34:58 +0100 (CET)
From: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
To: chas3@users.sourceforge.net
Cc: Mike Westall <westall@cs.clemson.edu>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd)
In-Reply-To: <200501302255.j0UMtmql020002@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.61L.0503051323440.25696@oceanic.wsisiz.edu.pl>
References: <200501302255.j0UMtmql020002@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005, chas williams - CONTRACTOR wrote:

Hello again

> good to hear.  what does atmdiag say about that interface?  does it have
> a large percentage of tx drops?

After one month work without oops, we have experienced oops again. It 
happen when one or more VC is down (for example on atm switch).
We have two atm interfaces (fore_200e,nicstar) on our router:

[root@cosmos root]# lspci  |grep ATM
01:01.0 ATM network controller: FORE Systems Inc ForeRunner PCA-200EPC ATM
01:05.0 ATM network controller: Integrated Device Tech IDT77211 ATM 
Adapter (rev 03)

I have changed schedule() to udelay(50) in fore_200e and nicstar.
I have replaced also atm nicstar card to second one.
In log file, we can see many infromation like this one:

nicstar0: AAL5 CRC error - PDU size mismatch.



ksymoops 2.4.11 on i686 2.4.29.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.29/ (default)
      -m /lib/modules/2.4.29/System.map (specified)

CPU:    0
EIP:    0010:[<c01b68f9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000002
eax: c031ea00   ebx: 00000005   ecx: 00000001   edx: 000003fd
esi: c031eac0   edi: c0305ee3   ebp: 00000005   esp: c02b3e18
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b3000)
Stack: 000f4016 c01bbe61 c031eac0 00000005 00000044 0000000d 00000016 c02a4c60
        c0305ede 00011c3e 00011c54 c0118452 c02a4c60 c0305ede 00000016 00011c54
        00011c54 00000016 f793d480 c011855f 00011c3e 00011c54 00000004 c029a1bc
Call Trace:    [<c01bbe61>] [<c0118452>] [<c011855f>] [<c0118893>] [<c01187bf>]
   [<f8a1f165>] [<f8a1cc15>] [<f8a1f14f>] [<f8a1c96c>] [<f8a1b7ad>] [<c0109029>]
   [<c0109248>] [<c0105330>] [<c010b938>] [<c0105330>] [<c0105359>] [<c01053f2>]
   [<c0105000>]
Code: 5b 0f b6 c0 c3 89 f6 0f b7 48 74 8b 40 70 d3 e3 0f b6 04 03


>>EIP; c01b68f9 <serial_in+19/30>   <=====

>>eax; c031ea00 <serial_termios_locked+60/100>
>>esi; c031eac0 <async_sercons+0/c0>
>>edi; c0305ee3 <log_buf+1c43/8000>
>>esp; c02b3e18 <init_task_union+1e18/2000>

Trace; c01bbe61 <serial_console_write+81/220>
Trace; c0118452 <__call_console_drivers+62/70>
Trace; c011855f <call_console_drivers+7f/120>
Trace; c0118893 <release_console_sem+53/b0>
Trace; c01187bf <printk+14f/180>
Trace; f8a1f165 <[nicstar]__module_license+4f/130a>
Trace; f8a1cc15 <[nicstar]dequeue_rx+265/1040>
Trace; f8a1f14f <[nicstar]__module_license+39/130a>
Trace; f8a1c96c <[nicstar]process_rsq+2c/70>
Trace; f8a1b7ad <[nicstar]ns_irq_handler+3ad/470>
Trace; c0109029 <handle_IRQ_event+79/b0>
Trace; c0109248 <do_IRQ+98/f0>
Trace; c0105330 <default_idle+0/50>
Trace; c010b938 <call_do_IRQ+5/d>
Trace; c0105330 <default_idle+0/50>
Trace; c0105359 <default_idle+29/50>
Trace; c01053f2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

Code;  c01b68f9 <serial_in+19/30>
00000000 <_EIP>:
Code;  c01b68f9 <serial_in+19/30>   <=====
    0:   5b                        pop    %ebx   <=====
Code;  c01b68fa <serial_in+1a/30>
    1:   0f b6 c0                  movzbl %al,%eax
Code;  c01b68fd <serial_in+1d/30>
    4:   c3                        ret 
Code;  c01b68fe <serial_in+1e/30>
    5:   89 f6                     mov    %esi,%esi
Code;  c01b6900 <serial_in+20/30>
    7:   0f b7 48 74               movzwl 0x74(%eax),%ecx
Code;  c01b6904 <serial_in+24/30>
    b:   8b 40 70                  mov    0x70(%eax),%eax
Code;  c01b6907 <serial_in+27/30>
    e:   d3 e3                     shl    %cl,%ebx
Code;  c01b6909 <serial_in+29/30>
   10:   0f b6 04 03               movzbl (%ebx,%eax,1),%eax

Where is the problem, patchord is bad, or problem exists on atm switch?

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
