Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269498AbUJLG5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269498AbUJLG5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269500AbUJLG5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:57:36 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:23521 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269498AbUJLG50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:57:26 -0400
Message-ID: <416B8046.8080809@t-online.de>
Date: Tue, 12 Oct 2004 08:57:10 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB Problem (was: 2.6.9-rc4: Aiee on amd64)
References: <416A98B3.7050805@t-online.de>
In-Reply-To: <416A98B3.7050805@t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: SspSToZeYe3ZOBWMGDZK3ARqgLR2xsho53X-Q4MHBCsWMfKrxMPe6z
X-TOI-MSGID: 52f622b7-c8f3-4d73-aa4b-f27f56e82ea1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Hi folks,
> 
> I installed 2.6.9-rc4 this morning, but it died at boot time
> (a lot of hex output and something about "Aiee" :-). I tried
> to redirect syslog to another host, but the error message did
> not show up in the foreign log files.
> 
> Any idea how to catch this message? The problem seems to be
> reproducable, and I would be glad to help.
> 

I disabled ehci_hcd.ko in the boot procedure and loaded
it manually when syslog was running. This was written into
kern.log:

:
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 11, pci mem ffffff0000b98000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
usb 1-3: new high speed USB device using address 2
ub: sizeof ub_scsi_cmd 88 ub_dev 1112
uba: device 2 capacity nsec 50 bsize 512
uba: made changed
uba: device 2 capacity nsec 50 bsize 512
uba: device 2 capacity nsec 50 bsize 512
  /dev/ub/a:end_request: I/O error, dev uba, sector 0
Buffer I/O error on device uba, logical block 0
end_request: I/O error, dev uba, sector 2
Buffer I/O error on device uba, logical block 1
end_request: I/O error, dev uba, sector 4
Buffer I/O error on device uba, logical block 2
end_request: I/O error, dev uba, sector 6
Buffer I/O error on device uba, logical block 3
end_request: I/O error, dev uba, sector 6
Buffer I/O error on device uba, logical block 3
end_request: I/O error, dev uba, sector 4
Buffer I/O error on device uba, logical block 2
end_request: I/O error, dev uba, sector 2
Buffer I/O error on device uba, logical block 1
end_request: I/O error, dev uba, sector 0
Buffer I/O error on device uba, logical block 0
  unable to read partition table
  /dev/ub/a:end_request: I/O error, dev uba, sector 2
Buffer I/O error on device uba, logical block 1
end_request: I/O error, dev uba, sector 4
Buffer I/O error on device uba, logical block 2
end_request: I/O error, dev uba, sector 6
Buffer I/O error on device uba, logical block 3
end_request: I/O error, dev uba, sector 0
Buffer I/O error on device uba, logical block 0
  unable to read partition table
usbcore: registered new driver ub
usb 1-4: new high speed USB device using address 3


If I keep ehci_hcd in the boot procedure, then the
kernel dies immediately after printing these messages.
In my test environment there was no crash, though.


Regards

Harri
