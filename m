Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUBENnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUBENnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:43:40 -0500
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:41164 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S265264AbUBENnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:43:05 -0500
Date: Thu, 5 Feb 2004 14:43:03 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.{46}] Add P1/P2 programmable keys to the sonypi driver.
Message-ID: <20040205134303.GH13492@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch enables sonypi to successfully report P1/P2 programmable keys
events on Sony Vaio Z1 laptops.

Note however that sonypi is unable to distinguish between the two events,
both of them will be reported as SONYPI_EVENT_PKEY_P1, but one event is 
better than zero, so there it is.

The patch applies cleanly on either 2.4 or 2.6 kernels.

Thanks,

Stelian.

===== drivers/char/sonypi.h 1.19 vs edited =====
--- 1.19/drivers/char/sonypi.h	Fri Oct 24 23:13:49 2003
+++ edited/drivers/char/sonypi.h	Thu Feb  5 11:52:27 2004
@@ -239,6 +239,7 @@
 	{ 0x01, SONYPI_EVENT_PKEY_P1 },
 	{ 0x02, SONYPI_EVENT_PKEY_P2 },
 	{ 0x04, SONYPI_EVENT_PKEY_P3 },
+	{ 0x5c, SONYPI_EVENT_PKEY_P1 },
 	{ 0, 0 }
 };
 
@@ -333,6 +334,7 @@
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
 
 	{ 0, 0, 0, 0 }
 };
-- 
Stelian Pop <stelian@popies.net>
