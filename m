Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVIAGMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVIAGMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVIAGMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:12:02 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:53196 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964966AbVIAGMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:12:00 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: greg@kroah.com
Subject: i2c via686a.c: save at least 0.5k of space by long v[256] -> u16 v[256]
Date: Thu, 1 Sep 2005 09:10:14 +0300
User-Agent: KMail/1.8.2
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GtpFDFWwuowhVlY"
Message-Id: <200509010910.14824.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GtpFDFWwuowhVlY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Not tested, but it's rather obvious.
--
vda

--Boundary-00=_GtpFDFWwuowhVlY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="via686a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via686a.patch"

--- linux-2.6.12.src/drivers/i2c/chips/via686a.c.orig	Sun Jun 19 16:10:10 2005
+++ linux-2.6.12.src/drivers/i2c/chips/via686a.c	Tue Aug 30 00:21:39 2005
@@ -205,7 +205,7 @@ static inline u8 FAN_TO_REG(long rpm, in
  but the function is very linear in the useful range (0-80 deg C), so 
  we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
  is the temp at via register values 0-255: */
-static const long tempLUT[] =
+static const int16_t tempLUT[] =
     { -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
 	    -503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
 	    -362, -350, -339, -327, -316, -305, -295, -285, -275, -265,

--Boundary-00=_GtpFDFWwuowhVlY--
