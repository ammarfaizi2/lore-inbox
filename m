Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVAEEgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVAEEgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 23:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVAEEgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 23:36:53 -0500
Received: from cpc2-colc3-4-0-cust236.colc.cable.ntl.com ([81.107.32.236]:34211
	"EHLO sofa.co.uk") by vger.kernel.org with ESMTP id S262242AbVAEEgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 23:36:49 -0500
Subject: Re: PROBLEM: 2.6.10 oops on startup
From: Paul Bain <prbain@essex.ac.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41DAE494.1020807@osdl.org>
References: <1104605177.6137.92.camel@sofa.co.uk>
	 <41DAE494.1020807@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104899778.1992.45.camel@sofa.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 Jan 2005 04:36:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 18:46, Randy.Dunlap wrote:
> Have you tested any 2.6.10-bk# versions to see if this has been
> fixed by recent patches?
> If not, please try that and let us know, then I'll look at it
> more if needed.
> 
> Thanks,
> ~Randy

Hi, thanks for the response. I tried it with 2.6.10-bk7 and it crashed
with

 dswload-0294: *** Error: Looking up [ACST] in namespace,
AE_ALREADY_EXISTS
 psparse-0601 [26] ps_parse_loop	: During name lookup/catalog,
AE_ALREADY_EXISTS
Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c0222101
*pde = 00000000
Oops: 0002 [#1]
Modules linked in:
CPU:	0
EIP:	0060:[<c0222101>]	Not tainted VLI
EFLAGS:	00010202	(2.6.10-bk7)
EIP is at acpi_ut_remove_allocation+0xb5/0x124
eax: 6b6b6b6b	ebx: 00000000	ecx: 00000000	edx: 6b6b6b6b
esi: c15dd05c	edi: 00000000	ebp: c14faae4	esp: c14faac8
ds: 007b	es: 007b	ss: 0068
Process swapper (pid: 1, threadinfo=c14fa000 task=c14f99e0)
Stack: 	00000001 c0324aec c032492d 00200000 c15dd05c c14fab00 c15dd084
c14fab1c
	c0221e7f 00000000 c15dd05c 00000080 c031f0df 000001aa 00000001 c0324a25
	c032492d 00000000 c15dd084 00000007 c031b887 c14fab90 c020c342 c15dd084
Call Trace:
 [<c0103b7f>] show_stack+0x7f/0xa0
 [<c0103d16>] show_registers+0x156/0x1d0
 [<c0103f18>] die+0xc8/0x150
 [<c0114f72>] do_page_fault+0x472/0x6aa
 [<c010381b>] error_code+0x2b/0x30
 [<c0221e7f>] acpi_ut_free_and_track+0x7f/0xd3
 [<c020c342>] acpi_ex_load_op+0x2e1/0x2fd
 [<c020efca>] acpi_ex_opcode_1A_1T_0R+0x5c/0xa7
 [<c0204590>] acpi_ds_exec_end_op+0x141/0x49d
 [<c021b13d>] acpi_ps_parse_loop+0x676/0x9d9
 [<c021b55f>] acpi_ps_parse_aml+0xbf/0x280
 [<c021c145>] acpi_psx_execute+0x1e1/0x288
 [<c02179fd>] acpi_ns_execute_control_method+0xd0/0xed
 [<c02178fb>] acpi_ns_evaluate_by_handle+0xd3/0x105
 [<c02176a5>] acpi_ns_evaluate_relative+0x145/0x19d
 [<c0216b64>] acpi_evaluate_object+0x164/0x259
 [<c0233267>] acpi_processor_set_pdc+0x97/0xdd
 [<c0233719>] acpi_processor_get_performance_info+0x6d/0x118
 [<c0233ade>] acpi_processor_register_performance+0xc9/0x11e
 [<c010d6cc>] centrino_cpu_init_acpi+0x6c/0x380
 [<c010da56>] centrino_cpu_init+0x76/0x160
 [<c02a2a8b>] cpufreq_add_dev+0xeb/0x2f0
 [<c026d6e9>] sysdev_driver_register+0xa9/0xc0
 [<c02a3744>] cpufreq_register_driver+0x64/0xf0
 [<c03d5c83>] centrino_init+0x23/0x30
 [<c03cd906>] do_initcalls+0x56/0xd0
 [<c010045d>] init+0x2d/0x120
 [<c01012b5>] kernel_thread_helper+0x5/0x10
Code: 00 31 c0 e9 8a 00 00 00 6a 0a e8 5a 17 00 00 89 c7 85 ff 58 74 0c
57 8d 45 e4 50 68 0f 03 00 00 eb 69 8b 46 04 85 d2 74 05 <89> 42 04 eb
06 89 83 80 55 41 c0 8b 56 04 85 d2 74 04 8b 06 89
 <0>Kernel panic - not syncing: Attempted to kill init!

Kernel was compiled with the same debug options as before.

-- 
Paul Bain <prbain@essex.ac.uk>
