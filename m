Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVKAIRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVKAIRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVKAIRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:17:22 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:63602 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965068AbVKAIQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:16:42 -0500
Message-ID: <43672443.9050106@m1k.net>
Date: Tue, 01 Nov 2005 03:16:03 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 31/37] dvb: nxt200x: check callback fix
Content-Type: multipart/mixed;
 boundary="------------000307060204060609000508"
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
--------------000307060204060609000508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------000307060204060609000508
Content-Type: text/x-patch;
 name="2408.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2408.patch"

Check that a callback (set_ts_params) is set before calling it.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 drivers/media/dvb/frontends/nxt200x.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/nxt200x.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/nxt200x.c
@@ -557,14 +557,16 @@
 		case QAM_256:
 			/* Set punctured clock for QAM */
 			/* This is just a guess since I am unable to test it */
-			state->config->set_ts_params(fe, 1);
+			if (state->config->set_ts_params)
+				state->config->set_ts_params(fe, 1);
 
 			/* set to use cable input */
 			buf[3] |= 0x08;
 			break;
 		case VSB_8:
 			/* Set non-punctured clock for VSB */
-			state->config->set_ts_params(fe, 0);
+			if (state->config->set_ts_params)
+				state->config->set_ts_params(fe, 0);
 			break;
 		default:
 			return -EINVAL;


--------------000307060204060609000508--
