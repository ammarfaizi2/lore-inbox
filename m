Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWG2HVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWG2HVI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWG2HUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:20:39 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:54707 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422690AbWG2HUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:20:01 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kconfig: correct oldconfig for unset choice options
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:39 +0200
Message-Id: <11541575811046-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <11541575811787-git-send-email-sam@ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <11541575813716-git-send-email-sam@ravnborg.org> <11541575811267-git-send-email-sam@ravnborg.org> <1154157581409-git-send-email-sam@ravnborg.org> <11541575813138-git-send-email-sam@ravnborg.org> <11541575811787-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>

oldconfig currently ignores unset choice options and doesn't ask for them.
Correct the SYMBOL_DEF_USER flag of the choice symbol to be only set if
it's set for all values.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/confdata.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 2ee48c3..a69d8ac 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -357,7 +357,7 @@ int conf_read(const char *name)
 		for (e = prop->expr; e; e = e->left.expr)
 			if (e->right.sym->visible != no)
 				flags &= e->right.sym->flags;
-		sym->flags |= flags & SYMBOL_DEF_USER;
+		sym->flags &= flags | ~SYMBOL_DEF_USER;
 	}
 
 	sym_change_count += conf_warnings || conf_unsaved;
-- 
1.4.1.rc2.gfc04

