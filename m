Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUKIX0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUKIX0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUKIX0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:26:31 -0500
Received: from mail.appliedminds.com ([65.104.119.58]:11697 "EHLO
	appliedminds.com") by vger.kernel.org with ESMTP id S261764AbUKIX0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:26:03 -0500
Message-ID: <419150CF.1060702@appliedminds.com>
Date: Tue, 09 Nov 2004 15:20:47 -0800
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 broke Cirque HID Touchpad support
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed that 2.6.9 seems to have broken support for my Cirque USB touchpad.
With 2.6.8-gentoo-r4 it works fine with essentially the same kernel config:

hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
usb 2-1: new low speed USB device using address 3
usb 2-1: skipped 1 descriptor after interface
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: default language 0x0409
usb 2-1: Product: USB GlidePoint
usb 2-1: Manufacturer: Cirque Corporation
usb 2-1: hotplug
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: USB HID v1.00 Mouse [Cirque Corporation USB GlidePoint] on usb-0000:00:10.0-1

With 2.6.9-gentoo-r1 I get the following USB debug messages:

usb 2-1: new low speed USB device using address 5
uhci_hcd 0000:00:10.0: uhci_result_control: failed with status 440000
[000001003f891300] link (3f891242) element (3f890060)
0: [000001003f890060] link (3f8900c0) e0 LS Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=3f5d84e0)
1: [000001003f8900c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
uhci_hcd 0000:00:10.0: uhci_result_control: failed with status 440000
[000001003f891300] link (3f891242) element (3f890060)
0: [000001003f890060] link (3f8900c0) e0 LS Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=3f5d84e0)
1: [000001003f8900c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
usb 2-1: device not accepting address 5, error -71
uhci_hcd 0000:00:10.0: CTRL: TypeReq=0x2301 val=0x2 idx=0x0 len=0 ==> -32
usb 2-1: new low speed USB device using address 6
uhci_hcd 0000:00:10.0: uhci_result_control: failed with status 440000
[000001003f891300] link (3f891242) element (3f890060)
0: [000001003f890060] link (3f8900c0) e0 LS Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=3f5d84e0)
1: [000001003f8900c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
uhci_hcd 0000:00:10.0: uhci_result_control: failed with status 440000
[000001003f891300] link (3f891242) element (3f890060)
0: [000001003f890060] link (3f8900c0) e0 LS Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=3f5d8500)
1: [000001003f8900c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
usb 2-1: device not accepting address 6, error -71

Here are relevant config vars:
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT=y

CONFIG_INPUT=y

CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_MOUSE=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y


CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y

CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

-- 
James Lamanna
