Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTF1IiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 04:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbTF1IiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 04:38:24 -0400
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:60910
	"EHLO flat") by vger.kernel.org with ESMTP id S265113AbTF1IiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 04:38:23 -0400
Date: Sat, 28 Jun 2003 09:24:41 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [USB] [2.5.73-mm1] /etc/init.d/hotplug stop (rmmod uhci-hcd) never returns
Message-ID: <20030628082441.GA1979@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following suspend/resume with a USB mouse connected, I found thousands of:
drivers/usb/host/uhci-hcd.c: fca0: host controller halted. very bad

Trying to restart hotplug fails, leaving rmmod uhci-hcd stuck with the
following trace.

I had a USB mouse connected. Kernel is 2.5.73-mm1. Pre-empt enabled. Hardware
is Sony Vaio N505X, Celeron 333, BX chipset.  I think this has been around for
a while, as my system has not been able to shut down cleanly for some time

rmmod         D 00000000  3194   3191                     (NOTLB)
c1c93de4 00200086 00000000 00000000 00000000 4b87ad6e 00000000 00000000 
       00000000 c115db54 c1c92000 00000002 c7f890b0 00200292 c1c92000 c5ce6d80 
       c0107fb5 c7f890b8 00000001 c5ce6d80 c011a170 c7f890b8 c7f890b8 00000000 
Call Trace:
 [<c0107fb5>] __down+0x95/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010821c>] __down_failed+0x8/0xc
 [<c883f10e>] .text.lock.hub+0x5/0x97 [usbcore]
 [<c0168bc0>] dput+0x30/0x270
 [<c88520a0>] hub_driver+0x0/0xa0 [usbcore]
 [<c8852160>] usb_hcd_operations+0x0/0x20 [usbcore]
 [<c883b137>] usb_device_remove+0x67/0x70 [usbcore]
 [<c88520b8>] hub_driver+0x18/0xa0 [usbcore]
 [<c01d0396>] device_release_driver+0x66/0x70
 [<c01d04ee>] bus_remove_device+0x5e/0xb0
 [<c01cec1d>] device_del+0x5d/0xa0
 [<c01cec73>] device_unregister+0x13/0x30
 [<c883bc97>] usb_disconnect+0xb7/0x140 [usbcore]
 [<c8849178>] +0x0/0x928 [usbcore]
 [<c8843ce8>] usb_hcd_pci_remove+0x88/0x1e0 [usbcore]
 [<c8832e2c>] hcd_name+0x0/0x14 [uhci_hcd]
 [<c8835228>] uhci_pci_driver+0x28/0xa0 [uhci_hcd]
 [<c01b2afb>] pci_device_remove+0x3b/0x40
 [<c01d0396>] device_release_driver+0x66/0x70
 [<c8835270>] uhci_pci_driver+0x70/0xa0 [uhci_hcd]
 [<c8835270>] uhci_pci_driver+0x70/0xa0 [uhci_hcd]
 [<c01d03cb>] driver_detach+0x2b/0x40
 [<c8835228>] uhci_pci_driver+0x28/0xa0 [uhci_hcd]
 [<c01d062d>] bus_remove_driver+0x3d/0x80
 [<c8835228>] uhci_pci_driver+0x28/0xa0 [uhci_hcd]
 [<c8835228>] uhci_pci_driver+0x28/0xa0 [uhci_hcd]
 [<c01d0a43>] driver_unregister+0x13/0x28
 [<c8835228>] uhci_pci_driver+0x28/0xa0 [uhci_hcd]
 [<c8835200>] uhci_pci_driver+0x0/0xa0 [uhci_hcd]
 [<c01b2de6>] pci_unregister_driver+0x16/0x30
 [<c8835228>] uhci_pci_driver+0x28/0xa0 [uhci_hcd]
 [<c88352a0>] +0x0/0x100 [uhci_hcd]
 [<c8832d4f>] +0xf/0x60 [uhci_hcd]
 [<c8835200>] uhci_pci_driver+0x0/0xa0 [uhci_hcd]
 [<c0132449>] sys_delete_module+0x129/0x1a0
 [<c88352a0>] +0x0/0x100 [uhci_hcd]
 [<c0145f00>] do_munmap+0x120/0x1b0
 [<c01092ab>] syscall_call+0x7/0xb

