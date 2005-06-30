Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVF3Hni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVF3Hni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 03:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVF3Hng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 03:43:36 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:385 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262767AbVF3HnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 03:43:16 -0400
X-ORBL: [69.109.163.12]
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Date: Thu, 30 Jun 2005 00:42:19 -0700
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506300042.22255.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to upgrade memory on my laptop from 2 x 128m by replacing one of the chips 
with a 256m chip (these are PC2100 SODIMMS in case that matters). The new chip 
appears to be fine - I do not see any memory corruptions or whatnot and I ran 
memtest without any problems.

However there are two issues related to ACPI with this new chip (the problems
go away when I replace it with the old one):

1) when booting I get these error when "ec" module is being loaded:

Jun 23 23:25:28 bologoe kernel: [4294720.883000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.887000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.LPT_._STA] (Node c13563e4), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.895000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.LPT_._STA] (Node c13563e4), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.903000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.907000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.LPTB._STA] (Node c1356780), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.917000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.LPTB._STA] (Node c1356780), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.926000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.931000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.ECP_._STA] (Node c1356b48), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.942000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.ECP_._STA] (Node c1356b48), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.953000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.958000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.EPP_._STA] (Node c1356990), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.970000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.EPP_._STA] (Node c1356990), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.982000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294720.988000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.COMB._STA] (Node c1356d58), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.000000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.COMB._STA] (Node c1356d58), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.013000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.020000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.IRDA._STA] (Node c1356fc0), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.033000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.IRDA._STA] (Node c1356fc0), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.047000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.054000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.BASK._STA] (Node c1355308), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.068000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.BASK._STA] (Node c1355308), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.082000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.090000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.FIR_._STA] (Node c1355124), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.105000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.FIR_._STA] (Node c1355124), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.120000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.128000]     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.FDC_._STA] (Node c1355518), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.144000]     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.FDC_._STA] (Node c1355518), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.161000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.170000]     ACPI-1138: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node c13529e8), AE_NO_MEMORY
Jun 23 23:25:28 bologoe kernel: [4294721.178000]     ACPI-0158: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node c13529e8), AE_NO_MEMORY

2) and then, later when kded is trying to start I get this oops (my guess is kded is 
trying to access some proc entry)

