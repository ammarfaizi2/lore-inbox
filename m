Return-Path: <linux-kernel-owner+w=401wt.eu-S932183AbWLLKTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWLLKTW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWLLKTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:19:22 -0500
Received: from MAIL1.WPI.EDU ([130.215.36.91]:56580 "EHLO mail1.wpi.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932183AbWLLKTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:19:21 -0500
Message-ID: <49789.130.215.241.149.1165918756.squirrel@webmail.WPI.EDU>
Date: Tue, 12 Dec 2006 05:19:16 -0500 (EST)
Subject: [PATCH] asus_acpi: Add support for Asus Z81SP
From: mcc@WPI.EDU
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew C Campbell <calvinmc@gmail.com>

Adds support in asus_acpi for the Asus Z81SP laptop. This preserves all
old functionality when improperly detected as well as enabling Bluetooth
support.

Signed-off-by: Matthew C Campbell <calvinmc@gmail.com>
---
--- linux-source-2.6.19/drivers/acpi/asus_acpi.c.orig   2006-12-12
05:07:11.000000000 -0500
+++ linux-source-2.6.19/drivers/acpi/asus_acpi.c        2006-12-12
04:56:05.000000000 -0500
@@ -140,6 +140,7 @@ struct asus_hotk {
                W5A,            //W5A
                W3V,            //W3030V
                xxN,            //M2400N, M3700N, M5200N, M6800N, S1300N,
S5200N
+               A4S,            //Z81sp
                //(Centrino)
                END_MODEL
        } model;                //Models currently supported
@@ -396,7 +397,16 @@ static struct model_data model_conf[END_
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
         .display_set = "SDSP",
-        .display_get = "\\ADVG"}
+        .display_get = "\\ADVG"},
+
+        {
+                .name              = "A4S",
+                .brightness_set    = "SPLV",
+                .brightness_get    = "GPLV",
+                .mt_bt_switch      = "BLED",
+                .mt_wled           = "WLED"
+        }
+
 };

 /* procdir we use */
@@ -1105,6 +1115,8 @@ static int asus_model_match(char *model)
                return W3V;
        else if (strncmp(model, "W5A", 3) == 0)
                return W5A;
+       else if (strncmp(model, "A4S", 3) == 0)
+               return A4S;
        else
                return END_MODEL;
 }

