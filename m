Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbVICONJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVICONJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 10:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVICONI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 10:13:08 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:47632 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751456AbVICONI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 10:13:08 -0400
Date: Sat, 3 Sep 2005 16:13:31 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: [PATCH 2.6] hwmon: via686a: save 0.5k by long v[256] -> s16 v[256]
Message-Id: <20050903161331.1c76153d.khali@linux-fr.org>
In-Reply-To: <20050903102227.03312247.khali@linux-fr.org>
References: <200509010910.14824.vda@ilport.com.ua>
	<20050901155915.GB1235@kroah.com>
	<200509020854.37192.vda@ilport.com.ua>
	<20050903102227.03312247.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

> This patch doesn't apply on top of my stack, first because the
> hardware monitoring drivers have been moved to drivers/hwmon, second
> because the via686a driver had indentation cleanups since 2.6.12.
> 
> Could you please provide this patch against 2.6.13-mm1?

On Denis' request, I have done that myself.

------

We can save 0.5kB of data in the via686a driver.

From: Denis Vlasenko <vda@ilport.com.ua>
Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/via686a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13.orig/drivers/hwmon/via686a.c	2005-08-29 20:54:28.000000000 +0200
+++ linux-2.6.13/drivers/hwmon/via686a.c	2005-09-03 16:05:14.000000000 +0200
@@ -198,7 +198,7 @@
  but the function is very linear in the useful range (0-80 deg C), so
  we'll just use linear interpolation for 10-bit readings.)  So, tempLUT
  is the temp at via register values 0-255: */
-static const long tempLUT[] =
+static const s16 tempLUT[] =
 { -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
 	-503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
 	-362, -350, -339, -327, -316, -305, -295, -285, -275, -265,

-- 
Jean Delvare
