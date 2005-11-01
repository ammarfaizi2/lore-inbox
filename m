Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVKAIWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVKAIWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVKAIOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:14:37 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:16612 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965018AbVKAIO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:28 -0500
Message-ID: <436723BB.9010809@m1k.net>
Date: Tue, 01 Nov 2005 03:13:47 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 13/37] dvb: dst: fix broken support for vp-3040 TS204
Content-Type: multipart/mixed;
 boundary="------------040708040609010604030208"
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
--------------040708040609010604030208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------040708040609010604030208
Content-Type: text/x-patch;
 name="2376.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2376.patch"

From: Manu Abraham <manu@linuxtv.org>

 - fixes broken support for vp-3040 TS204

Thanks to: Lee Hammerton <savoury.snax@bulldoghome.com>
Signed-off-by: Manu Abraham <manu@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst.c
@@ -905,10 +905,6 @@
 	state->dst_type = use_dst_type;
 	dst_type_flags_print(state->type_flags);
 
-	if (state->type_flags & DST_TYPE_HAS_TS204) {
-		dst_packsize(state, 204);
-	}
-
 	return 0;
 }
 
@@ -940,6 +936,9 @@
 		if (dst_get_tuner_info(state) < 0)
 			dprintk(verbose, DST_INFO, 1, "Tuner: Unsupported command");
 	}
+	if (state->type_flags & DST_TYPE_HAS_TS204) {
+		dst_packsize(state, 204);
+	}
 	if (state->type_flags & DST_TYPE_HAS_FW_BUILD) {
 		if (dst_fw_ver(state) < 0) {
 			dprintk(verbose, DST_INFO, 1, "FW: Unsupported command");


--------------040708040609010604030208--
