Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTDIVgY (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbTDIVgY (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:36:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49631 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263834AbTDIVgV (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:36:21 -0400
Date: Wed, 09 Apr 2003 14:37:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 565] New: "can't resubmit intr  status -19" when disconnecting USB device 
Message-ID: <10230000.1049924273@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=565

           Summary: "can't resubmit intr  status -19" when disconnecting USB
                    device
    Kernel Version: 2.5.67-bk1
            Status: NEW
          Severity: low
             Owner: greg@kroah.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing

Hardware Environment:
Intel PIIX4, MS Wheelmouse Optical USB

Software Environment: 
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y

Problem Description:

When disconnecting a USB mouse, I'm seeing this odd error on my console:
drivers/usb/input/hid-core.c: can't resubmit intr, 00:07.2-1/input0, status -19

The entire series of messages, from insert to removal, are:
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye
(TM)] on usb-00:07.2-1
<pull out USB cable here>
usb 1-1: USB disconnect, address 2
drivers/usb/input/hid-core.c: can't resubmit intr, 00:07.2-1/input0, status -19

dmesg | grep -i usb:
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye
(TM)] on usb-00:07.2-1
usb 1-1: USB disconnect, address 2
drivers/usb/input/hid-core.c: can't resubmit intr, 00:07.2-1/input0, status -19

Steps to reproduce:
Insert USB mouse, then remove it from USB port.


