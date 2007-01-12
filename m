Return-Path: <linux-kernel-owner+w=401wt.eu-S1750977AbXALMZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXALMZH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 07:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbXALMZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 07:25:07 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:21144 "EHLO
	noname.neutralserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbXALMZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 07:25:05 -0500
Date: Fri, 12 Jan 2007 14:24:44 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: kexec + USB storage in 2.6.19
Message-ID: <20070112122444.GA28597@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-PopBeforeSMTPSenders: da-x@monatomic.org
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After upgrading from 2.6.18.3 to 2.6.19.2 on an x86_64 machine I noticed 
that the EHCI USB host is unable to work properly after a kexec invocation. 
This makes it impossible to mount the rootfs in the configuration I'm using.

According to the prints, the irq changes from 23 to 10.

NOTE: Since the device is already connected at boot, I've added a patch 
that disables the scanning delay for the first detected device, in order 
to shorten the time it takes for the boot process. It worked on 2.6.18.3, 
so I wonder what has changed...

[   92.426719] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   92.432008] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   92.439422] ehci_hcd 0000:00:1d.7: debug port 1
[   92.443961] ehci_hcd 0000:00:1d.7: irq 10, io mem 0xdc001000
[   92.453472] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   92.461034] usb usb1: configuration #1 chosen from 1 choice
[   92.466625] hub 1-0:1.0: USB hub found
[   92.470373] hub 1-0:1.0: 8 ports detected
[   92.581134] Initializing USB Mass Storage driver...
[   92.828571] usb 1-1: new high speed USB device using ehci_hcd and address 2
[   93.834658] ehci_hcd 0000:00:1d.7: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.
[  104.374665] usb 1-1: device not accepting address 2, error -110
[  104.494441] usb 1-1: new high speed USB device using ehci_hcd and address 3
[  116.024567] usb 1-1: device not accepting address 3, error -110
[  116.144343] usb 1-1: new high speed USB device using ehci_hcd and address 4
[  126.556589] usb 1-1: device not accepting address 4, error -110
[  126.676365] usb 1-1: new high speed USB device using ehci_hcd and address 5
[  137.088612] usb 1-1: device not accepting address 5, error -110
[  137.336145] usb 1-2: new high speed USB device using ehci_hcd and address 6
[  148.866271] usb 1-2: device not accepting address 6, error -110
[  148.982055] usb 1-2: new high speed USB device using ehci_hcd and address 7
[  160.512181] usb 1-2: device not accepting address 7, error -110
[  160.627965] usb 1-2: new high speed USB device using ehci_hcd and address 8
[  171.040211] usb 1-2: device not accepting address 8, error -110
[  171.155995] usb 1-2: new high speed USB device using ehci_hcd and address 9
[  181.568241] usb 1-2: device not accepting address 9, error -110
[  181.574184] usbcore: registered new interface driver usb-storage
[  181.580182] USB Mass Storage support registered.


A normal boot works properly:

[   78.139976] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
[   78.148121] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   78.153411] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   78.160821] ehci_hcd 0000:00:1d.7: debug port 1
[   78.165362] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdc001000
[   78.174871] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   78.182454] usb usb1: configuration #1 chosen from 1 choice
[   78.188045] hub 1-0:1.0: USB hub found
[   78.191791] hub 1-0:1.0: 8 ports detected
[   78.303392] Initializing USB Mass Storage driver...
[   78.546834] usb 1-1: new high speed USB device using ehci_hcd and address 2
[   78.692172] usb 1-1: configuration #1 chosen from 1 choice
[   78.942075] usb 1-2: new high speed USB device using ehci_hcd and address 3
[   79.083324] usb 1-2: configuration #1 chosen from 1 choice
[   79.089135] scsi0 : SCSI emulation for USB Mass Storage devices
[   79.095172] scsi1 : SCSI emulation for USB Mass Storage devices
[   79.101184] usbcore: registered new interface driver usb-storage


  - Dan 
