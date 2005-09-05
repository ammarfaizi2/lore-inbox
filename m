Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVIESeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVIESeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVIESdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:33:11 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:64867 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932383AbVIESdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:33:01 -0400
Message-Id: <20050905183246.054868000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:13 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 04/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-fix-ieee1284.3-daisy-device-opening-to-open-existing-devices.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Device ID reading from daisy chain devices failed because the daisy
device could not be opened.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

Index: linux-dvb/drivers/parport/daisy.c
===================================================================
--- linux-dvb.orig/drivers/parport/daisy.c	2005-08-29 20:16:48.000000000 +0300
+++ linux-dvb/drivers/parport/daisy.c	2005-08-29 20:17:06.000000000 +0300
@@ -252,7 +252,7 @@ struct pardevice *parport_open (int devn
 		selected = port->daisy;
 		parport_release (dev);
 
-		if (selected != port->daisy) {
+		if (selected != daisy) {
 			/* No corresponding device. */
 			parport_unregister_device (dev);
 			return NULL;

--
