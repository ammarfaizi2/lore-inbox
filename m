Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbUDZLdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUDZLdc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 07:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUDZLdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 07:33:32 -0400
Received: from FE-mail04.albacom.net ([213.217.149.84]:25532 "EHLO
	FE-mail04.sfg.albacom.net") by vger.kernel.org with ESMTP
	id S261928AbUDZLda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 07:33:30 -0400
Message-ID: <005c01c42b82$60d82f60$0200a8c0@arrakis>
Reply-To: "Marco Cavallini" <arm.linux@koansoftware.com>
From: "Marco Cavallini" <arm.linux@koansoftware.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with CONFIG_USB_SL811HS 
Date: Mon, 26 Apr 2004 13:33:45 +0200
Organization: Koan s.a.s.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am facing to a problem using linux-2.4.25-vrs2 and/or 2.4.26-vrs1 (ARM
porting).
I think this problem come from the linux kernel and not from ARM patch.
Seems that there is a problem building SL811 USB hosts because if I enable
CONFIG_USB_SL811HS option
the driver seems to be not build and is not running.
I don't know how to manage drivers/usb/host/Makefile for  O_TARGET := in
this case.
Could someone suggest me what to do ?
TIA
Marco Cavallini

# drivers/usb/host/Makefile
# Makefile for USB Host Controller Driver
# framework and drivers
#

O_TARGET :=

obj-$(CONFIG_USB_EHCI_HCD)   += ehci-hcd.o
obj-$(CONFIG_USB_UHCI_ALT)   += uhci.o
obj-$(CONFIG_USB_UHCI)    += usb-uhci.o
obj-$(CONFIG_USB_OHCI)    += usb-ohci.o usb-ohci-pci.o
obj-$(CONFIG_USB_SL811HS_ALT)     += sl811.o
obj-$(CONFIG_USB_SL811HS)     += hc_sl811.o
obj-$(CONFIG_USB_OHCI_SA1111)   += usb-ohci.o usb-ohci-sa1111.o
obj-$(CONFIG_USB_OHCI_AT91)   += usb-ohci.o

# Extract lists of the multi-part drivers.
# The 'int-*' lists are the intermediate files used to build the multi's.
multi-y  := $(filter $(list-multi), $(obj-y))
multi-m  := $(filter $(list-multi), $(obj-m))
int-y  := $(sort $(foreach m, $(multi-y), $($(basename $(m))-objs)))
int-m  := $(sort $(foreach m, $(multi-m), $($(basename $(m))-objs)))

# Take multi-part drivers out of obj-y and put components in.
obj-y  := $(filter-out $(list-multi), $(obj-y)) $(int-y)

# Translate to Rules.make lists.
OX_OBJS  := $(obj-y)
MX_OBJS  := $(obj-m)
MIX_OBJS := $(int-m)

include $(TOPDIR)/Rules.make

