Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbUBZMwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 07:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbUBZMwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 07:52:14 -0500
Received: from village.ehouse.ru ([193.111.92.18]:10757 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262780AbUBZMwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 07:52:06 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
Subject: 2.6.3 Oops when power-off via sys-rq
Date: Thu, 26 Feb 2004 15:52:03 +0300
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402261552.03783.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I get an oops any time when try to poweroff my 2xAthlon MP 2400 box [2.6.3]
via SysRq: poweroff. Instead of poweroff i see an oops and box
appears to be locked. This is not a significant problem for me,
but also not looks like a normal behaviour.

Here is a trace:

SysRq : Power Off

acpi_power_off called
bad: scheduling while atomic!
Call Trace:
 [<c011b79e>] schedule+0x68e/0x6a0
 [<c01fd4c1>] acpi_ut_release_mutex+0x67/0x6c
 [<c01fc605>] acpi_ut_acquire_from_cache+0x44/0x9e
 [<c0128520>] __mod_timer+0x180/0x220
 [<c01291fb>] schedule_timeout+0x6b/0xc0
 [<c0129180>] process_timeout+0x0/0x10
 [<c01f1cf2>] acpi_ex_system_do_suspend+0x1f/0x28
 [<c01f0d1c>] acpi_ex_opcode_1A_0T_0R+0x48/0x8d
 [<c01ead21>] acpi_ds_exec_end_op+0xad/0x268
 [<c01f7fd6>] acpi_ps_parse_loop+0x516/0x821
 [<c01fd5f3>] acpi_ut_delete_generic_state+0xb/0xe
 [<c01fe34b>] acpi_ut_update_object_reference+0x1ec/0x22a
 [<c01fe3a1>] acpi_ut_add_reference+0x18/0x1c
 [<c01ea10c>] acpi_ds_method_data_set_value+0x29/0x36
 [<c01fd444>] acpi_ut_acquire_mutex+0x5c/0x72
 [<c01fd4c1>] acpi_ut_release_mutex+0x67/0x6c
 [<c01fc605>] acpi_ut_acquire_from_cache+0x44/0x9e
 [<c01f832f>] acpi_ps_parse_aml+0x4e/0x17b
 [<c01f8bc6>] acpi_psx_execute+0x142/0x19c
 [<c01f5f69>] acpi_ns_execute_control_method+0x43/0x52
 [<c01f5f02>] acpi_ns_evaluate_by_handle+0x6f/0x93
 [<c01f5e79>] acpi_ns_evaluate_by_name+0x6d/0x87
 [<c01f56c8>] acpi_evaluate_object+0xcf/0x1be
 [<c01f47ba>] acpi_enter_sleep_state_prep+0x5a/0xce
 [<c01fecf6>] acpi_power_off+0x16/0x22
 [<c013a28d>] handle_poweroff+0xd/0x10
 [<c0219853>] __handle_sysrq_nolock+0x73/0xe0
 [<c02197ca>] handle_sysrq+0x4a/0x60
 [<c0213663>] kbd_event+0x33/0x60
 [<c02607ef>] input_event+0xef/0x400
 [<c02627fe>] atkbd_report_key+0x3e/0xa0
 [<c0262a0d>] atkbd_interrupt+0x1ad/0x3e0
 [<c02669ff>] serio_interrupt+0x5f/0x70
 [<c02672af>] i8042_interrupt+0xaf/0x170
 [<c010b49a>] handle_IRQ_event+0x3a/0x70
 [<c010b875>] do_IRQ+0xb5/0x190
 [<c0105000>] _stext+0x0/0x70
 [<c0109b08>] common_interrupt+0x18/0x20
 [<c0106c30>] default_idle+0x0/0x40
 [<c0105000>] _stext+0x0/0x70
 [<c0106c5c>] default_idle+0x2c/0x40
 [<c0106ce3>] cpu_idle+0x33/0x40
 [<c034c8c2>] start_kernel+0x172/0x190
 [<c034c470>] unknown_bootoption+0x0/0x100

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c011b244
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c011b244>]    Not tainted
EFLAGS: 00010097
EIP is at schedule+0x134/0x6a0
eax: 00000001   ebx: 00000000   ecx: c0305420   edx: c0305420
esi: c0305420   edi: c2419c00   ebp: c034bc44   esp: c034bbf0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c034a000 task=c0305420)
Stack: c02d75e0 c01fd4c1 f7ffef40 00000001 c24f8500 0000003c c01fc605 00000009
       00000000 0000000b 00000001 c034a000 c2419c00 0f761f8c 393a0609 0000000d
       c0305420 c03055e8 fffc53f0 c034bc58 00000000 c2462a40 c01291fb c034bc58
