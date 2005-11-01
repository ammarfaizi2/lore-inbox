Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVKAIVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVKAIVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbVKAIUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:20:08 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:24722 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965069AbVKAIRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:17:07 -0500
Message-ID: <4367245F.9080502@m1k.net>
Date: Tue, 01 Nov 2005 03:16:31 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 35/37] dvb: Remove status check from nxt200x_readreg_multibyte
Content-Type: multipart/mixed;
 boundary="------------090502090500000605080200"
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
--------------090502090500000605080200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------090502090500000605080200
Content-Type: text/x-patch;
 name="2413.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2413.patch"

From: Kirk Lapray <kirk.lapray@gmail.com>

- Remove status check from nxt200x_readreg_multibyte,
  it really shouldn't be necessary.

Signed-off-by: Kirk Lapray <kirk.lapray@gmail.com>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 drivers/media/dvb/frontends/nxt200x.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/nxt200x.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/nxt200x.c
@@ -239,26 +239,16 @@
 			buf = 0x80;
 			nxt200x_writebytes(state, 0x21, &buf, 1);
 
-			/* read status */
-			nxt200x_readbytes(state, 0x21, &buf, 1);
-
-			if (buf == 0)
-			{
-				/* read the actual data */
-				for(i = 0; i < len; i++) {
-                    nxt200x_readbytes(state, 0x36 + i, &data[i], 1);
-				}
-				return 0;
+			/* read the actual data */
+			for(i = 0; i < len; i++) {
+				nxt200x_readbytes(state, 0x36 + i, &data[i], 1);
 			}
+			return 0;
 			break;
 		default:
 			return -EINVAL;
 			break;
 	}
-
-	printk(KERN_WARNING "nxt200x: Error reading multireg register 0x%02X\n",reg);
-
-	return 0;
 }
 
 static void nxt200x_microcontroller_stop (struct nxt200x_state* state)


--------------090502090500000605080200--