Jun 23 23:27:37 bologoe kernel: [4294850.163000] Unable to handle kernel paging request at virtual address 1a5a5a5a
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  printing eip:
Jun 23 23:27:37 bologoe kernel: [4294850.163000] c01f6e93
Jun 23 23:27:37 bologoe kernel: [4294850.163000] *pde = 00000000
Jun 23 23:27:37 bologoe kernel: [4294850.163000] Oops: 0002 [#1]
Jun 23 23:27:37 bologoe kernel: [4294850.163000] PREEMPT
Jun 23 23:27:37 bologoe kernel: [4294850.163000] Modules linked in: ipv6 pcmcia parport_pc lp parport video container i2c_ali15x3 8139too yenta_socket rsrc_nonstatic pc
mcia_core snd_ali5451 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc usbhid hangcheck_timer nvram radeon drm ati_agp agpgart rt
c battery ac button fan thermal sg vfat fat sd_mod sr_mod scsi_mod eeprom i2c_sensor i2c_ali1535 i2c_core 8139cp mii ohci_hcd usbcore
Jun 23 23:27:37 bologoe kernel: [4294850.163000] CPU:    0
Jun 23 23:27:37 bologoe kernel: [4294850.163000] EIP:    0060:[acpi_os_write_memory+33/69]    Not tainted VLI
Jun 23 23:27:37 bologoe kernel: [4294850.163000] EFLAGS: 00210046   (2.6.12.1-s)
Jun 23 23:27:37 bologoe kernel: [4294850.163000] EIP is at acpi_os_write_memory+0x21/0x45
Jun 23 23:27:37 bologoe kernel: [4294850.163000] eax: 5a5a5a5a   ebx: 00000000   ecx: 00000083   edx: 00000008
Jun 23 23:27:37 bologoe kernel: [4294850.163000] esi: 00000008   edi: 00000083   ebp: 5a5a5a5a   esp: c519bc3c
Jun 23 23:27:37 bologoe kernel: [4294850.163000] ds: 007b   es: 007b   ss: 0068
Jun 23 23:27:37 bologoe kernel: [4294850.163000] Process kded (pid: 6257, threadinfo=c519a000 task=cfe7f550)
Jun 23 23:27:37 bologoe kernel: [4294850.163000] Stack: c0202d59 5a5a5a5a 5a5a5a5a 00000083 00000008 00000000 d6e0d730 d6e0d70c
Jun 23 23:27:37 bologoe kernel: [4294850.163000]        00200246 c020e54f 00000008 00000083 d6e0d730 83eee8b4 00000001 d6e0de78
Jun 23 23:27:37 bologoe kernel: [4294850.163000]        c020e92a 00000083 00000000 c020e9ca d6e0d70c 00000083 c519bcac c014f8b5
Jun 23 23:27:37 bologoe kernel: [4294850.163000] Call Trace:
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_hw_low_level_write+55/90] acpi_hw_low_level_write+0x37/0x5a
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ec_read+157/247] acpi_ec_read+0x9d/0xf7
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ec_space_handler+0/433] acpi_ec_space_handler+0x0/0x1b1
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ec_space_handler+160/433] acpi_ec_space_handler+0xa0/0x1b1
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [dbg_redzone1+21/48] dbg_redzone1+0x15/0x30
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ec_space_handler+0/433] acpi_ec_space_handler+0x0/0x1b1
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ev_address_space_dispatch+211/297] acpi_ev_address_space_dispatch+0xd3/0x129
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ex_access_region+71/148] acpi_ex_access_region+0x47/0x94
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ex_field_datum_io+297/449] acpi_ex_field_datum_io+0x129/0x1c1
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ex_extract_from_field+137/585] acpi_ex_extract_from_field+0x89/0x249
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ut_create_internal_object_dbg+27/108] acpi_ut_create_internal_object_dbg+0x1b/0x6c
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ex_read_data_from_field+293/342] acpi_ex_read_data_from_field+0x125/0x156
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ex_resolve_node_to_value+169/220] acpi_ex_resolve_node_to_value+0xa9/0xdc
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ex_resolve_to_value+59/70] acpi_ex_resolve_to_value+0x3b/0x46
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ds_get_predicate_value+95/258] acpi_ds_get_predicate_value+0x5f/0x102
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ds_exec_end_op+711/818] acpi_ds_exec_end_op+0x2c7/0x332
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ps_parse_loop+1347/2140] acpi_ps_parse_loop+0x543/0x85c
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ps_parse_aml+78/507] acpi_ps_parse_aml+0x4e/0x1fb
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_psx_execute+346/448] acpi_psx_execute+0x15a/0x1c0
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ns_execute_control_method+59/72] acpi_ns_execute_control_method+0x3b/0x48
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ns_evaluate_by_handle+118/141] acpi_ns_evaluate_by_handle+0x76/0x8d
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_ns_evaluate_relative+169/197] acpi_ns_evaluate_relative+0xa9/0xc5
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_evaluate_object+267/460] acpi_evaluate_object+0x10b/0x1cc
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [acpi_evaluate_integer+107/147] acpi_evaluate_integer+0x6b/0x93
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [pg0+395378794/1069409280] acpi_button_state_seq_show+0x24/0x5f [button]
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [seq_read+226/720] seq_read+0xe2/0x2d0
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [vfs_read+215/336] vfs_read+0xd7/0x150
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [sys_read+81/128] sys_read+0x51/0x80
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 23 23:27:37 bologoe kernel: [4294850.163000] Code: 01 06 93 30 c0 5b 5b 31 c0 c3 8b 54 24 10 8b 4c 24 0c 8b 44 24 04 83 fa 10 74 18 77 07 83 fa 08 74 09 eb 20 83 fa
 20 74 13 eb 19 <88> 88 00 00 00 c0 eb 19 66 89 88 00 00 00 c0 eb 10 89 88 00 00
Jun 23 23:27:37 bologoe kernel: [4294850.163000]  <6>note: kded[6257] exited with preempt_count 1


this is with kernel 2.6.12.1 ( same was with 2.6.12-rc4)
the laptop is Compaq Presario 900

any suggestions? what other information should I provide?

Fedor

-- 
[He] took me into his library and showed me his books, of which he had
a complete set.
		-- Ring Lardner
