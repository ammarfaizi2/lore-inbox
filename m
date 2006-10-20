Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946843AbWJTCkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946843AbWJTCkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946844AbWJTCkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:40:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32123 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946843AbWJTCkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:40:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=p2DtmM3U2ZOYC1QRij5DE/iawNHs0IVTwOljpa4MzQne2EP3Yt2Y949etUyvVrbNeOFSjijgIPV7d5UA9g0RTtDKJzTHa0t5RJc4duml4q2rthFEhBotlWbLkq44Wam2DTHzee5dtHv/tOf5u5W7ppuyhne0edLEQthTnjyOHM8=
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: [PATCH] Fixed stv0299 driver to use time_after instead of comparisons
Date: Thu, 19 Oct 2006 19:40:21 -0700
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610191940.21559.karhudever@gmial.com>
From: David KOENIG <karhudever@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 914ba26e82ade62ca88ffa986fc06b4c0fb7a215 Mon Sep 17 00:00:00 2001
From: David KOENIG <karhudever@gmail.com>
Date: Thu, 19 Oct 2006 19:38:26 -0700
Subject: [PATCH] Fixed stv0299 driver to use time_after instead of comparisons
---
 drivers/media/dvb/frontends/stv0299.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb/frontends/stv0299.c 
b/drivers/media/dvb/frontends/stv0299.c
index 9348376..ff4da5a 100644
--- a/drivers/media/dvb/frontends/stv0299.c
+++ b/drivers/media/dvb/frontends/stv0299.c
@@ -43,6 +43,7 @@
 */
 
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -193,7 +194,7 @@ static int stv0299_wait_diseqc_fifo (str
 	dprintk ("%s\n", __FUNCTION__);
 
 	while (stv0299_readreg(state, 0x0a) & 1) {
-		if (jiffies - start > timeout) {
+		if (time_after(jiffies, start + timeout)) {
 			dprintk ("%s: timeout!!\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
@@ -210,7 +211,7 @@ static int stv0299_wait_diseqc_idle (str
 	dprintk ("%s\n", __FUNCTION__);
 
 	while ((stv0299_readreg(state, 0x0a) & 3) != 2 ) {
-		if (jiffies - start > timeout) {
+		if (time_after(jiffies, start + timeout)) {
 			dprintk ("%s: timeout!!\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
-- 
1.4.1


-- 
<>< karhudever@gmail.com
