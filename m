Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVKAIYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVKAIYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbVKAIWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:22:11 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:55752 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965039AbVKAIPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:15:15 -0500
Message-ID: <436723F0.5060902@m1k.net>
Date: Tue, 01 Nov 2005 03:14:40 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 20/37] dvb: Remove DEBUG_LOCKLOSS stuff
Content-Type: multipart/mixed;
 boundary="------------010502000409060507070609"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502000409060507070609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------010502000409060507070609
Content-Type: text/x-patch;
 name="2389.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2389.patch"

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Remove DEBUG_LOCKLOSS stuff - as the problem has been found and resolved

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_frontend.c |   21 ---------------------
 1 file changed, 21 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -42,8 +42,6 @@
 #include "dvb_frontend.h"
 #include "dvbdev.h"
 
-// #define DEBUG_LOCKLOSS 1
-
 static int dvb_frontend_debug;
 static int dvb_shutdown_timeout = 5;
 static int dvb_force_auto_inversion;
@@ -438,25 +436,6 @@
 			if (s & FE_HAS_LOCK)
 				continue;
 			else { /* if we _WERE_ tuned, but now don't have a lock */
-#ifdef DEBUG_LOCKLOSS
-				/* first of all try setting the tone again if it was on - this
-				 * sometimes works around problems with noisy power supplies */
-				if (fe->ops->set_tone && (fepriv->tone == SEC_TONE_ON)) {
-					fe->ops->set_tone(fe, fepriv->tone);
-					mdelay(100);
-					s = 0;
-					fe->ops->read_status(fe, &s);
-					if (s & FE_HAS_LOCK) {
-						printk("DVB%i: Lock was lost, but regained by setting "
-						       "the tone. This may indicate your power supply "
-						       "is noisy/slightly incompatable with this DVB-S "
-						       "adapter\n", fe->dvb->num);
-						fepriv->state = FESTATE_TUNED;
-						continue;
-					}
-				}
-#endif
-				/* some other reason for losing the lock - start zigzagging */
 				fepriv->state = FESTATE_ZIGZAG_FAST;
 				fepriv->started_auto_step = fepriv->auto_step;
 				check_wrapped = 0;


--------------010502000409060507070609--
