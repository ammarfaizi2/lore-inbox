Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWIXVNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWIXVNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWIXVNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:13 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:14044 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932109AbWIXVNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:09 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4/28] kbuild: replace use of strlcpy with a dedicated implmentation in unifdef
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:00 +0200
Message-Id: <11591327041272-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327042944-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/unifdef.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/scripts/unifdef.c b/scripts/unifdef.c
index 5384b43..552025e 100644
--- a/scripts/unifdef.c
+++ b/scripts/unifdef.c
@@ -450,7 +450,14 @@ ignoreon(void)
 static void
 keywordedit(const char *replacement)
 {
-	strlcpy(keyword, replacement, tline + sizeof(tline) - keyword);
+	size_t size = tline + sizeof(tline) - keyword;
+	char *dst = keyword;
+	const char *src = replacement;
+	if (size != 0) {
+		while ((--size != 0) && (*src != '\0'))
+			*dst++ = *src++;
+		*dst = '\0';
+	}
 	print();
 }
 static void
-- 
1.4.1

