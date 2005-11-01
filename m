Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVKAI0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVKAI0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVKAIN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:13:56 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:606 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964976AbVKAINy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:13:54 -0500
Message-ID: <4367239F.30409@m1k.net>
Date: Tue, 01 Nov 2005 03:13:19 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 09/37] dvb: microtune mt7202dtf: Fix charge pump setting
Content-Type: multipart/mixed;
 boundary="------------090400030701020106080404"
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
--------------090400030701020106080404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------090400030701020106080404
Content-Type: text/x-patch;
 name="2372.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2372.patch"

Fix charge pump setting in microtune_mt7202dtf_pll_set().
Thanks to Jyrki Niskala for reporting.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -280,7 +280,7 @@
 	data[0] = (div >> 8) & 0x7f;
 	data[1] = div & 0xff;
 	data[2] = ((div >> 10) & 0x60) | cfg;
-	data[3] = cpump | band_select;
+	data[3] = (cpump << 6) | band_select;
 
 	i2c_transfer(card->i2c_adapter, &msg, 1);
 	return (div * 166666 - 36000000);


--------------090400030701020106080404--
