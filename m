Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWISPI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWISPI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWISPI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:08:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49678 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750832AbWISPI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:08:27 -0400
Date: Tue, 19 Sep 2006 11:08:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Eric Buddington <ebuddington@verizon.net>
cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.18-rc5-mm1 USB BUG: atomic counter underflow
In-Reply-To: <20060918190438.c6b7f2b8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0609191106080.6671-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006, Andrew Morton wrote:

> Dunno if this is still relevant...
> 
> Begin forwarded message:
> 
> Date: Fri, 15 Sep 2006 18:07:47 -0400
> From: Eric Buddington <ebuddington@verizon.net>
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.18-rc5-mm1 USB BUG: atomic counter underflow
> 
> 
> I've been having lots of USB problems, mainly failure to recognize,
> and sometimes a hard krenel freeze. I'm using one active extension and
> an external hub at the moment, though I've used a variety of setups.
> 
> My procsesor is an Athlon XP, and uname says: 2.6.18-rc5-mm1 #1
> PREEMPT Wed Sep 6 13:46:26 EDT 2006 i686 unknown
> 
> While powering-cycling two devices simultaneously, I got the following
> in dmesg. Since the system's still up, here it is for your reading
> pleasure. I'll be happy to provide more information or experiment.
> 
> -Eric
> 
> --------------------------------------------------------------
> [520695.301449] usb 2-4.4.1: USB disconnect, address 12
> [520695.803888] usb 2-4.4.1: new high speed USB device using ehci_hcd and address 14
> [520695.916563] usb 2-4.4.1: device descriptor read/all, error -71
> [520696.003759] usb 2-4.4.1: new high speed USB device using ehci_hcd and address 15
> [520696.122290] usb 2-4.4.2: USB disconnect, address 13
> [520696.160162] usb 2-4.4.1: new device found, idVendor=0c0b, idProduct=b001
> [520696.160170] usb 2-4.4.1: new device strings: Mfr=73, Product=77, SerialNumber=101
> [520696.160174] usb 2-4.4.1: Product: USB 2.0 Storage Adaptor
> [520696.160177] usb 2-4.4.1: Manufacturer: DMI
> [520696.160180] usb 2-4.4.1: SerialNumber: 0B02014205299A98
> [520696.268447] usb 2-4.4.1: configuration #2 chosen from 1 choice
> [520696.291317] scsi11 : SCSI emulation for USB Mass Storage devices
> [520696.307889] usb-storage: device found at 15
> [520696.307894] usb-storage: waiting for device to settle before scanning
> [520696.763543] usb 2-4.4.2: new high speed USB device using ehci_hcd and address 16
> [520696.872051] usb 2-4.4.2: new device found, idVendor=04b4, idProduct=6830
> [520696.872059] usb 2-4.4.2: new device strings: Mfr=56, Product=78, SerialNumber=100
> [520696.872063] usb 2-4.4.2: Product: USB2.0 Storage Device
> [520696.872066] usb 2-4.4.2: Manufacturer: Cypress Semiconductor
> [520696.872069] usb 2-4.4.2: SerialNumber: DEF1073973FF
> [520696.987428] usb 2-4.4.2: configuration #1 chosen from 1 choice
> [520696.987845] scsi12 : SCSI emulation for USB Mass Storage devices
> [520697.013028] usb-storage: device found at 16
> [520697.013033] usb-storage: waiting for device to settle before scanning
> [520702.009762] scsi 12:0:0:0: CD-ROM            _NEC     DVD_RW ND-3540A  1.01 PQ: 0 ANSI: 0
> [520702.024233] sr0: scsi3-mmc drive: 40x/48x writer cd/rw xa/form2 cdda tray
> [520702.043783] sr 12:0:0:0: Attached scsi CD-ROM sr0
> [520702.081526] sr 12:0:0:0: Attached scsi generic sg0 type 5
> [520702.082790] usb-storage: device scan complete
> [520706.889684] usb 2-4.4.1: reset high speed USB device using ehci_hcd and address 15
> [520717.207982] usb 2-4.4.1: reset high speed USB device using ehci_hcd and address 15
> [520722.501044] usb 2-4.4.1: reset high speed USB device using ehci_hcd and address 15
> [520728.093909] usb 2-4.4.1: reset high speed USB device using ehci_hcd and address 15
> [520728.181851] usb 2-4.4.1: device descriptor read/64, error -71
> [520728.409439] usb 2-4.4.1: device firmware changed
> [520728.409593] scsi 11:0:0:0: scsi: Device offlined - not ready after error recovery
> [520728.409932] usb 2-4.4.1: USB disconnect, address 15
> [520728.412043] usb-storage: device scan complete
> [520728.617566] usb 2-4.4.1: new high speed USB device using ehci_hcd and address 17
> [520728.742596] usb 2-4.4.1: unable to read config index 0 descriptor/all
> [520728.742605] usb 2-4.4.1: can't read configurations, error -71
> [520800.449134] usb 2-4.4.1: USB disconnect, address 17
> [520800.449147] BUG: atomic counter underflow at:
> [520800.449362]  [<c0103b7c>] dump_trace+0x64/0x1a8
> [520800.449394]  [<c0103cd2>] show_trace_log_lvl+0x12/0x25
> [520800.449414]  [<c01042a1>] show_trace+0xd/0x10
> [520800.449433]  [<c01042e8>] dump_stack+0x19/0x1b
> [520800.449452]  [<c026a5ca>] kref_put+0x56/0x74
> [520800.450284]  [<c03c5b9f>] klist_dec_and_del+0x10/0x12
> [520800.451799]  [<c03c5c16>] klist_del+0x13/0x2b
> [520800.453813]  [<c02ba723>] device_del+0x1d/0x15f
> [520800.454930]  [<f89b7f19>] usb_disconnect+0x9b/0xe1 [usbcore]
> [520800.455006]  [<f89b8945>] hub_thread+0x35f/0x9be [usbcore]
> [520800.455032]  [<c0127266>] kthread+0xb0/0xde
> [520800.455186]  [<c010389f>] kernel_thread_helper+0x7/0x10

I just posted a series of 3 patches which ought to address this problem.  
Try them out:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115861119505737&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=115861119512433&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=115861154413429&w=2

Alan Stern

