Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVKAIPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVKAIPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVKAIO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:14:57 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:64596 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964980AbVKAIOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:41 -0500
Message-ID: <436723C8.7050300@m1k.net>
Date: Tue, 01 Nov 2005 03:14:00 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 15/37] dvb: dst: remove redundant checksum calculation
Content-Type: multipart/mixed;
 boundary="------------020401090304050907090707"
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
--------------020401090304050907090707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------020401090304050907090707
Content-Type: text/x-patch;
 name="2378.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2378.patch"

From: Perceval Anichini <perceval.anichini@streamvision.fr>

 - removes the redundant checksum calculation, which was also exported from the dst.c module

Signed-off-by: Perceval Anichini <perceval.anichini@streamvision.fr>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst_ca.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst_ca.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst_ca.c
@@ -69,26 +69,12 @@
 }
 
 
-static int put_checksum(u8 *check_string, int length)
+static void put_checksum(u8 *check_string, int length)
 {
-	u8 i = 0, checksum = 0;
-
-	dprintk(verbose, DST_CA_DEBUG, 1, " ========================= Checksum calculation ===========================");
-	dprintk(verbose, DST_CA_DEBUG, 1, " String Length=[0x%02x]", length);
-	dprintk(verbose, DST_CA_DEBUG, 1, " String=[");
-
-	while (i < length) {
-		dprintk(verbose, DST_CA_DEBUG, 0, " %02x", check_string[i]);
-		checksum += check_string[i];
-		i++;
-	}
-	dprintk(verbose, DST_CA_DEBUG, 0, " ]\n");
-	dprintk(verbose, DST_CA_DEBUG, 1, "Sum=[%02x]\n", checksum);
-	check_string[length] = ~checksum + 1;
-	dprintk(verbose, DST_CA_DEBUG, 1, " Checksum=[%02x]", check_string[length]);
-	dprintk(verbose, DST_CA_DEBUG, 1, " ==========================================================================");
-
-	return 0;
+	dprintk(verbose, DST_CA_DEBUG, 1, " Computing string checksum.");
+	dprintk(verbose, DST_CA_DEBUG, 1, "  -> string length : 0x%02x", length);
+	check_string[length] = dst_check_sum (check_string, length);
+	dprintk(verbose, DST_CA_DEBUG, 1, "  -> checksum      : 0x%02x", check_string[length]);
 }
 
 static int dst_ci_command(struct dst_state* state, u8 * data, u8 *ca_string, u8 len, int read)


--------------020401090304050907090707--
