Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUALUfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUALUfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:35:32 -0500
Received: from main.gmane.org ([80.91.224.249]:17365 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265572AbUALUf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:35:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: 2.6.1mm2-k7: "Debug: sleeping function called from invalid context at mm/slab.c:1868"
Date: Mon, 12 Jan 2004 21:35:32 +0100
Message-ID: <1173065.LDd0MLacWM@spamfreemail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

switched to 2.6.1mm2 from 2.6.1-rc1-mm1, but this problem still remains:

Jan 12 08:17:42 ds9 kernel: PCI: Setting latency timer of device
0000:00:0d.0 to 64
Jan 12 08:17:42 ds9 kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI):
IRQ=[12]  MMIO=[de084000-de0847ff]  Max Packet=[2048]
Jan 12 08:17:42 ds9 kernel: Debug: sleeping function called from invalid
context at mm/slab.c:1868
Jan 12 08:17:42 ds9 kernel: in_atomic():1, irqs_disabled():0
Jan 12 08:17:42 ds9 kernel: Call Trace:
Jan 12 08:17:42 ds9 kernel:  [__might_sleep+171/208] __might_sleep+0xab/0xd0
Jan 12 08:17:42 ds9 kernel:  [kmem_cache_alloc+514/528] kmem_cache_allo
+0x202/0x210
Jan 12 08:17:42 ds9 kernel:  [dup_task_struct+41/240] dup_task_struc
+0x29/0xf0
Jan 12 08:17:42 ds9 kernel:  [copy_process+209/3408] copy_process+0xd1/0xd50
Jan 12 08:17:42 ds9 kernel:  [poke_blanked_console+112/176]
poke_blanked_console+0x70/0xb0
Jan 12 08:17:42 ds9 kernel:  [do_fork+77/384] do_fork+0x4d/0x180
Jan 12 08:17:42 ds9 kernel:  [kernel_thread+133/144] kernel_thread+0x85/0x90
Jan 12 08:17:42 ds9 kernel:  [__crc_path_release+1459278/3128146]
nodemgr_host_thread+0x0/0x1a0 [ieee1394]
Jan 12 08:17:42 ds9 kernel:  [kernel_thread_helper+0/24]
kernel_thread_helper+0x0/0x18
Jan 12 08:17:42 ds9 kernel:  [__crc_path_release+1460475/3128146]
nodemgr_add_host+0xad/0x100 [ieee1394]
Jan 12 08:17:42 ds9 kernel:  [__crc_path_release+1459278/3128146]
nodemgr_host_thread+0x0/0x1a0 [ieee1394]
Jan 12 08:17:42 ds9 kernel:  [__crc_path_release+1441228/3128146]
highlevel_add_host+0x8e/0xa0 [ieee1394]
Jan 12 08:17:42 ds9 kernel:  [__crc_path_release+1438130/3128146]
hpsb_add_host+0x14/0x40 [ieee1394]
Jan 12 08:17:42 ds9 kernel:  [__crc_path_release+630705/3128146]
ohci1394_pci_probe+0x433/0x5b0 [ohci1394]
Jan 12 08:17:42 ds9 kernel:  [__crc_path_release+619374/3128146]
ohci_irq_handler+0x0/0xe60 [ohci1394]
Jan 12 08:17:42 ds9 kernel:  [pci_device_probe_static+75/96]
pci_device_probe_static+0x4b/0x60
Jan 12 08:17:42 ds9 kernel:  [__pci_device_probe+54/80] __pci_device_prob
+0x36/0x50
Jan 12 08:17:42 ds9 kernel:  [pci_device_probe+44/80] pci_device_prob
+0x2c/0x50
Jan 12 08:17:42 ds9 kernel:  [bus_match+61/112] bus_match+0x3d/0x70
Jan 12 08:17:42 ds9 kernel:  [driver_attach+90/144] driver_attach+0x5a/0x90
Jan 12 08:17:42 ds9 kernel:  [bus_add_driver+165/192] bus_add_drive
+0xa5/0xc0
Jan 12 08:17:42 ds9 kernel:  [pci_register_driver+122/160]
pci_register_driver+0x7a/0xa0
Jan 12 08:17:42 ds9 kernel:  [__crc_path_release+159139/3128146]
ohci1394_init+0x15/0x3c [ohci1394]
Jan 12 08:17:42 ds9 kernel:  [sys_init_module+363/768] sys_init_modul
+0x16b/0x300
Jan 12 08:17:42 ds9 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 12 08:17:42 ds9 kernel:
Jan 12 08:17:42 ds9 kernel: raw1394: /dev/raw1394 device initialized


I get many more of these (every minute) if I start XFree86. Is this
something critical or just "interesting" debugging info?




-- 
Jens Benecke
