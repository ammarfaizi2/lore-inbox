Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUDPIXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 04:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUDPIXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 04:23:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262709AbUDPIXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 04:23:20 -0400
Date: Fri, 16 Apr 2004 04:23:11 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: oops when loading ehci_hcd
Message-ID: <20040416082311.GA2756@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a 2.6.6-rc1 based kernel. Happened when loading ehci_hcd some
10 hours after booting, couldn't reproduce in initial attempts. I
suppose the question is also why it failed to init, but it certainly
didn't like the failure...

Bill

PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: illegal capability!
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem 22946000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: init error -19ehci_hcd 0000:00:1d.7: remove, state 0
Unable to handle kernel NULL pointer dereference at virtual address 00000048
 printing eip:
22a16b84
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<22a16b84>]    Not tainted
EFLAGS: 00210002   (2.6.5-1.326) 
EIP is at scan_async+0x36/0xf1 [ehci_hcd]
eax: 00000000   ebx: 1392c000   ecx: 228f75a8   edx: 00000000
esi: 00000000   edi: 1392c000   ebp: 00000000   esp: 1e977e3c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 28613, threadinfo=1e977000 task=186bf870)
Stack: 00000000 1392c000 00000000 03590444 c0000000 22a19736 1392c000 1392c07c 
       22a19540 00200206 00200206 0000002a 023b1e2a 00200246 c0000000 0211ed90 
       1e977e98 0211a5a7 00200206 00200206 00000029 023b1e29 00200246 00000000 
Call Trace:
 [<22a19736>] ehci_work+0x28/0x7d [ehci_hcd]
 [<22a19540>] ehci_stop+0xe8/0x156 [ehci_hcd]
 [<0211ed90>] printk+0x26a/0x2e3
 [<0211a5a7>] __wake_up+0x8a/0xee
 [<0225aa03>] usb_disconnect+0x16/0xd2
 [<02262792>] usb_hcd_pci_remove+0x77/0x129
 [<0226270c>] usb_hcd_pci_probe+0x3d7/0x3e6
 [<0219de1e>] create_dir+0x7c/0x99
 [<021ceb54>] pci_device_probe_static+0x2a/0x3d
 [<021ceb82>] __pci_device_probe+0x1b/0x2c
 [<021cebae>] pci_device_probe+0x1b/0x2d
 [<0221ba49>] bus_match+0x27/0x45
 [<0221bb15>] driver_attach+0x37/0x6a
 [<0221bd27>] bus_add_driver+0x6a/0x81
 [<0221c033>] driver_register+0x48/0x50
 [<021ced0c>] pci_register_driver+0x84/0x9f
 [<228e501b>] init+0x1b/0x22 [ehci_hcd]
 [<02136583>] sys_init_module+0x1ef/0x2c6

Code: 8b 70 48 85 f6 74 71 8d 46 4c 39 46 4c 74 31 8b 87 7c 02 00 
 <6>USB Universal Host Controller Interface driver v2.2
