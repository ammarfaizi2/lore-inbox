Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTLKAnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 19:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTLKAnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 19:43:24 -0500
Received: from sisko.nodomain.org ([213.208.99.114]:8843 "EHLO
	mail.nodomain.org") by vger.kernel.org with ESMTP id S264266AbTLKAnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 19:43:22 -0500
From: Tony Hoyle <tmh@nodomain.org>
To: linux-kernel@vger.kernel.org
Subject: dvb 2.6.0-test11-bk7 kernel BUG 
Date: Thu, 11 Dec 2003 00:43:02 +0000
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312110043.03696.tmh@nodomain.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When I try to load the drivers for my hauppauge nova-t I get the following in 
syslog:

Dec 11 00:35:30 spock kernel: kernel BUG at drivers/media/common/
saa7146_core.c:67!
Dec 11 00:35:30 spock kernel: invalid operand: 0000 [#1]
Dec 11 00:35:30 spock kernel: CPU:    0
Dec 11 00:35:30 spock kernel: EIP:    0060:[__crc_set_disk_ro+2915005/3780278]    
Tainted: P
Dec 11 00:35:30 spock kernel: EFLAGS: 00210202
Dec 11 00:35:30 spock kernel: EIP is at vmalloc_to_sg+0x71/0xb0 [saa7146]
Dec 11 00:35:30 spock kernel: eax: 02000100   ebx: f72c5000   ecx: f6e4d9c8   
edx: c19ca568
Dec 11 00:35:30 spock kernel: esi: f9e72000   edi: 00000000   ebp: f72c5c94   
esp: f1d67dd8
Dec 11 00:35:30 spock kernel: ds: 007b   es: 007b   ss: 0068
Dec 11 00:35:30 spock kernel: Process modprobe (pid: 4934, threadinfo=f1d66000 
task=f52180c0)
Dec 11 00:35:30 spock kernel: Stack: f9e72000 000000d0 000002f0 f72c5c00 
0000002f f9e72000 f72c5c94 f9e27de4
Dec 11 00:35:30 spock kernel:        f9e72000 0000002f f9e70988 f9e68b3f 
f72c5c00 f6e88c00 f72c5f44 f9e16360
Dec 11 00:35:30 spock kernel:        f9e126b2 c1ae7800 0002f000 f72c5c94 
00000000 00000000 f72c5c00 f9e16368
Dec 11 00:35:30 spock kernel: Call Trace:
Dec 11 00:35:30 spock kernel:  [__crc_set_disk_ro+2915120/3780278] 
saa7146_vmalloc_build_pgtable+0x34/0xd0 [saa7146]
Dec 11 00:35:30 spock kernel:  [__crc_set_disk_ro+3180683/3780278] 
dvb_register_i2c_bus+0x6f/0xa0 [dvb_core]
Dec 11 00:35:30 spock kernel:  [__crc_set_disk_ro+2827262/3780278] 
ttpci_budget_init+0xf2/0x200 [budget_core]
Dec 11 00:35:30 spock kernel:  [__crc_set_disk_ro+2838972/3780278] 
budget_attach+0x50/0xe0 [budget]
Dec 11 00:35:30 spock kernel:  [sprintf+31/48] sprintf+0x1f/0x30
Dec 11 00:35:30 spock kernel:  [__crc_set_disk_ro+2917350/3780278] 
saa7146_init_one+0x36a/0x650 [saa7146]
Dec 11 00:35:30 spock kernel:  [dput+34/528] dput+0x22/0x210
Dec 11 00:35:30 spock kernel:  [pci_device_probe_static+82/112] 
pci_device_probe_static+0x52/0x70
Dec 11 00:35:30 spock kernel:  [__pci_device_probe+59/80] __pci_device_probe
+0x3b/0x50
Dec 11 00:35:30 spock kernel:  [pci_device_probe+44/80] pci_device_probe
+0x2c/0x50
Dec 11 00:35:30 spock kernel:  [bus_match+63/112] bus_match+0x3f/0x70
Dec 11 00:35:30 spock kernel:  [driver_attach+89/144] driver_attach+0x59/0x90
Dec 11 00:35:30 spock kernel:  [bus_add_driver+141/160] bus_add_driver
+0x8d/0xa0
Dec 11 00:35:30 spock kernel:  [driver_register+47/64] driver_register
+0x2f/0x40
Dec 11 00:35:30 spock kernel:  [pci_register_driver+92/144] 
pci_register_driver+0x5c/0x90
Dec 11 00:35:30 spock kernel:  [__crc_set_disk_ro+2918668/3780278] 
saa7146_register_extension+0xa0/0x100 [saa7146]
Dec 11 00:35:30 spock kernel:  [__crc_set_disk_ro+2850139/3780278] budget_init
+0xf/0x13 [budget]
Dec 11 00:35:30 spock kernel:  [sys_init_module+280/560] sys_init_module
+0x118/0x230
Dec 11 00:35:30 spock kernel:  [sysenter_past_esp+82/113] sysenter_past_esp
+0x52/0x71
Dec 11 00:35:30 spock kernel:
Dec 11 00:35:30 spock kernel: Code: 0f 0b 43 00 80 91 e2 f9 89 f8 81 c6 00 10 
00 00 47 c1 e0 04

This appears to be something to do with highmem support - I have 1GB of RAM so 
really need some sort of highmem enabled...  

Tony


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/172W5UdHDk9LaRcRAgTFAJ4+Hco1VYjDx3QO+UfLoMWmIbfx/ACgi1ed
E8x6nkTTV7ftxo8vJZdSxtc=
=kL+Y
-----END PGP SIGNATURE-----
