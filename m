Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUBBUnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUBBT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:59:45 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:21133 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265916AbUBBT6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:58:48 -0500
Date: Mon, 2 Feb 2004 20:58:47 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 29/42]
Message-ID: <20040202195847.GC6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


matroxfb_g450.c:134: warning: duplicate `const'
matroxfb_g450.c:135: warning: duplicate `const'
matroxfb_g450.c:561: warning: unused variable `minfo'
matroxfb_maven.c:359: warning: duplicate `const'
matroxfb_maven.c:360: warning: duplicate `const'

Remove const qualifier, it's useless.
Remove unused variable.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/video/matrox/matroxfb_g450.c linux-2.4/drivers/video/matrox/matroxfb_g450.c
--- linux-2.4-vanilla/drivers/video/matrox/matroxfb_g450.c	Fri Jun 13 16:51:37 2003
+++ linux-2.4/drivers/video/matrox/matroxfb_g450.c	Sat Jan 31 18:20:31 2004
@@ -128,8 +128,8 @@
 }
 
 static void g450_compute_bwlevel(CPMINFO int *bl, int *wl) {
-	const int b = ACCESS_FBINFO(altout.tvo_params.brightness) + BLMIN;
-	const int c = ACCESS_FBINFO(altout.tvo_params.contrast);
+	int b = ACCESS_FBINFO(altout.tvo_params.brightness) + BLMIN;
+	int c = ACCESS_FBINFO(altout.tvo_params.contrast);
 
 	*bl = max(b - c, BLMIN);
 	*wl = min(b + c, WLMAX);
@@ -558,8 +558,6 @@
 }
 
 static int matroxfb_g450_verify_mode(void* md, u_int32_t arg) {
-	MINFO_FROM(md);
-	
 	switch (arg) {
 		case MATROXFB_OUTPUT_MODE_PAL:
 		case MATROXFB_OUTPUT_MODE_NTSC:
diff -Nru -X dontdiff linux-2.4-vanilla/drivers/video/matrox/matroxfb_maven.c linux-2.4/drivers/video/matrox/matroxfb_maven.c
--- linux-2.4-vanilla/drivers/video/matrox/matroxfb_maven.c	Fri Jun 13 16:51:37 2003
+++ linux-2.4/drivers/video/matrox/matroxfb_maven.c	Sat Jan 31 18:20:47 2004
@@ -353,8 +353,8 @@
 
 static void maven_compute_bwlevel (const struct maven_data* md,
 				   int *bl, int *wl) {
-	const int b = md->primary_head->altout.tvo_params.brightness + BLMIN;
-	const int c = md->primary_head->altout.tvo_params.contrast;
+	int b = md->primary_head->altout.tvo_params.brightness + BLMIN;
+	int c = md->primary_head->altout.tvo_params.contrast;
 
 	*bl = max(b - c, BLMIN);
 	*wl = min(b + c, WLMAX);

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Una donna sposa un uomo sperando che cambi, e lui non cambiera`. Un
uomo sposa una donna sperando che non cambi, e lei cambiera`.
