Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVAERp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVAERp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVAERpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:45:55 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:19 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262521AbVAERnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:43:22 -0500
Message-Id: <200501051743.j05Hh8h0030660@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/04/2005 with nmh-1.1-RC3
To: len.brown@intel.com, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.10-mm1-V0.7.34-01 ACPI oops/hang
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1104946987_8912P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Jan 2005 12:43:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1104946987_8912P
Content-Type: text/plain; charset=us-ascii

Running 2.6.10-mm1-V0.7.34-01.  gkrellm hung trying to read a file in /proc/acpi
(apparently /proc/acpi/battery/BAT1/info based on the stack trace, as that was
one of two files lsof listed it having open.  I tried doing a
'cat /proc/acpi/thermal_zone/THM/temperature' (the *other* /proc file gkrellm
had open), and it hung as well.  I've hit this once or twice under -rc3-mm1-Ingo
kernels before, but didn't chase it down.  The oddness is that the bug trace
says it was looking at the thermal zone, but gkrellm's stack points at the
battery.  Not sure how that happened, unless gkrellm got control back after
the bug, and then wedged the next time it tried to read a /proc/acpi file
because the oops left a lock behind....

(Yes, the kernel is tainted by the NVidia driver.  All the same,  I'd find it
more plausible that it's borkedness in Dell's ACPI stuff. Feel free to hit 'delete'
if you're not interested in chasing this one...)

Found this in the logs:

Jan  5 11:50:25 turing-police kernel: invalid operand: 0000 [#1]
Jan  5 11:50:25 turing-police kernel: PREEMPT
Jan  5 11:50:25 turing-police kernel: Modules linked in: aes_i586 agpgart orinoco_cs pcmcia sunrpc ip_conntrack_ftp ipt_pkttype ipt_REJECT i
pt_state ip_conntrack ipt_LOG ipt_limit iptable_filter ip_tables ip6t_LOG ip6t_limit ip6table_filter ip6_tables microcode nvidia i8k thermal
 processor fan button battery ac ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core floppy
Jan  5 11:50:25 turing-police kernel: CPU:    0
Jan  5 11:50:25 turing-police kernel: EIP:    0060:[acpi_ex_resolve_node_to_value+6/748]    Tainted: P      VLI
Jan  5 11:50:25 turing-police kernel: EFLAGS: 00010246   (2.6.10-mm1-V0.7.34-01)
Jan  5 11:50:25 turing-police kernel: EIP is at acpi_ex_resolve_node_to_value+0x6/0x2ec
Jan  5 11:50:25 turing-police kernel: eax: cffde994   ebx: 00000009   ecx: 00000000   edx: 00000020
Jan  5 11:50:25 turing-police kernel: esi: c1cdcc28   edi: c9615c34   ebp: c9615c24   esp: c9615c18
Jan  5 11:50:25 turing-police kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Jan  5 11:50:25 turing-police kernel: Process gkrellm (pid: 10746, threadinfo=c9614000 task=cf6d52f0)
Jan  5 11:50:25 turing-police kernel: Stack: 00000009 c1cdcc28 c9615c34 c9615c50 c020f59f c1cdcc28 c1cdca6c 00000080
Jan  5 11:50:25 turing-police kernel:        c03b0238 c03b022f cfe1d8b0 00000009 00000004 00000000 c9615c8c c0212994
Jan  5 11:50:27 turing-police kernel:        c1cdcc28 c1cdca6c cffde994 00005b23 00000000 5b230994 00000080 c03adbf0
Jan  5 11:50:28 turing-police kernel: Call Trace:
Jan  5 11:50:28 turing-police kernel:  [show_stack+121/129] show_stack+0x79/0x81 (32)
Jan  5 11:50:28 turing-police kernel:  [show_registers+251/357] show_registers+0xfb/0x165 (40)
Jan  5 11:50:28 turing-police kernel:  [die+221/367] die+0xdd/0x16f (52)
Jan  5 11:50:28 turing-police kernel:  [do_invalid_op+149/156] do_invalid_op+0x95/0x9c (204)
Jan  5 11:50:28 turing-police kernel:  [error_code+43/48] error_code+0x2b/0x30 (72)
Jan  5 11:50:28 turing-police kernel:  [acpi_ex_resolve_to_value+143/210] acpi_ex_resolve_to_value+0x8f/0xd2 (44)
Jan  5 11:50:28 turing-police kernel:  [acpi_ex_resolve_operands+974/1694] acpi_ex_resolve_operands+0x3ce/0x69e (60)
Jan  5 11:50:28 turing-police kernel:  [acpi_ds_exec_end_op+250/1187] acpi_ds_exec_end_op+0xfa/0x4a3 (56)
Jan  5 11:50:28 turing-police kernel:  [acpi_ps_parse_loop+1659/2526] acpi_ps_parse_loop+0x67b/0x9de (56)
Jan  5 11:50:28 turing-police kernel:  [acpi_ps_parse_aml+196/645] acpi_ps_parse_aml+0xc4/0x285 (48)
Jan  5 11:50:28 turing-police kernel:  [acpi_psx_execute+486/652] acpi_psx_execute+0x1e6/0x28c (44)
Jan  5 11:50:28 turing-police kernel:  [acpi_ns_execute_control_method+213/242] acpi_ns_execute_control_method+0xd5/0xf2 (40)
Jan  5 11:50:28 turing-police kernel:  [acpi_ns_evaluate_by_handle+216/266] acpi_ns_evaluate_by_handle+0xd8/0x10a (40)
Jan  5 11:50:28 turing-police kernel:  [acpi_ns_evaluate_relative+330/418] acpi_ns_evaluate_relative+0x14a/0x1a2 (76)
Jan  5 11:50:28 turing-police kernel:  [acpi_evaluate_object+361/606] acpi_evaluate_object+0x169/0x25e (68)
Jan  5 11:50:28 turing-police kernel:  [acpi_evaluate_integer+125/393] acpi_evaluate_integer+0x7d/0x189 (172)
Jan  5 11:50:29 turing-police kernel:  [<d0de9068>] acpi_thermal_get_temperature+0x68/0xb2 [thermal] (48)
Jan  5 11:50:29 turing-police kernel:  [<d0dea004>] acpi_thermal_temp_seq_show+0x43/0x95 [thermal] (36)
Jan  5 11:50:29 turing-police kernel:  [seq_read+224/565] seq_read+0xe0/0x235 (52)
Jan  5 11:50:29 turing-police kernel:  [vfs_read+178/271] vfs_read+0xb2/0x10f (36)
Jan  5 11:50:29 turing-police kernel:  [sys_read+63/102] sys_read+0x3f/0x66 (44)
Jan  5 11:50:29 turing-police kernel:  [syscall_call+7/11] syscall_call+0x7/0xb (-8124)
Jan  5 11:50:29 turing-police kernel: ---------------------------
Jan  5 11:50:29 turing-police kernel: | preempt count: 00000002 ]
Jan  5 11:50:29 turing-police kernel: | 2-level deep critical section nesting:
Jan  5 11:50:29 turing-police kernel: ----------------------------------------
Jan  5 11:50:29 turing-police kernel: .. [die+62/367] .... die+0x3e/0x16f
Jan  5 11:50:29 turing-police kernel: .....[do_invalid_op+149/156] ..   ( <= do_invalid_op+0x95/0x9c)
Jan  5 11:50:29 turing-police kernel: .. [print_traces+19/69] .... print_traces+0x13/0x45
Jan  5 11:50:29 turing-police kernel: .....[show_stack+121/129] ..   ( <= show_stack+0x79/0x81)
Jan  5 11:50:29 turing-police kernel:
Jan  5 11:50:30 turing-police kernel: Code: 09 8b 55 fb be 90 14 02 00 00 57 db ff e4 50 68 f9 00 00 fb be 33 ec 00 00 8d 65 db ff f8 5b 5e 
5f 5d c3 fb be 55 89 e5 57 56 53 <df> ff 18 e8 22 79 ef ff fb be 30 43 c0 89 45 ec db ff e4 c7 45


I did a 'echo t > /proc/sysrq-trigger', and got these two traces:

Jan  5 12:13:59 turing-police kernel: gkrellm       [c53da030]T 00001CBC  5996 25659   6740               13442 (NOTLB)
Jan  5 12:13:59 turing-police kernel: cea9bcec 00200046 c0385793 00001cbc 00000000 3aa61400 000f4af7 c53da030
Jan  5 12:13:59 turing-police kernel:        c53da194 cea9a000 cffe0990 00000001 cea9bcf8 c0385868 00200246 cea9bd30
Jan  5 12:13:59 turing-police kernel:        c0384ee6 c53da030 00000001 c53da030 c0112f47 c57dfc8c cb86bc8c c010db8c
Jan  5 12:13:59 turing-police kernel: Call Trace:
Jan  5 12:13:59 turing-police kernel:  [schedule+222/247] schedule+0xde/0xf7 (12)
Jan  5 12:13:59 turing-police kernel:  [__sched_text_start+162/365] __down+0xa2/0x16d (56)
Jan  5 12:13:59 turing-police kernel:  [__down_failed+10/16] __down_failed+0xa/0x10 (16)
Jan  5 12:13:59 turing-police kernel:  [.text.lock.osl+19/61] .text.lock.osl+0x13/0x3d (40)
Jan  5 12:13:59 turing-police kernel:  [acpi_ut_acquire_mutex+201/356] acpi_ut_acquire_mutex+0xc9/0x164 (76)
Jan  5 12:13:59 turing-police kernel:  [acpi_ex_enter_interpreter+53/111] acpi_ex_enter_interpreter+0x35/0x6f (44)
Jan  5 12:13:59 turing-police kernel:  [acpi_ns_execute_control_method+192/242] acpi_ns_execute_control_method+0xc0/0xf2 (36)
Jan  5 12:13:59 turing-police kernel:  [acpi_ns_evaluate_by_handle+216/266] acpi_ns_evaluate_by_handle+0xd8/0x10a (40)
Jan  5 12:13:59 turing-police kernel:  [acpi_ns_evaluate_relative+330/418] acpi_ns_evaluate_relative+0x14a/0x1a2 (76)
Jan  5 12:13:59 turing-police kernel:  [acpi_evaluate_object+361/606] acpi_evaluate_object+0x169/0x25e (68)
Jan  5 12:13:59 turing-police kernel:  [<d0dee0a3>] acpi_battery_get_info+0xa3/0x1b7 [battery] (76)
Jan  5 12:14:00 turing-police kernel:  [<d0dee66f>] acpi_battery_read_info+0x6d/0x21a [battery] (48)
Jan  5 12:14:00 turing-police kernel:  [seq_read+224/565] seq_read+0xe0/0x235 (52)
Jan  5 12:14:00 turing-police kernel:  [vfs_read+178/271] vfs_read+0xb2/0x10f (36)
Jan  5 12:14:00 turing-police kernel:  [sys_read+63/102] sys_read+0x3f/0x66 (44)
Jan  5 12:14:00 turing-police kernel:  [syscall_call+7/11] syscall_call+0x7/0xb (-8124)
Jan  5 12:14:00 turing-police kernel: ---------------------------
Jan  5 12:14:00 turing-police kernel: | preempt count: 00000002 ]
Jan  5 12:14:00 turing-police kernel: | 2-level deep critical section nesting:
Jan  5 12:14:00 turing-police kernel: ----------------------------------------
Jan  5 12:14:00 turing-police kernel: .. [__schedule+167/1509] .... __schedule+0xa7/0x5e5
Jan  5 12:14:00 turing-police kernel: .....[schedule+222/247] ..   ( <= schedule+0xde/0xf7)
Jan  5 12:14:00 turing-police kernel: .. [__schedule+340/1509] .... __schedule+0x154/0x5e5
Jan  5 12:14:00 turing-police kernel: .....[schedule+222/247] ..   ( <= schedule+0xde/0xf7)


Jan  5 12:14:04 turing-police kernel: cat           [c0025370]T 00001C38  6976  9739   8666                 389 (NOTLB)
Jan  5 12:14:04 turing-police kernel: c57dfc68 00200046 c0385793 00001c38 00000000 c9d99380 000f4c1a c0025370
Jan  5 12:14:04 turing-police kernel:        c00254d4 c57de000 cffe0990 00000001 c57dfc74 c0385868 00200246 c57dfcac
Jan  5 12:14:04 turing-police kernel:        c0384ee6 c0025370 00000001 c0025370 c0112f47 cffe0998 cea9bd10 c010db8c
Jan  5 12:14:04 turing-police kernel: Call Trace:
Jan  5 12:14:04 turing-police kernel:  [schedule+222/247] schedule+0xde/0xf7 (12)
Jan  5 12:14:04 turing-police kernel:  [__sched_text_start+162/365] __down+0xa2/0x16d (56)
Jan  5 12:14:04 turing-police kernel:  [__down_failed+10/16] __down_failed+0xa/0x10 (16)
Jan  5 12:14:04 turing-police kernel:  [.text.lock.osl+19/61] .text.lock.osl+0x13/0x3d (40)
Jan  5 12:14:04 turing-police kernel:  [acpi_ut_acquire_mutex+201/356] acpi_ut_acquire_mutex+0xc9/0x164 (76)
Jan  5 12:14:04 turing-police kernel:  [acpi_ex_enter_interpreter+53/111] acpi_ex_enter_interpreter+0x35/0x6f (44)
Jan  5 12:14:04 turing-police kernel:  [acpi_ns_execute_control_method+192/242] acpi_ns_execute_control_method+0xc0/0xf2 (36)
Jan  5 12:14:04 turing-police kernel:  [acpi_ns_evaluate_by_handle+216/266] acpi_ns_evaluate_by_handle+0xd8/0x10a (40)
Jan  5 12:14:04 turing-police kernel:  [acpi_ns_evaluate_relative+330/418] acpi_ns_evaluate_relative+0x14a/0x1a2 (76)
Jan  5 12:14:04 turing-police kernel:  [acpi_evaluate_object+361/606] acpi_evaluate_object+0x169/0x25e (68)
Jan  5 12:14:04 turing-police kernel:  [acpi_evaluate_integer+125/393] acpi_evaluate_integer+0x7d/0x189 (172)
Jan  5 12:14:04 turing-police kernel:  [<d0de9068>] acpi_thermal_get_temperature+0x68/0xb2 [thermal] (48)
Jan  5 12:14:04 turing-police kernel:  [<d0dea004>] acpi_thermal_temp_seq_show+0x43/0x95 [thermal] (36)
Jan  5 12:14:04 turing-police kernel:  [seq_read+224/565] seq_read+0xe0/0x235 (52)
Jan  5 12:14:04 turing-police kernel:  [vfs_read+178/271] vfs_read+0xb2/0x10f (36)
Jan  5 12:14:04 turing-police kernel:  [sys_read+63/102] sys_read+0x3f/0x66 (44)
Jan  5 12:14:04 turing-police kernel:  [syscall_call+7/11] syscall_call+0x7/0xb (-8124)
Jan  5 12:14:04 turing-police kernel: ---------------------------
Jan  5 12:14:04 turing-police kernel: | preempt count: 00000002 ]
Jan  5 12:14:04 turing-police kernel: | 2-level deep critical section nesting:
Jan  5 12:14:04 turing-police kernel: ----------------------------------------
Jan  5 12:14:04 turing-police kernel: .. [__schedule+167/1509] .... __schedule+0xa7/0x5e5
Jan  5 12:14:04 turing-police kernel: .....[schedule+222/247] ..   ( <= schedule+0xde/0xf7)
Jan  5 12:14:04 turing-police kernel: .. [__schedule+340/1509] .... __schedule+0x154/0x5e5
Jan  5 12:14:04 turing-police kernel: .....[schedule+222/247] ..   ( <= schedule+0xde/0xf7)


--==_Exmh_1104946987_8912P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB3CcrcC3lWbTT17ARAk6MAJ0UyFJrmDp2x9Ec/ZMj4HGfZVdaxQCgr/Io
6y8OMM+1jxn1NbZKO+phdJA=
=OSGD
-----END PGP SIGNATURE-----

--==_Exmh_1104946987_8912P--
