Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTJCINH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTJCINH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:13:07 -0400
Received: from TVT-CaTV-dhcp-47-244.urbanet.ch ([80.238.47.244]:897 "EHLO
	highscreen") by vger.kernel.org with ESMTP id S263591AbTJCIND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:13:03 -0400
Subject: 2.4.22 ACPI power off via sysrq not working
From: Sylvain Pasche <sylvain_pasche@yahoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1065168778.1740.10.camel@highscreen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 03 Oct 2003 10:12:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

If I want to halt the system using sys-rq - o key, I get an oops instead
of a power down.
Inside pm.c:159, there is:
	
	if (in_interrupt())
		BUG();

But if we look at the trace, we are in the interrupt of the keyboard
handler.
One fix would be to comment out the BUG line, but there's certainly "a
better way to do it".

Sylvain


kernel BUG at pm.c:159!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012880e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000001   ebx: f7a9cb20   ecx: 00000000   edx: 00000002
esi: 00000001   edi: 00000003   ebp: c02f6808   esp: c0337e68
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0337000)
Stack: 0000000b 00002a8d c011a795 f7a9cb3c f7a9cb20 00000005 c0128958
f7a9cb20 
       00000002 00000003 00000000 00000005 00000005 0000006f c01fa60e
00000002 
       00000003 c02fd208 0000006f c01fa725 00000005 c02fd208 0000006f
00000007 
Call Trace:    [<c011a795>] [<c0128958>] [<c01fa60e>] [<c01fa725>]
[<c01fa59b>]
  [<c021864b>] [<c02185a9>] [<c02164b6>] [<c02175b7>] [<c02175cf>]
[<c010a6a5>]
  [<c010a824>] [<c0107080>] [<c010cfa8>] [<c0107080>] [<c01070a3>]
[<c0107132>]
  [<c0105000>]
Code: 0f 0b 9f 00 6f 37 2b c0 83 fa 01 77 45 8b 73 14 39 fe 74 34 


>>EIP; c012880e <pm_send+2e/a0>   <=====

>>ebx; f7a9cb20 <_end+3770bfb4/385784f4>
>>ebp; c02f6808 <pm_devs_lock+0/10>
>>esp; c0337e68 <init_task_union+1e68/2000>

Trace; c011a795 <call_console_drivers+65/120>
Trace; c0128958 <pm_send_all+78/b0>
Trace; c01fa60e <acpi_system_save_state+16/91>
Trace; c01fa725 <acpi_suspend+5e/9d>
Trace; c01fa59b <acpi_power_off+7/9>
Trace; c021864b <__handle_sysrq_nolock+7b/f0>
Trace; c02185a9 <handle_sysrq+59/80>
Trace; c02164b6 <handle_scancode+276/310>
Trace; c02175b7 <handle_kbd_event+b7/c0>
Trace; c02175cf <keyboard_interrupt+f/20>
Trace; c010a6a5 <handle_IRQ_event+45/70>
Trace; c010a824 <do_IRQ+64/a0>
Trace; c0107080 <default_idle+0/40>
Trace; c010cfa8 <call_do_IRQ+5/d>
Trace; c0107080 <default_idle+0/40>
Trace; c01070a3 <default_idle+23/40>
Trace; c0107132 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

