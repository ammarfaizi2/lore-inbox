Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVF0MQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVF0MQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVF0MQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:16:43 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:62180 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261197AbVF0MPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:15:52 -0400
Message-Id: <20050627121412.298702000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:14 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-stv0297-qam128.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 14/51] DVB update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase some timeouts by a factor of 10 as suggested by
Mikko Hamalainen and Timo Ketolainen, to improve tuning
for QAM128 / weak signal.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/stv0297.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/stv0297.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/stv0297.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/stv0297.c	2005-06-27 13:23:08.000000000 +0200
@@ -617,7 +617,7 @@ static int stv0297_set_frontend(struct d
 
 	/* wait for WGAGC lock */
 	starttime = jiffies;
-	timeout = jiffies + (200 * HZ) / 1000;
+	timeout = jiffies + msecs_to_jiffies(2000);
 	while (time_before(jiffies, timeout)) {
 		msleep(10);
 		if (stv0297_readreg(state, 0x43) & 0x08)
@@ -629,7 +629,7 @@ static int stv0297_set_frontend(struct d
 	msleep(20);
 
 	/* wait for equaliser partial convergence */
-	timeout = jiffies + (50 * HZ) / 1000;
+	timeout = jiffies + msecs_to_jiffies(500);
 	while (time_before(jiffies, timeout)) {
 		msleep(10);
 
@@ -642,7 +642,7 @@ static int stv0297_set_frontend(struct d
 	}
 
 	/* wait for equaliser full convergence */
-	timeout = jiffies + (delay * HZ) / 1000;
+	timeout = jiffies + msecs_to_jiffies(delay);
 	while (time_before(jiffies, timeout)) {
 		msleep(10);
 
@@ -659,7 +659,7 @@ static int stv0297_set_frontend(struct d
 	stv0297_writereg_mask(state, 0x88, 8, 0);
 
 	/* wait for main lock */
-	timeout = jiffies + (20 * HZ) / 1000;
+	timeout = jiffies + msecs_to_jiffies(20);
 	while (time_before(jiffies, timeout)) {
 		msleep(10);
 

--

