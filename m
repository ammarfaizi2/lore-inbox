Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313261AbSD0Ls3>; Sat, 27 Apr 2002 07:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313293AbSD0Ls2>; Sat, 27 Apr 2002 07:48:28 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:35721 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S313261AbSD0Ls1>;
	Sat, 27 Apr 2002 07:48:27 -0400
Date: Sat, 27 Apr 2002 13:48:25 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [BUG]: ACPI oopsing at boottime 
Message-ID: <Pine.LNX.4.44.0204271341420.352-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware: Duron 600 on ASUS A7M266 512MB DDR RAM
Kernel: 2.5.10-dj for duron (the same issue was on: 2.5.10 for duron, 
2.5.10 for i386, 2.5.9 for i386) 
It's making oops and panic at boot time. Full ksymoops output:

ksymoops 2.4.4 on i686 2.2.20.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.10 (specified)
     -m /boot/System.map-2.5.10-0.2dj (specified)

No modules in ksyms, skipping objects
c017431f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c017431f>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: c15439bc     ecx: c1547400       edx: c1547588
esi: 00000027   edi: 00000000     ebp: c15439bc       esp: c1555db4
ds: 0018        es: 0018       ss:0018
Stack: c15439bc dffd08a4 00000000 c1547400 0000000b c017798c c1547400 c15439bc
       c1555de8 c15475b0 c1547400 00000000 c15475b0 00000000 c0177sv2 c15475b0
       c1547400 00000001 dffd08a4 c0177edd c15475b0 c1547400 c150e41c dffd0b24
Call Trace: [<c017798c>] [<c0177ac1>] [<c0177edd>] [<c016fab9>] [<c0170612>]
  [<c017ce41>] [<c01832f7>] [<c017d24f>] [<c017d26a>] [<c016f6b6>] [<c016f7ca>] 
  [<c017a4ed>] [<c017b66e>] [<c017a450>] [<c017bdad>] [<c017a450>] [<c017a3f7>]
  [<c017a450>] [<c0183aa3>] [<c0105088>] [<c0105000>] [<c01072ba>] [<c01072c3>]
Code: 8a 50 16 80 e2 04 bf 08 00 00 00 b8 04 00 00 00 c1 ee 03 84

>>EIP; c017431f <acpi_ex_read_data_from_field+4f/150>   <=====
Trace; c017798c <acpi_ex_resolve_node_to_value+bc/1b0>
Trace; c0177ac1 <acpi_ex_resolve_to_value+41/50>
Trace; c0177edd <acpi_ex_resolve_operands+1bd/340>
Trace; c016fab9 <acpi_ds_eval_region_operands+39/a0>
Trace; c0170612 <acpi_ds_exec_end_op+242/2d0>
Trace; c017ce41 <acpi_ps_parse_loop+5a1/970>
Trace; c01832f7 <acpi_ut_create_generic_state+7/20>
Trace; c017d24f <acpi_ps_parse_aml+3f/190>
Trace; c017d26a <acpi_ps_parse_aml+5a/190>
Trace; c016f6b6 <acpi_ds_execute_arguments+106/120>
Trace; c016f7ca <acpi_ds_get_region_arguments+3a/50>
Trace; c017a4ed <acpi_ns_init_one_object+9d/e0>
Trace; c017b66e <acpi_ns_walk_namespace+8e/110>
Trace; c017a450 <acpi_ns_init_one_object+0/e0>
Trace; c017bdad <acpi_walk_namespace+4d/70>
Trace; c017a450 <acpi_ns_init_one_object+0/e0>
Trace; c017a3f7 <acpi_ns_initialize_objects+27/40>
Trace; c017a450 <acpi_ns_init_one_object+0/e0>
Trace; c0183aa3 <acpi_enable_subsystem+63/80>
Trace; c0105088 <init+28/1a0>
Trace; c0105000 <_stext+0/0>
Trace; c01072ba <kernel_thread+1a/30>
Trace; c01072c3 <kernel_thread+23/30>
Code;  c017431f <acpi_ex_read_data_from_field+4f/150>
00000000 <_EIP>:
Code;  c017431f <acpi_ex_read_data_from_field+4f/150>   <=====
   0:   8a 50 16                  mov    0x16(%eax),%dl   <=====
Code;  c0174322 <acpi_ex_read_data_from_field+52/150>
   3:   80 e2 04                  and    $0x4,%dl
Code;  c0174325 <acpi_ex_read_data_from_field+55/150>
   6:   bf 08 00 00 00            mov    $0x8,%edi
Code;  c017432a <acpi_ex_read_data_from_field+5a/150>
   b:   b8 04 00 00 00            mov    $0x4,%eax
Code;  c017432f <acpi_ex_read_data_from_field+5f/150>
  10:   c1 ee 03                  shr    $0x3,%esi
Code;  c0174332 <acpi_ex_read_data_from_field+62/150>
  13:   84 00                     test   %al,(%eax)

 <0>Kernel panic: Attempted to kill init!

It's not oopsing on P166MMX neither on VMWare
Witek 'adasi' Krecicki
adasi@kernel.pl

