Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVKAIWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVKAIWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVKAIOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:14:54 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:33772 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965038AbVKAIOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:46 -0500
Message-ID: <436723CE.9060803@m1k.net>
Date: Tue, 01 Nov 2005 03:14:06 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 16/37] dvb: dst: Fix possible buffer overflow
Content-Type: multipart/mixed;
 boundary="------------000007050900090202010705"
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
--------------000007050900090202010705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------000007050900090202010705
Content-Type: text/x-patch;
 name="2379.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2379.patch"

From: Manu Abraham <manu@linuxtv.org>

 - Fixes a possible buffer overflow due to reading more than 8 bytes into an 8 byte long array

Thanks to Perceval Anichini <perceval.anichini@streamvision.fr> for pointing out the bug.

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst_ca.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst_ca.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst_ca.c
@@ -196,7 +196,7 @@
 	int i;
 	static u8 slot_command[8] = {0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff};
 
-	u8 *slot_info = state->rxbuffer;
+	u8 *slot_info = state->messages;
 
 	put_checksum(&slot_command[0], 7);
 	if ((dst_put_ci(state, slot_command, sizeof (slot_command), slot_info, GET_REPLY)) < 0) {



--------------000007050900090202010705--
