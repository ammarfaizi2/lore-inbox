Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWAERLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWAERLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWAERLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:11:53 -0500
Received: from webapps.arcom.com ([194.200.159.168]:54279 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751848AbWAERLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:11:52 -0500
Message-ID: <43BD534E.8050701@arcom.com>
Date: Thu, 05 Jan 2006 17:11:42 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: gregkh@suse.de, Russell King <rmk@arm.linux.org.uk>
Subject: [DRIVER CORE] platform_get_irq*(): return NO_IRQ on error
Content-Type: multipart/mixed;
 boundary="------------010502080602060205050102"
X-OriginalArrivalTime: 05 Jan 2006 17:15:22.0093 (UTC) FILETIME=[9C3761D0:01C6121B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502080602060205050102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
platforms, return NO_IRQ (-1) instead.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------010502080602060205050102
Content-Type: text/plain;
 name="platform_get_irq-return-NO_IRQ"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="platform_get_irq-return-NO_IRQ"

Index: linux-2.6-working/drivers/base/platform.c
===================================================================
--- linux-2.6-working.orig/drivers/base/platform.c	2006-01-05 16:49:23.000000000 +0000
+++ linux-2.6-working/drivers/base/platform.c	2006-01-05 17:10:18.000000000 +0000
@@ -59,7 +59,7 @@
 {
 	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 
-	return r ? r->start : 0;
+	return r ? r->start : NO_IRQ;
 }
 
 /**
@@ -94,7 +94,7 @@
 {
 	struct resource *r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
 
-	return r ? r->start : 0;
+	return r ? r->start : NO_IRQ;
 }
 
 /**

--------------010502080602060205050102--
