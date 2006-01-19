Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWASRwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWASRwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWASRwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:52:32 -0500
Received: from webapps.arcom.com ([194.200.159.168]:41231 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1161049AbWASRwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:52:31 -0500
Message-ID: <43CFD1DB.4010900@arcom.com>
Date: Thu, 19 Jan 2006 17:52:27 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch 1/2] driver core: platform_get_irq*(): return -ENXIO on error
References: <43BD534E.8050701@arcom.com> <20060105173717.GA11279@suse.de> <43BD5F5E.1070108@arcom.com> <20060105180815.GB13317@suse.de> <43CFD12F.2070900@cantab.net>
In-Reply-To: <43CFD12F.2070900@cantab.net>
Content-Type: multipart/mixed;
 boundary="------------040806000401080206010409"
X-OriginalArrivalTime: 19 Jan 2006 17:56:39.0640 (UTC) FILETIME=[B2BB8D80:01C61D21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040806000401080206010409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
platforms, return -ENXIO instead.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------040806000401080206010409
Content-Type: text/plain;
 name="platform_get_irq-return-error"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="platform_get_irq-return-error"

Index: linux-2.6-working/drivers/base/platform.c
===================================================================
--- linux-2.6-working.orig/drivers/base/platform.c	2006-01-05 16:49:23.000000000 +0000
+++ linux-2.6-working/drivers/base/platform.c	2006-01-05 17:10:18.000000000 +0000
@@ -59,7 +59,7 @@
 {
 	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 
-	return r ? r->start : 0;
+	return r ? r->start : -ENXIO;
 }
 
 /**
@@ -94,7 +94,7 @@
 {
 	struct resource *r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
 
-	return r ? r->start : 0;
+	return r ? r->start : -ENXIO;
 }
 
 /**

--------------040806000401080206010409--