Call Trace:
 [<c01fd4c1>] acpi_ut_release_mutex+0x67/0x6c
 [<c01fc605>] acpi_ut_acquire_from_cache+0x44/0x9e
 [<c01291fb>] schedule_timeout+0x6b/0xc0
 [<c0129180>] process_timeout+0x0/0x10
 [<c01f1cf2>] acpi_ex_system_do_suspend+0x1f/0x28
 [<c01f0d1c>] acpi_ex_opcode_1A_0T_0R+0x48/0x8d
 [<c01ead21>] acpi_ds_exec_end_op+0xad/0x268
 [<c01f7fd6>] acpi_ps_parse_loop+0x516/0x821
 [<c01fd5f3>] acpi_ut_delete_generic_state+0xb/0xe
 [<c01fe34b>] acpi_ut_update_object_reference+0x1ec/0x22a
 [<c01fe3a1>] acpi_ut_add_reference+0x18/0x1c
 [<c01ea10c>] acpi_ds_method_data_set_value+0x29/0x36
 [<c01fd444>] acpi_ut_acquire_mutex+0x5c/0x72
 [<c01fd4c1>] acpi_ut_release_mutex+0x67/0x6c
 [<c01fc605>] acpi_ut_acquire_from_cache+0x44/0x9e
 [<c01f832f>] acpi_ps_parse_aml+0x4e/0x17b
 [<c01f8bc6>] acpi_psx_execute+0x142/0x19c
 [<c01f5f69>] acpi_ns_execute_control_method+0x43/0x52
 [<c01f5f02>] acpi_ns_evaluate_by_handle+0x6f/0x93
 [<c01f5e79>] acpi_ns_evaluate_by_name+0x6d/0x87
 [<c01f56c8>] acpi_evaluate_object+0xcf/0x1be
 [<c01f47ba>] acpi_enter_sleep_state_prep+0x5a/0xce
 [<c01fecf6>] acpi_power_off+0x16/0x22
 [<c013a28d>] handle_poweroff+0xd/0x10
 [<c0219853>] __handle_sysrq_nolock+0x73/0xe0
 [<c02197ca>] handle_sysrq+0x4a/0x60
 [<c0213663>] kbd_event+0x33/0x60
 [<c02607ef>] input_event+0xef/0x400
 [<c02627fe>] atkbd_report_key+0x3e/0xa0
 [<c0262a0d>] atkbd_interrupt+0x1ad/0x3e0
 [<c02669ff>] serio_interrupt+0x5f/0x70
 [<c02672af>] i8042_interrupt+0xaf/0x170
 [<c010b49a>] handle_IRQ_event+0x3a/0x70
 [<c010b875>] do_IRQ+0xb5/0x190
 [<c0105000>] _stext+0x0/0x70
 [<c0109b08>] common_interrupt+0x18/0x20
 [<c0106c30>] default_idle+0x0/0x40
 [<c0105000>] _stext+0x0/0x70
 [<c0106c5c>] default_idle+0x2c/0x40
 [<c0106ce3>] cpu_idle+0x33/0x40
 [<c034c8c2>] start_kernel+0x172/0x190
 [<c034c470>] unknown_bootoption+0x0/0x100

Code: ff 0b 8b 4d ec 8b 75 ec 83 c1 20 8b 46 20 8b 51 04 89 50 04

and some [possilby useful] info:

http://www.sysadminday.org.ru/2.6.3-sysrq_O-oops/config.txt
http://www.sysadminday.org.ru/2.6.3-sysrq_O-oops/lspci.txt
http://www.sysadminday.org.ru/2.6.3-sysrq_O-oops/lspci-vvn.txt
http://www.sysadminday.org.ru/2.6.3-sysrq_O-oops/cpuinfo.txt


-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
