Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270395AbTGSRo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270407AbTGSRo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:44:28 -0400
Received: from [193.254.185.26] ([193.254.185.26]:24076 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S270395AbTGSRoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:44:25 -0400
Subject: [ACPI] Kernel oops on boot on Thinkpad R40 since 2.4.22pre2
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058637581.2185.41.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Jul 2003 19:59:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 2.4.22pre2 my Thinkpad R40, Pentium M 1,3Ghz, Debian unstable oops
reproducible during the boot process with ACPI enabled. Short after the
oops it stops.

The last kernel I tested with is 2.4.22pre7.

There was no problem booting with 2.6.0-test1 and ACPI enabled.

****************************************************
ksymoops 2.4.8 on i686 2.4.22-pre7. (without options)

 c01a9231
 *pde = 00000000
 CPU:   0
 EFLAGS: 00010046
 eax: 00000000  ebx: cfe5ff2C  ecx: c0310378  edx: c0310378
 esi: 00000008  edi: cfe5ff2c  ebp: 00000008  esp: cfe5fed4
 ds: 0018  es: 0018  ss: 0018
 Process keventd (pid: 2, stackpage=cfe5f000)
 Stack: c0310378 00000282 c12c8298 c01bd627 c0310378 c0310378 cfe5ff2c
00000008
        ffffffff fffffdff 00000002 c02d3441 c02d32ec c01ccfff 00000282
cfe5ff2c
        c12c8280 cfe5ff30 c01d2ade 00000008 cfe5ff2c c12c8298 00000000
00100000
 Call Trace:   [<c01bd627>]  [<c01ccfff>]  [<c01d2ade>]  [<c01a954c>] 
[<c011e3aa>]
  [<c012687a>] [<c01266c0>]  [<c0105000>]  [<c01074ce>]  [<c01266c0>]
 Code: 0f b6 82 00 00 00 c0 88 03 eb 1e 0f b7 82 00 00 00 c0 66 89
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; cfe5ff2c <_end+fac4900/104f2a34>
>>ecx; c0310378 <pm_devs+0/8>
>>edx; c0310378 <pm_devs+0/8>
>>edi; cfe5ff2c <_end+fac4900/104f2a34>
>>esp; cfe5fed4 <_end+fac48a8/104f2a34>

Trace; c01bd627 <acpi_hw_low_level_read+73/11c>
Trace; c01ccfff <acpi_ut_trace+28/2c>
Trace; c01d2ade <acpi_ec_gpe_query+a3/11b>
Trace; c01a954c <acpi_os_execute_deferred+5b/75>
Trace; c011e3aa <__run_task_queue+5a/70>
Trace; c012687a <context_thread+1ba/1c0>
Trace; c01266c0 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01074ce <arch_kernel_thread+2e/40>
Trace; c01266c0 <context_thread+0/1c0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f b6 82 00 00 00 c0      movzbl 0xc0000000(%edx),%eax
Code;  00000007 Before first symbol
   7:   88 03                     mov    %al,(%ebx)
Code;  00000009 Before first symbol
   9:   eb 1e                     jmp    29 <_EIP+0x29>
Code;  0000000b Before first symbol
   b:   0f b7 82 00 00 00 c0      movzwl 0xc0000000(%edx),%eax
Code;  00000012 Before first symbol
  12:   66 89 00                  mov    %ax,(%eax)

****************************************************

My ACPI config

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y    
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_RELAXED_AML=y

I put the full kernel config file, system map, kernel and the
fake''dmesg'' (used console on parallel port + scanner) on
http://www.gnuenterprise.org/~jan/thinkpad-oops/


Thanks a lot,

Jan


-- 
Jan Ischebeck <mail@jan-ischebeck.de>
