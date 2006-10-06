Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422939AbWJFUnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422939AbWJFUnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422943AbWJFUnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:43:13 -0400
Received: from mailfe01.tele2.fr ([212.247.154.12]:61922 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1422939AbWJFUnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:43:11 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Fri, 6 Oct 2006 22:42:54 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: Early keyboard initialization?
Message-ID: <20061006204254.GD5489@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any reason for initializing the input layer and keyboards so
late?  Since prevents from being able to perform alt-sysrqs early, and
blind people who use speakup would like to get early control over the
speech.  Here is the patch that they use.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- /usr/src/linux-2.6.18/drivers/Makefile.orig	2006-10-06 11:34:15.000000000 -0400
+++ drivers/Makefile	2006-10-06 11:34:15.000000000 -0400
@@ -27,6 +27,9 @@
 
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
+obj-$(CONFIG_SERIO)		+= input/serio/
+obj-$(CONFIG_GAMEPORT)		+= input/gameport/
+obj-$(CONFIG_INPUT)		+= input/
 obj-y				+= base/ block/ misc/ mfd/ net/ media/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
@@ -50,9 +53,6 @@
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
-obj-$(CONFIG_SERIO)		+= input/serio/
-obj-$(CONFIG_GAMEPORT)		+= input/gameport/
-obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_RTC_LIB)		+= rtc/
 obj-$(CONFIG_I2C)		+= i2c/
