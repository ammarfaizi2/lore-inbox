Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbTL3Ivl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 03:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbTL3Ivl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 03:51:41 -0500
Received: from maverick.eskuel.net ([81.56.212.215]:58095 "EHLO
	maverick.eskuel.net") by vger.kernel.org with ESMTP id S265697AbTL3Ivj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 03:51:39 -0500
Message-ID: <3FF13C99.1070005@eskuel.net>
Date: Tue, 30 Dec 2003 09:51:37 +0100
From: Mathieu LESNIAK <maverick@eskuel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031225 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] wrong mac address with netgear FA311 ethernet card]
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090204030605050304080907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090204030605050304080907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all !

This patch, against 2.6.0, corrects a problem with Netgear FA311
ethernet card (a cheap one). Without it, the MAC address is byte swapped
ie :
HWaddr 02:00:07:E3:E9:F5
instead of :
HWaddr 00:02:E3:07:F5:E9


(the correct MAC address vendor code for Netgear/LiteOn is 00:02:E3)

Thanks a lot,

Mathieu LESNIAK


--------------090204030605050304080907
Content-Type: text/x-patch;
 name="netgear_tulip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netgear_tulip.patch"

--- linux-2.6.0/drivers/net/tulip/tulip_core.c	2003-12-18 03:58:57.000000000 +0100
+++ /usr/src/linux-2.6.0/drivers/net/tulip/tulip_core.c	2003-12-21 16:05:22.000000000 +0100
@@ -1531,7 +1531,7 @@
 		}
 	}
 	/* Lite-On boards have the address byte-swapped. */
-	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0)
+	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0 || dev->dev_addr[0] == 0x02)
 		&&  dev->dev_addr[1] == 0x00)
 		for (i = 0; i < 6; i+=2) {
 			char tmp = dev->dev_addr[i];


--------------090204030605050304080907--
