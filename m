Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVAZINQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVAZINQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVAZINQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:13:16 -0500
Received: from relay.unizar.es ([155.210.11.72]:3014 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S262389AbVAZINF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:13:05 -0500
From: Jorge Bernal <koke@amedias.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] therm_adt746x: smooth fan
Date: Wed, 26 Jan 2005 09:12:26 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501260912.27216.koke@amedias.org>
X-Mail-Scanned: Criba 2.0 + Clamd en Unizar
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

This patchs allows a smoother fan speed switching with therm_adt746x. Instead 
of setting 0 or 128, it scales speed according to temperature.

It would be even better if I'd have more precise temp data, but I'm not sure 
if it's even supported by the chip.

--- linux-source-2.6.9.orig/drivers/macintosh/therm_adt746x.c 2005-01-26 02:50:31.941528728 +0100
+++ linux-source-2.6.9/drivers/macintosh/therm_adt746x.c 2005-01-26 03:10:36.925343344 +0100
@@ -272,7 +272,10 @@
       printk(KERN_INFO "adt746x: Limit exceeded by %d, setting speed to specified for %s.\n",
        var, fan_number?"GPU":"CPU");     
      th->overriding[fan_number] = 0;
-     write_fan_speed(th, fan_speed, fan_number);
+     if ((var > 2) && (var < 8))
+      write_fan_speed(th, (int)(fan_speed * var / 6), fan_number);
+     else
+      write_fan_speed(th, fan_speed, fan_number);
      started = 1;
     } else if (var < -1) {
      /
