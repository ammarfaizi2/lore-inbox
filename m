Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUEZO7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUEZO7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 10:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUEZO7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 10:59:44 -0400
Received: from zeus.kernel.org ([204.152.189.113]:50082 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265724AbUEZO7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 10:59:36 -0400
Message-ID: <40B4AF96.5090608@bik-gmbh.de>
Date: Wed, 26 May 2004 16:54:14 +0200
From: Florian Hars <hars@bik-gmbh.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: de, de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at usb:848
Content-Type: multipart/mixed;
 boundary="------------060106040409030709070000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106040409030709070000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I am fighting with a USB CDRW drive that does not quite work, and while unpluging it
while it didn't want to be unmounted, I got:

May 26 16:35:33 prony kernel: ehci_hcd 0000:00:10.4: GetStatus port 1 status 003802 POWER OWNER sig=j  CSC
May 26 16:35:33 prony kernel: hub 1-0:1.0: port 1, status 0, change 1, 12 Mb/s
May 26 16:35:33 prony kernel: ehci_hcd 0000:00:10.4: GetStatus port 2 status 001002 POWER sig=se0  CSC
May 26 16:35:33 prony kernel: hub 1-0:1.0: port 2, status 100, change 1, 12 Mb/s
May 26 16:35:33 prony kernel: usb 1-2: USB disconnect, address 4
May 26 16:35:33 prony kernel: usb 1-2: usb_disable_device nuking all URBs
May 26 16:35:33 prony kernel: usb 1-2: unregistering interface 1-2:1.0
May 26 16:35:33 prony kernel: usb-storage: storage_disconnect() called
May 26 16:35:33 prony kernel: usb-storage: usb_stor_stop_transport called
May 26 16:35:33 prony kernel: usb-storage: -- dissociate_dev
May 26 16:35:33 prony kernel: usb-storage: -- sending exit command to thread
May 26 16:35:33 prony kernel: ----------- [cut here ] --------- [please bite here ] ---------
May 26 16:35:33 prony kernel: Kernel BUG at usb:848
May 26 16:35:33 prony kernel: invalid operand: 0000 [1] SMP
May 26 16:35:33 prony kernel: CPU 0
May 26 16:35:33 prony kernel: Pid: 6, comm: khubd Not tainted 2.6.6
May 26 16:35:33 prony kernel: RIP: 0010:[<ffffffff803d5aa3>] <ffffffff803d5aa3>{usb_stor_release_resources+83}
May 26 16:35:33 prony kernel: RSP: 0000:000001003fc9bda8  EFLAGS: 00010202
May 26 16:35:33 prony kernel: RAX: 0000000000000032 RBX: 000001003c654800 RCX: 0000000000000000
May 26 16:35:33 prony kernel: RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000100000000
May 26 16:35:33 prony kernel: RBP: 000001003f419c00 R08: 0000000000000000 R09: 0000000000000202
May 26 16:35:33 prony kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff80607a60
May 26 16:35:33 prony kernel: R13: 000001003de01188 R14: 000001003de01188 R15: 000001003faab600
May 26 16:35:33 prony kernel: FS:  0000000000000000(0000) GS:ffffffff806f5480(0000) knlGS:0000000000000000
May 26 16:35:33 prony kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
May 26 16:35:33 prony kernel: CR2: 0000000055569000 CR3: 0000000000101000 CR4: 00000000000006e0
May 26 16:35:33 prony kernel: Process khubd (pid: 6, stackpage=10001e73080)
May 26 16:35:33 prony kernel: Stack: ffffffff80607a20 ffffffff803b8c3b 000001003f419c18 ffffffff80607a60
May 26 16:35:33 prony kernel:        000001003f419c00 ffffffff803325d3 000001003f419c18 000001003f419c18
May 26 16:35:33 prony kernel:        000001003de010f0 ffffffff803326fb
May 26 16:35:33 prony kernel: Call Trace:<ffffffff803b8c3b>{usb_unbind_interface+59} <ffffffff803325d3>{device_release_driver+83}
May 26 16:35:33 prony kernel:        <ffffffff803326fb>{bus_remove_device+59} <ffffffff803316e8>{device_del+88}
May 26 16:35:33 prony kernel:        <ffffffff80331729>{device_unregister+9} <ffffffff803bff35>{usb_disable_device+213}
May 26 16:35:33 prony kernel:        <ffffffff803b9942>{usb_disconnect+210} <ffffffff803bc11e>{hub_port_connect_change+190}
May 26 16:35:33 prony kernel:        <ffffffff803bc53e>{hub_events+510} <ffffffff803bc785>{hub_thread+37}
May 26 16:35:33 prony kernel:        <ffffffff80133f30>{default_wake_function+0} <ffffffff801116ef>{child_rip+8}
May 26 16:35:33 prony kernel:        <ffffffff803bc760>{hub_thread+0} <ffffffff801116e7>{child_rip+0}
May 26 16:35:33 prony kernel:
May 26 16:35:33 prony kernel:
May 26 16:35:33 prony kernel: Code: 0f 0b dc d2 52 80 ff ff ff ff 50 03 90 48 c7 83 f0 00 00 00
May 26 16:35:33 prony kernel: RIP <ffffffff803d5aa3>{usb_stor_release_resources+83} RSP <000001003fc9bda8>
May 26 16:35:33 prony kernel:  <3>scsi9 (0:0): rejecting I/O to dead device
May 26 16:35:33 prony kernel: sr1: CDROM (ioctl) error, command: Xpwrite, Read disk info 00 00 00 00 00 00 00 02 00
May 26 16:35:33 prony kernel: sr: old sense key No Sense
May 26 16:35:33 prony kernel: Non-extended sense class 0 code 0x0
May 26 16:35:37 prony kernel: usb-storage: Reset interrupted by disconnect
May 26 16:35:37 prony kernel: usb-storage: scsi cmd done, result=0x70000
May 26 16:35:37 prony kernel: usb-storage: *** thread sleeping.

Do you need anything else, besides the attached gunziped config.gz?

Yours, Florian.


--------------060106040409030709070000
Content-Type: application/x-vnd.mozilla.guess-from-ext;
 name="config"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config"

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
--------------060106040409030709070000--
