Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVIMUZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVIMUZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVIMUZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:25:44 -0400
Received: from smtp804.mail.ukl.yahoo.com ([217.12.12.141]:24228 "HELO
	smtp804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932398AbVIMUZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:25:43 -0400
Subject: 2.6.14-rc1: oops during boot
From: Grant Wilson <gww@btinternet.com>
To: linux-kernel@vger.kernel.org
Cc: Antonino Daplas <adaplas@pol.net>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 21:25:43 +0100
Message-Id: <1126643143.5170.11.camel@tlg.swandive.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.14-rc1 oops on boot as a result of the patch "nvidiafb: Fallback to
firmware EDID".

This is because the call to fb_firmware_edid added by the patch may
return NULL but this is not checked before trying to memcpy using this
pointer resulting in the following oops:

[   65.245628] nvidiafb: nVidia device/chipset 10DE0282
[   65.293175] nvidiafb: CRTC0 not found
[   65.333160] nvidiafb: CRTC1 found
[   65.370805] Unable to handle kernel NULL pointer dereference at
0000000000000000 RIP:
[   65.406835] <ffffffff802b6e4b>{memcpy+11}
[   65.449140] PGD 0
[   65.462288] Oops: 0000 [1] SMP
[   65.482867] CPU 0
[   65.496016] Modules linked in:
[   65.516027] Pid: 1, comm: swapper Not tainted 2.6.14-rc1 #1
[   65.552614] RIP: 0010:[<ffffffff802b6e4b>] <ffffffff802b6e4b>{memcpy
+11}
[   65.595488] RSP: 0000:ffff81007ff2da50  EFLAGS: 00010246
[   65.631506] RAX: ffff81007fd45e40 RBX: ffff81007fd45e40 RCX:
0000000000000010
[   65.678383] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff81007fd45e40
[   65.725261] RBP: ffff8100032a29f8 R08: ffffc20000701000 R09:
ffff810002c3f0c0
[   65.772135] R10: 0000000000000000 R11: 0000000000000002 R12:
0000000000000003
[   65.819014] R13: 0000000000000000 R14: ffff8100032a25f8 R15:
ffff81007ff2da97
[   65.865891] FS:  0000000000000000(0000) GS:ffffffff80615800(0000)
knlGS:0000000000000000
[   65.919057] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   65.956788] CR2: 0000000000000000 CR3: 0000000000101000 CR4:
00000000000006e0
[   66.003666] Process swapper (pid: 1, threadinfo ffff81007ff2c000,
task ffff81000324e740)
[   66.056831] Stack: ffffffff802d9b26 ffff81007ff2dcd8 ffff8100032a2000
0000000100000050
[   66.108282]        ffff81007ff2da97 0000008000010050 ffff81007fd45e40
ffff8100032a2e08
[   66.160875]        00ffffff802d7a43 ffffc2000078252c
[   66.194032] Call Trace:<ffffffff802d9b26>{nvidia_probe_i2c_connector
+358} <ffffffff802d858f>{NVCommonSetup+2159}
[   66.260919]        <ffffffff8015fd87>{buffered_rmqueue+647}
<ffffffff801184a0>{do_flush_tlb_all+0}
[   66.319801]        <ffffffff801184a0>{do_flush_tlb_all+0}
<ffffffff8011b594>{flat_send_IPI_allbutself+20}
[   66.382686]        <ffffffff801187ce>{__smp_call_function+110}
<ffffffff801184a0>{do_flush_tlb_all+0}
[   66.443283]        <ffffffff801188bb>{smp_call_function+75}
<ffffffff801188fc>{flush_tlb_all+28}
[   66.501023]        <ffffffff80120921>{__ioremap+993}
<ffffffff80101c28>{init_level4_pgt+3112}
[   66.557046]        <ffffffff802d3628>{nvidiafb_probe+1000}
<ffffffff8013346d>{set_cpus_allowed+333}
[   66.616501]        <ffffffff802bfa53>{pci_device_probe+243}
<ffffffff80350d0d>{driver_probe_device+77}
[   66.677669]        <ffffffff80350e7a>{__driver_attach+90}
<ffffffff80350e20>{__driver_attach+0}
[   66.734837]        <ffffffff803500f9>{bus_for_each_dev+73}
<ffffffff80350630>{bus_add_driver+128}
[   66.793148]        <ffffffff802bf649>{pci_register_driver+137}
<ffffffff802d322d>{nvidiafb_init+493}
[   66.853174]        <ffffffff8010b232>{init+482}
<ffffffff8010eb16>{child_rip+8}
[   66.901195]        <ffffffff802c3160>{dummycon_dummy+0}
<ffffffff8010b050>{init+0}
[   66.950931]        <ffffffff8010eb0e>{child_rip+0}
[   66.984089]
[   66.984090] Code: f3 48 a5 89 d1 f3 a4 c3 66 66 66 90 66 66 66 90 66
66 66 90
[   67.041256] RIP <ffffffff802b6e4b>{memcpy+11} RSP <ffff81007ff2da50>
[   67.082989] CR2: 0000000000000000
[   67.104712]  <0>Kernel panic - not syncing: Attempted to kill init!


