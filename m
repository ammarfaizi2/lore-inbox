Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWG2HUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWG2HUi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWG2HUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:20:37 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:56499 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422685AbWG2HUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:20:07 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <matthew@wil.cx>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kconfig: support DOS line endings
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:40 +0200
Message-Id: <11541575811222-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <11541575811046-git-send-email-sam@ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <11541575813716-git-send-email-sam@ravnborg.org> <11541575811267-git-send-email-sam@ravnborg.org> <1154157581409-git-send-email-sam@ravnborg.org> <11541575813138-git-send-email-sam@ravnborg.org> <11541575811787-git-send-email-sam@ravnborg.org> <11541575811046-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <matthew@wil.cx>

Kconfig doesn't currently handle config files with DOS line endings.
While these are, of course, an abomination, etc, etc, it can be handy
to not have to convert them first.  It's also a tiny patch and even adds
support for lines ending in just \r or even \n\r.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/confdata.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index a69d8ac..69f96b3 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -193,8 +193,11 @@ load:
 				continue;
 			*p++ = 0;
 			p2 = strchr(p, '\n');
-			if (p2)
-				*p2 = 0;
+			if (p2) {
+				*p2-- = 0;
+				if (*p2 == '\r')
+					*p2 = 0;
+			}
 			if (def == S_DEF_USER) {
 				sym = sym_find(line + 7);
 				if (!sym) {
@@ -266,6 +269,7 @@ load:
 				;
 			}
 			break;
+		case '\r':
 		case '\n':
 			break;
 		default:
-- 
1.4.1.rc2.gfc04

