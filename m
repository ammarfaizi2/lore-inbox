Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVIJVAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVIJVAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVIJVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:00:14 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:64525 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932302AbVIJVAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:00:13 -0400
Date: Sat, 10 Sep 2005 23:00:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>, Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [PATCH 2.6] hwmon: via686a: save 0.5k by long v[256] -> s16
 v[256]
Message-Id: <20050910230046.724a3132.khali@linux-fr.org>
In-Reply-To: <20050909213250.GA29011@kroah.com>
References: <200509010910.14824.vda@ilport.com.ua>
	<20050901155915.GB1235@kroah.com>
	<200509020854.37192.vda@ilport.com.ua>
	<20050903102227.03312247.khali@linux-fr.org>
	<20050903161331.1c76153d.khali@linux-fr.org>
	<20050909213250.GA29011@kroah.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Unfortunatly, no one noticed that this patch adds a build warning :(

I'm sorry about that, I though I had checked but now it seems not. A new
patch addressing the issue follows.

Thanks.

----------------------

We can save 0.5kB of data in the via686a driver.

From: Denis Vlasenko <vda@ilport.com.ua>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/via686a.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.13-git7.orig/drivers/hwmon/via686a.c	2005-09-08 22:40:16.000000000 +0200
+++ linux-2.6.13-git7/drivers/hwmon/via686a.c	2005-09-10 10:56:12.000000000 +0200
@@ -198,7 +198,7 @@
  but the function is very linear in the useful range (0-80 deg C), so
  we'll just use linear interpolation for 10-bit readings.)  So, tempLUT
  is the temp at via register values 0-255: */
-static const long tempLUT[] =
+static const s16 tempLUT[] =
 { -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
 	-503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
 	-362, -350, -339, -327, -316, -305, -295, -285, -275, -265,
@@ -270,7 +270,7 @@
 }
 
 /* for 8-bit temperature hyst and over registers */
-#define TEMP_FROM_REG(val) (tempLUT[(val)] * 100)
+#define TEMP_FROM_REG(val)	((long)tempLUT[val] * 100)
 
 /* for 10-bit temperature readings */
 static inline long TEMP_FROM_REG10(u16 val)


-- 
Jean Delvare
