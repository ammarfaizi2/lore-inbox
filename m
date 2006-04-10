Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWDJFuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWDJFuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWDJFuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:50:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63974 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751017AbWDJFuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:50:08 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-scsi@vger.kernel.org
Subject: Re: [PATCH] deinline some functions in aic7xxx drivers, save 80k of text
Date: Mon, 10 Apr 2006 08:49:37 +0300
User-Agent: KMail/1.8.2
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
References: <200604100844.12151.vda@ilport.com.ua>
In-Reply-To: <200604100844.12151.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xHfOE5YeiHnHSq5"
Message-Id: <200604100849.37943.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xHfOE5YeiHnHSq5
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 10 April 2006 08:44, Denis Vlasenko wrote:
> I also spotted two bugs in the process, patches
> for those will follow.

ahd_delay(usec) is buggy. Just think how would it work
with usec == 1024*100 + 1...

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_xHfOE5YeiHnHSq5
Content-Type: text/x-diff;
  charset="koi8-r";
  name="2.6.16.aic7_42.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.aic7_42.patch"

Fix yet another bug

diff -urpN linux-2.6.16.aic7_2/drivers/scsi/aic7xxx/aic79xx_osm_o.c linux-2.6.16.aic7_3/drivers/scsi/aic7xxx/aic79xx_osm_o.c
--- linux-2.6.16.aic7_2/drivers/scsi/aic7xxx/aic79xx_osm_o.c	Sun Apr  9 21:53:01 2006
+++ linux-2.6.16.aic7_3/drivers/scsi/aic7xxx/aic79xx_osm_o.c	Sun Apr  9 22:25:30 2006
@@ -28,9 +28,11 @@ ahd_delay(long usec)
 	 * multi-millisecond waits.  Wait at most
 	 * 1024us per call.
 	 */
+	udelay(usec & 1023);
+	usec >>= 10;
 	while (usec > 0) {
-		udelay(usec % 1024);
-		usec -= 1024;
+		udelay(1024);
+		usec--;
 	}
 }
 
diff -urpN linux-2.6.16.aic7_2/drivers/scsi/aic7xxx/aic7xxx_osm_o.c linux-2.6.16.aic7_3/drivers/scsi/aic7xxx/aic7xxx_osm_o.c
--- linux-2.6.16.aic7_2/drivers/scsi/aic7xxx/aic7xxx_osm_o.c	Sun Apr  9 21:54:39 2006
+++ linux-2.6.16.aic7_3/drivers/scsi/aic7xxx/aic7xxx_osm_o.c	Sun Apr  9 22:24:59 2006
@@ -14,9 +14,11 @@ ahc_delay(long usec)
 	 * multi-millisecond waits.  Wait at most
 	 * 1024us per call.
 	 */
+	udelay(usec & 1023);
+	usec >>= 10;
 	while (usec > 0) {
-		udelay(usec % 1024);
-		usec -= 1024;
+		udelay(1024);
+		usec--;
 	}
 }
 

--Boundary-00=_xHfOE5YeiHnHSq5--
