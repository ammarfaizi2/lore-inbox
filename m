Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264237AbUD0Rgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264237AbUD0Rgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUD0Rgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:36:49 -0400
Received: from FE-mail03.albacom.net ([213.217.149.83]:24461 "EHLO
	FE-mail03.sfg.albacom.net") by vger.kernel.org with ESMTP
	id S264237AbUD0Rfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:35:46 -0400
Message-ID: <000701c42c7e$20214810$0200a8c0@arrakis>
Reply-To: "Marco Cavallini" <arm.linux@koansoftware.com>
From: "Marco Cavallini" <arm.linux@koansoftware.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>
References: <005c01c42b82$60d82f60$0200a8c0@arrakis> <20040426185612.GB28530@kroah.com> <003501c42c24$06e87940$0200a8c0@arrakis> <20040427171737.GB2465@mars.ravnborg.org>
Subject: Re: Problem with CONFIG_USB_SL811HS
Date: Tue, 27 Apr 2004 19:36:06 +0200
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

In Linux-2.4.26 the problem is in 
drivers/usb/host/Makefile

After this block....
subdir-$(CONFIG_USB_OHCI_AT91) += host
ifeq ($(CONFIG_USB_OHCI_AT91),y)
 obj-y += host/usb-ohci.o
endif

...I added this...
######## Begin new code MCK ##########
subdir-$(CONFIG_USB_SL811HS) += host
ifeq ($(CONFIG_USB_SL811HS),y)
 obj-y += host/hc_sl811.o
endif
subdir-$(CONFIG_USB_SL811HS_ALT) += host
ifeq ($(CONFIG_USB_SL811HS_ALT),y)
 obj-y += host/sl811.o
endif
######## End new code MCK ##########

There are also minor modifications, but I'm still working on this driver.
Marco Cavallini
==============================================
Koan s.a.s. - Software Engineering  (x86 and ARM)
Linux solutions for Embedded and Real-Time Software
  - Intel PCA Developer Network member
Via Pascoli, 3  - 24121 Bergamo - ITALIA
Tel./Fax (++39) +35 - 255.235 - www.koansoftware.com
==============================================
