Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVC1QoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVC1QoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVC1QoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:44:24 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:57873 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261876AbVC1QoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:44:17 -0500
Message-ID: <424834B7.5080805@mrv.com>
Date: Mon, 28 Mar 2005 18:45:43 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [OOPS] paport related OOPS since 2.6.11-bk7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The OOPS below gets generated consistently when FC3 kudzu is run during 
boot (tested between 2.6.11-bk7 and 2.6.11.6-bk1). It seems to be caused 
by the hotplug-parport changeset:
http://linux.bkbits.net:8080/linux-2.5/cset@4230791b6YtcIhZDSvvWbzSdUpg2zg?nav=index.html|ChangeSet@-4w
(reverting this changeset eliminates the oops).

parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
parport_pc: VIA parallel port: io=0x378, irq=7
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
d3f37368
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: parport_pc parport binfmt_misc nls_cp437 
nls_iso8859_1 ntfs video thermal processor fan container button battery 
ac uhci_hcd usbcore 3c59x mii
CPU:    0
EIP:    0060:[<d3f37368>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-rc1)
EIP is at parport_pc_pci_remove+0x18/0x40 [parport_pc]
eax: c12ef844   ebx: c12ef800   ecx: c12ef844   edx: d3f37350
esi: 00000000   edi: d3f3cc68   ebp: ce53aecc   esp: ce53aec0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3187, threadinfo=ce53a000 task=cfbe2570)
Stack: c018f481 c12ef800 c12ef844 ce53aedc c0239636 c12ef800 c12ef868 
ce53aef8
        c02fe67c c12ef844 c040412e d3f3ccb0 d3f3ccb0 d3f375a0 ce53af0c 
c02fe6a0
        c12ef844 d3f3cc68 00000000 ce53af24 c02feb9a d3f3cc68 d3f3cc68 
d3f3cc68
Call Trace:
  [<c0103ebf>] show_stack+0x7f/0xa0
  [<c0104056>] show_registers+0x156/0x1d0
  [<c010427a>] die+0xea/0x180
  [<c01149a2>] do_page_fault+0x482/0x6ba
  [<c0103b23>] error_code+0x2b/0x30
  [<c0239636>] pci_device_remove+0x36/0x40
  [<c02fe67c>] device_release_driver+0x7c/0x80
  [<c02fe6a0>] driver_detach+0x20/0x30
  [<c02feb9a>] bus_remove_driver+0x4a/0x90
  [<c02ff162>] driver_unregister+0x12/0x20
  [<c0239875>] pci_unregister_driver+0x15/0x20
  [<d3f3763e>] parport_pc_exit+0x9e/0xae [parport_pc]
  [<c0133fce>] sys_delete_module+0x17e/0x1b0
  [<c010303b>] sysenter_past_esp+0x54/0x75
Code: 44 24 04 89 0c 24 ff d2 eb 94 89 f6 8d bc 27 00 00 00 00 55 89 e5 
56 53 83 ec 04 8b 45 08 83 c0 44 8b 70 74 c7 40 74 00 00 00 00 <8b> 1e 
eb 10 8d 74 26 00 8b 44 9e 04 89 04 24 e8 d4 f4 ff ff 4b


-- 
Eran Mann
MRV International
www.mrv.com
