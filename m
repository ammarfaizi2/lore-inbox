Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSG0OUV>; Sat, 27 Jul 2002 10:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318766AbSG0OUV>; Sat, 27 Jul 2002 10:20:21 -0400
Received: from holomorphy.com ([66.224.33.161]:7331 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318765AbSG0OUU>;
	Sat, 27 Jul 2002 10:20:20 -0400
Date: Sat, 27 Jul 2002 07:23:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.29 serial oops
Message-ID: <20020727142329.GF2907@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be nondeterministic in nature:

Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address ffffff8a
c01a0f4a      
*pde = 00000000
Oops: 0000     
CPU:    3 
EIP:    0010:[<c01a0f4a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246                        
eax: c039a6f0   ebx: ffffff70   ecx: 00000003   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c039a6f0   esp: cc0e1f04
ds: 0018   es: 0018   ss: 0018                               
Stack: ffffff70 00000000 c01a1e46 ffffff70 00000002 f79873c0 00000001 00000004 
       cc0e1f80 00000000 c039a6f0 00000018 c0109155 00000004 c039a6f0 cc0e1f80 
       c0323880 c0323890 c0323890 cc0e1f78 c01093df 00000004 cc0e1f80 f79873c0 
Call Trace: [<c01a1e46>] [<c0109155>] [<c01093df>] [<c0105360>] [<c0107cf0>]   
   [<c0105360>] [<c0105389>] [<c0105413>] [<c011829b>] [<c0118119>]          
Code: 0f b6 4b 1a d3 e2 0f b6 43 1b 83 f8 01 74 07 83 f8 02 74 39 


>>EIP; c01a0f4a <serial_in+a/84>   <=====

>>eax; c039a6f0 <irq_lists+30/a80>
>>ebx; ffffff70 <END_OF_CODE+3fc3aaec/????>
>>ebp; c039a6f0 <irq_lists+30/a80>
>>esp; cc0e1f04 <END_OF_CODE+bd1ca80/????>

Trace; c01a1e46 <serial8250_interrupt+5a/15c>
Trace; c0109155 <handle_IRQ_event+29/4c>
Trace; c01093df <do_IRQ+df/190>
Trace; c0105360 <default_idle+0/34>
Trace; c0107cf0 <common_interrupt+18/20>
Trace; c0105360 <default_idle+0/34>
Trace; c0105389 <default_idle+29/34>
Trace; c0105413 <cpu_idle+37/48>
Trace; c011829b <release_console_sem+10b/118>
Trace; c0118119 <printk+185/1c4>

Code;  c01a0f4a <serial_in+a/84>
00000000 <_EIP>:
Code;  c01a0f4a <serial_in+a/84>   <=====
   0:   0f b6 4b 1a               movzbl 0x1a(%ebx),%ecx   <=====
Code;  c01a0f4e <serial_in+e/84>
   4:   d3 e2                     shl    %cl,%edx
Code;  c01a0f50 <serial_in+10/84>
   6:   0f b6 43 1b               movzbl 0x1b(%ebx),%eax
Code;  c01a0f54 <serial_in+14/84>
   a:   83 f8 01                  cmp    $0x1,%eax
Code;  c01a0f57 <serial_in+17/84>
   d:   74 07                     je     16 <_EIP+0x16> c01a0f60 <serial_in+20/84>
Code;  c01a0f59 <serial_in+19/84>
   f:   83 f8 02                  cmp    $0x2,%eax
Code;  c01a0f5c <serial_in+1c/84>
  12:   74 39                     je     4d <_EIP+0x4d> c01a0f97 <serial_in+57/84>

 <0>Kernel panic: Aiee, killing interrupt handler!                
