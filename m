Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVKAIWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVKAIWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVKAIWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:22:19 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:65388 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964978AbVKAIOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:38 -0500
Message-ID: <436723C1.7010100@m1k.net>
Date: Tue, 01 Nov 2005 03:13:53 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 14/37] dvb: dst: fix DST DVB-S get_frequency
Content-Type: multipart/mixed;
 boundary="------------060104060308010203020204"
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
--------------060104060308010203020204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------060104060308010203020204
Content-Type: text/x-patch;
 name="2377.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2377.patch"

From: Tom Hughes <tom@compton.nu>

fix DST DVB-S get_frequency

 - fixes a bug that caused the returned frequency to wrong

Signed-off-by: Tom Hughes <tom@compton.nu>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst.c
@@ -1092,7 +1092,13 @@
 	}
 	if (state->rx_tuna[2] == 0 && state->rx_tuna[3] == 0)
 		return 0;
-	state->decode_freq = ((state->rx_tuna[2] & 0x7f) << 8) + state->rx_tuna[3];
+
+	if (state->dst_type == DST_TYPE_IS_SAT) {
+		state->decode_freq = ((state->rx_tuna[2] & 0x7f) << 8) + state->rx_tuna[3];
+	} else {
+		state->decode_freq = ((state->rx_tuna[2] & 0x7f) << 16) + (state->rx_tuna[3] << 8) + state->rx_tuna[4];
+	}
+	state->decode_freq = state->decode_freq * 1000;
 	state->decode_lock = 1;
 	state->diseq_flags |= HAS_LOCK;
 


--------------060104060308010203020204--
