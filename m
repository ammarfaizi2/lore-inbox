Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUDNS0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUDNS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:26:47 -0400
Received: from winds.org ([68.75.195.9]:12948 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S261416AbUDNS0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:26:44 -0400
Date: Wed, 14 Apr 2004 14:25:47 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: marcelo@hera.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [2.4.26 Patch] Blue line in nVidia framebuffer (rivafb)
Message-ID: <Pine.LNX.4.58.0404141415350.12872@winds.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1262750147-1363533184-1081967147=:12872"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1262750147-1363533184-1081967147=:12872
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch fixes a regression since Linux 2.4.21. There is an off-by-one error
with the vertical-blank register in the riva framebuffer driver. The error
makes a persistent scan line (normally blue) appear on the top of the screen.

Marcelo, please include this patch in the next -pre series.

Thanks,
 Byron


--- linux-2.4.26/drivers/video/riva/fbdev.bak	Wed Apr 14 11:45:26 2004
+++ linux-2.4.26/drivers/video/riva/fbdev.c	Wed Apr 14 14:15:22 2004
@@ -952,7 +952,7 @@
 	newmode.crtc[0x12] = Set8Bits (vDisplay);
 	newmode.crtc[0x13] = ((width / 8) * ((bpp + 1) / 8)) & 0xFF;
 	newmode.crtc[0x15] = Set8Bits (vBlankStart);
-	newmode.crtc[0x16] = Set8Bits (vBlankEnd);
+	newmode.crtc[0x16] = Set8Bits (vBlankEnd + 1);

 	newmode.ext.bpp = bpp;
 	newmode.ext.width = width;



--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
--1262750147-1363533184-1081967147=:12872
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fb.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0404141425470.12872@winds.org>
Content-Description: 
Content-Disposition: attachment; filename="fb.diff"

LS0tIGxpbnV4LTIuNC4yNi9kcml2ZXJzL3ZpZGVvL3JpdmEvZmJkZXYuYmFr
CVdlZCBBcHIgMTQgMTE6NDU6MjYgMjAwNA0KKysrIGxpbnV4LTIuNC4yNi9k
cml2ZXJzL3ZpZGVvL3JpdmEvZmJkZXYuYwlXZWQgQXByIDE0IDE0OjE1OjIy
IDIwMDQNCkBAIC05NTIsNyArOTUyLDcgQEANCiAJbmV3bW9kZS5jcnRjWzB4
MTJdID0gU2V0OEJpdHMgKHZEaXNwbGF5KTsNCiAJbmV3bW9kZS5jcnRjWzB4
MTNdID0gKCh3aWR0aCAvIDgpICogKChicHAgKyAxKSAvIDgpKSAmIDB4RkY7
DQogCW5ld21vZGUuY3J0Y1sweDE1XSA9IFNldDhCaXRzICh2QmxhbmtTdGFy
dCk7DQotCW5ld21vZGUuY3J0Y1sweDE2XSA9IFNldDhCaXRzICh2QmxhbmtF
bmQpOw0KKwluZXdtb2RlLmNydGNbMHgxNl0gPSBTZXQ4Qml0cyAodkJsYW5r
RW5kICsgMSk7DQogDQogCW5ld21vZGUuZXh0LmJwcCA9IGJwcDsNCiAJbmV3
bW9kZS5leHQud2lkdGggPSB3aWR0aDsNCg==

--1262750147-1363533184-1081967147=:12872--
