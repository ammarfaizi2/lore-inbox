Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWJAKxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWJAKxX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWJAKxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:53:15 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:11165 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751576AbWJAKwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:52:50 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@neptun.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 12/13] kconfig: fix saving alternate kconfig file in parent dir
Reply-To: sam@ravnborg.org
Date: Sun, 01 Oct 2006 12:52:45 +0200
Message-Id: <11596999682904-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11596999683256-git-send-email-sam@ravnborg.org>
References: <1159699966691-git-send-email-sam@ravnborg.org> <1159699967600-git-send-email-sam@ravnborg.org> <11596999673562-git-send-email-sam@ravnborg.org> <115969996719-git-send-email-sam@ravnborg.org> <11596999673039-git-send-email-sam@ravnborg.org> <11596999672694-git-send-email-sam@ravnborg.org> <11596999673444-git-send-email-sam@ravnborg.org> <11596999672988-git-send-email-sam@ravnborg.org> <1159699967673-git-send-email-sam@ravnborg.org> <115969996811-git-send-email-sam@ravnborg.org> <11596999683256-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@neptun.ravnborg.org>

This fixes bugzilla entry: 7182
http://bugzilla.kernel.org/show_bug.cgi?id=7182

With this patch we no longer append the directory part twice
before saving the config file.
This patch has been sent to Roman Zippel for review with no feedback.
It is so obviously simple that this should be OK to apply it anyway.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/confdata.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 69f96b3..66b15ef 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -517,7 +517,7 @@ int conf_write(const char *name)
 	fclose(out);
 
 	if (*tmpname) {
-		strcat(dirname, name ? name : conf_get_configname());
+		strcat(dirname, basename);
 		strcat(dirname, ".old");
 		rename(newname, dirname);
 		if (rename(tmpname, newname))
-- 
1.4.1

