Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTJ1NcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 08:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263975AbTJ1NcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 08:32:12 -0500
Received: from c251147.customer.hansenet.de ([213.39.251.147]:50075 "EHLO
	sarah.ricardo.de") by vger.kernel.org with ESMTP id S263973AbTJ1NcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 08:32:04 -0500
From: Joachim Bremer <joachim.bremer@ricardo.de>
Message-Id: <200310281332.h9SDW2708105@sarah.ricardo.de>
Subject: 2.4.23pre8 - ACPI Kernel Panic on boot
To: linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2003 14:32:02 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL101c (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on my laptop HP NX9005 2.4.23pre8 will panic on boot. Tracing
down the differences between 2.4.23pre7 and pre8 a found that
the problems is in patchset 1.1063.43.26. Backing out this patch
lets the laptop boot again. Decode oops follows.

Joachim

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at slab.c:1130!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012df25>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000001f0   ebx: c1797270   ecx: 000001f0   edx: c02db798
esi: c1797278   edi: c1797270   ebp: 000001f0   esp: c031da84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c031d000)
Stack: c031dac0 00000388 c01ca227 00200000 00000388 c1797270 c1797278 00000246
       000001f0 c012e2a3 c1797270 000001f0 00000009 c031dad8 00000001 00000001
       c01a5cde 00000060 000001f0 c01c8ebc 00000060 00000001 c02a78c1 c02a7884
Call trace:    [<c01ca227>] [<c012e2a3>] [<c01a5cde>] [<c01c8ebc>] [<c01c8fad>]
  [<c01c8c82>] [<c01ca153>] [<c01cc793>] [<c01c168f>] [<c01c0dec>] [<c01c0f3c>]
  [<c01c8c36>] [<c01ca1d4>] [<c01ac6bf>] [<c01c1408>] [<c01c141d>] [<c01a8073>]
  [<c01c1454>] [<c01c207a>] [<c01bcabc>] [<c01bc995>] [<c01bc71d>] [<c01ba804>]
  [<c01bf28d>] [<c01d1b49>] [<c01d1bc5>] [<c01ad11d>] [<c01acf2e>] [<c01af467>]
  [<c01a5e0f>] [<c01087c5>] [<c01a5e03>] [<c0108944>] [<c010ac98>] [<c01d591f>]
  [<c01d5843>] [<c0105372>] [<c0105000>]
Code: 0f 0b 6a 04 0e 4d 29 c0 89 c8 c7 44 24 0c 01 00 00 00 25 f0


>>EIP; c012df25 <kmem_cache_grow+45/1f0>   <=====

>>edx; c02db798 <cache_sizes+18/c0>
>>esp; c031da84 <init_task_union+1a84/2000>

Trace; c01ca227 <acpi_ut_status_exit+49/55>
Trace; c012e2a3 <kmalloc+e3/110>
Trace; c01a5cde <acpi_os_allocate+e/11>
Trace; c01c8ebc <acpi_ut_callocate+75/e5>
Trace; c01c8fad <acpi_ut_callocate_and_track+20/81>
Trace; c01c8c82 <acpi_ut_acquire_from_cache+cf/e3>
Trace; c01ca153 <acpi_ut_trace_ptr+2c/30>
Trace; c01cc793 <acpi_ut_create_generic_state+c/15>
Trace; c01c168f <acpi_ps_push_scope+3c/b0>
Trace; c01c0dec <acpi_ps_parse_loop+4ce/a40>
Trace; c01c0f3c <acpi_ps_parse_loop+61e/a40>
Trace; c01c8c36 <acpi_ut_acquire_from_cache+83/e3>
Trace; c01ca1d4 <acpi_ut_exit+1d/27>
Trace; c01ac6bf <acpi_ds_push_walk_state+4a/51>
Trace; c01c1408 <acpi_ps_parse_aml+aa/242>
Trace; c01c141d <acpi_ps_parse_aml+bf/242>
Trace; c01a8073 <acpi_ds_call_control_method+171/261>
Trace; c01c1454 <acpi_ps_parse_aml+f6/242>
Trace; c01c207a <acpi_psx_execute+226/2b0>
Trace; c01bcabc <acpi_ns_execute_control_method+e5/104>
Trace; c01bc995 <acpi_ns_evaluate_by_handle+df/121>
Trace; c01bc71d <acpi_ns_evaluate_relative+141/192>
Trace; c01ba804 <acpi_hw_low_level_read+10f/11c>
Trace; c01bf28d <acpi_evaluate_object+179/282>
Trace; c01d1b49 <acpi_ec_gpe_query+104/11b>
Trace; c01d1bc5 <acpi_ec_gpe_handler+65/93>
Trace; c01ad11d <acpi_ev_gpe_dispatch+7e/1bb>
Trace; c01acf2e <acpi_ev_gpe_detect+119/16a>
Trace; c01af467 <acpi_ev_sci_xrupt_handler+37/4d>
Trace; c01a5e0f <acpi_irq+c/e>
Trace; c01087c5 <handle_IRQ_event+45/70>
Trace; c01a5e03 <acpi_irq+0/e>
Trace; c0108944 <do_IRQ+64/a0>
Trace; c010ac98 <call_do_IRQ+5/d>
Trace; c01d591f <acpi_processor_idle+dc/1cf>
Trace; c01d5843 <acpi_processor_idle+0/1cf>
Trace; c0105372 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c012df25 <kmem_cache_grow+45/1f0>
00000000 <_EIP>:
Code;  c012df25 <kmem_cache_grow+45/1f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012df27 <kmem_cache_grow+47/1f0>
   2:   6a 04                     push   $0x4
Code;  c012df29 <kmem_cache_grow+49/1f0>
   4:   0e                        push   %cs
Code;  c012df2a <kmem_cache_grow+4a/1f0>
   5:   4d                        dec    %ebp
Code;  c012df2b <kmem_cache_grow+4b/1f0>
   6:   29 c0                     sub    %eax,%eax
Code;  c012df2d <kmem_cache_grow+4d/1f0>
   8:   89 c8                     mov    %ecx,%eax
Code;  c012df2f <kmem_cache_grow+4f/1f0>
   a:   c7 44 24 0c 01 00 00      movl   $0x1,0xc(%esp,1)
Code;  c012df36 <kmem_cache_grow+56/1f0>
  11:   00 
Code;  c012df37 <kmem_cache_grow+57/1f0>
  12:   25 f0 00 00 00            and    $0xf0,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

