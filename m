Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUCNVr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 16:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUCNVr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 16:47:26 -0500
Received: from mail3.absamail.co.za ([196.35.40.69]:33409 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S261806AbUCNVrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 16:47:21 -0500
Subject: [2.6.4] USB malfunction on ACPI resume
From: Niel Lambrechts <antispam@absamail.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1079300763.1752.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Mar 2004 23:46:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My Thinkpad R50P (Intel 82855PM with Speedstep 1.7GHz) shows the
following badness when resuming after an ACPI suspend - even if hotplug
and usb modules were never started beforehand: 

Mar 12 01:22:42 localhost kernel: 0 at 41
Mar 12 01:22:42 localhost kernel: ehci_hcd 0000:00:1d.7: capability
d49a4140 at
41                                                                   
Mar 12 01:22:42 localhost last message repeated 1266
times                 Mar 12 01:22:42 localhost kernel: 0 at
41                                  Mar 12 01:22:42 localhost kernel:
ehci_hcd 0000:00:1d.7: capability d49a4140 at
41                                                                    
times                  Mar 12 01:22:43 localhost kernel: Kernel logging
(proc) stopped by user.

This is repeated many many times -> CPU usage jumps to 100% (due to
ehci_hcd module) and klogd becomes very busy with the above nonsense.

I cannot remove ehci_hcd, any attempt to rmmod will just hang, only
resolve is to reboot.

Niel


Controller:
-----------
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01)


-------------
Kernel config:

CONFIG_USB_IRDA=m
CONFIG_BT_HCIUSB=m
# CONFIG_BT_HCIUSB_SCO is not set
# CONFIG_BT_HCIBFUSB is not set
# ALSA USB devices
# CONFIG_SND_USB_AUDIO is not set
# USB support
CONFIG_USB=m
CONFIG_USB_DEBUG=y
# Miscellaneous USB options
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# USB Host Controller Drivers
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
# USB Device Class drivers
CONFIG_USB_AUDIO=m
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# USB Human Interface Devices (HID)
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# USB HID Boot Protocol drivers
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
# CONFIG_USB_XPAD is not set
# USB Imaging devices
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m
# USB Multimedia devices
# CONFIG_USB_DABUSB is not set
# Video4Linux support is needed for USB Multimedia device support
# USB Network adaptors
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# USB port drivers
# CONFIG_USB_USS720 is not set
# USB Serial Converter support
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
CONFIG_USB_SERIAL_IPAQ=m
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# USB Miscellaneous drivers
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_BRLVGER is not set
CONFIG_USB_LCD=m
# CONFIG_USB_LED is not set
# CONFIG_USB_TEST is not set
# USB Gadget Support
# CONFIG_USB_GADGET is not set
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_SERIAL_8250_ACPI is not set

