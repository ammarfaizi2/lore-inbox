Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVATVMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVATVMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVATVMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:12:37 -0500
Received: from main.gmane.org ([80.91.229.2]:43464 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261950AbVATVLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:11:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <Fieroch@web.de>
Subject: usb storage device bug in kernel module - I/O error
Date: Thu, 20 Jan 2005 22:10:49 +0100
Message-ID: <csp6oq$pld$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: de-de, en-us, en
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello kernel list,

I don't know if this is the right list for problems with kernel modules
and bugs - if not please tell me where I can find the kernel development
mailing list to report this.

So here is my problem:
I get errors when I try to copy files to my usb harddisk. In the first
minutes it works fine but then I get following errors for each block to
write on the disk:

Jan 20 10:07:53 orclex kernel: SCSI error : <1 0 0 0> return code = 0x70000
Jan 20 10:07:53 orclex kernel: end_request: I/O error, dev sda, sector
1555604
Jan 20 10:07:53 orclex kernel: Buffer I/O error on device sda6, logical
block 190016
Jan 20 10:07:53 orclex kernel: lost page write due to I/O error on sda6
Jan 20 10:07:53 orclex kernel: SCSI error : <1 0 0 0> return code = 0x70000
Jan 20 10:07:53 orclex kernel: end_request: I/O error, dev sda, sector
1555605
Jan 20 10:07:53 orclex kernel: Buffer I/O error on device sda6, logical
block 190017
Jan 20 10:07:53 orclex kernel: lost page write due to I/O error on sda6
...


I'm using kernel 2.6.10 and the error appears when I load the ehci_hcd
module for USB 2.0. When I don't use this module (so I can only use usb
1.1) I get no errors while copying files to the usb harddisk.

I have got an ALi PCI-Card for USB 2.0:


0000:00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
~        Subsystem: ALi Corporation USB 1.1 Controller
~        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 10
~        Memory at e2003000 (32-bit, non-prefetchable) [size=4K]
~        Capabilities: [60] Power Management version 2

0000:00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
(prog-if 20 [EHCI])
~        Subsystem: ALi Corporation USB 2.0 Controller
~        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 9
~        Memory at e2004000 (32-bit, non-prefetchable) [size=256]
~        Capabilities: [50] Power Management version 2
~        Capabilities: [58] #0a [2090]


Here is an extract of my /var/log/syslog while loading my usb storage
device:


Jan 20 10:02:29 orclex kernel: PCI: Found IRQ 9 for device 0000:00:13.3
Jan 20 10:02:29 orclex kernel: ehci_hcd 0000:00:13.3: ALi Corporation
USB 2.0 Controller
Jan 20 10:02:29 orclex kernel: ehci_hcd 0000:00:13.3: irq 9, pci mem
0xe2004000
Jan 20 10:02:29 orclex kernel: ehci_hcd 0000:00:13.3: new USB bus
registered, assigned bus number 3
Jan 20 10:02:29 orclex kernel: ehci_hcd 0000:00:13.3: USB 2.0
initialized, EHCI 1.00, driver 26 Oct 2004
Jan 20 10:02:29 orclex kernel: hub 3-0:1.0: USB hub found
Jan 20 10:02:29 orclex kernel: hub 3-0:1.0: 2 ports detected
Jan 20 10:02:29 orclex kernel: usb 3-2: new high speed USB device using
ehci_hcd and address 2
Jan 20 10:02:29 orclex kernel: scsi1 : SCSI emulation for USB Mass
Storage devices
Jan 20 10:02:29 orclex kernel: usb-storage: device found at 2
Jan 20 10:02:29 orclex kernel: usb-storage: waiting for device to settle
before scanning
Jan 20 10:02:29 orclex kernel:   Vendor: SAMSUNG   Model: SP1203N
~    Rev: SN10
Jan 20 10:02:29 orclex kernel:   Type:   Direct-Access
~    ANSI SCSI revision: 00
Jan 20 10:02:29 orclex kernel: SCSI device sda: 234493057 512-byte hdwr
sectors (120060 MB)
Jan 20 10:02:29 orclex kernel: sda: assuming drive cache: write through
Jan 20 10:02:29 orclex kernel: SCSI device sda: 234493057 512-byte hdwr
sectors (120060 MB)
Jan 20 10:02:29 orclex kernel: sda: assuming drive cache: write through
Jan 20 10:02:29 orclex kernel:  sda: sda2 < sda5 sda6 > sda3
Jan 20 10:02:29 orclex kernel: Attached scsi disk sda at scsi1, channel
0, id 0, lun 0
Jan 20 10:02:29 orclex kernel: Attached scsi generic sg0 at scsi1,
channel 0, id 0, lun 0,  type 0
Jan 20 10:02:29 orclex kernel: usb-storage: device scan complete


Is this a known bug and does any patch exist?

Thanks in advance,

Alexander

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8B5ZlLqZutoTiOMRAjW2AJ9sejPtLrIyARZ+kr2kxb5qNByS/QCffIL7
AyLyA0HdsFqhYTvDE3ygz2M=
=Ds1a
-----END PGP SIGNATURE-----

