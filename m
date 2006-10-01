Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWJAKwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWJAKwt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWJAKwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:52:49 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:47070 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751495AbWJAKws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:52:48 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 3/13] kconfig/lxdialog: add a new theme bluetitle which is now default
Reply-To: sam@ravnborg.org
Date: Sun, 01 Oct 2006 12:52:36 +0200
Message-Id: <11596999673562-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1159699967600-git-send-email-sam@ravnborg.org>
References: <1159699966691-git-send-email-sam@ravnborg.org> <1159699967600-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

The bluetitle theme is a slightly modified version of the colorscheme
that -mm users has been used to. The bluetitle is more readable especially
on some LCD screens so it is now default.
Anyone that really wants the old color selection can get it by selecting
the classic color theme:
make MENUCONFIG_COLOR=classic menuconfig

The bluetitle theme was modified by Roman Zippel <zippel@linux-m68k.org>
to further improve readability on LCD screens.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/util.c |   17 ++++++++++++++++-
 scripts/kconfig/mconf.c         |    3 ++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index 358f9cc..e73a36d 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -138,6 +138,19 @@ static void set_blackbg_theme(void)
 	DLG_COLOR(darrow, COLOR_RED, COLOR_BLACK, false);
 }
 
+static void set_bluetitle_theme(void)
+{
+	set_classic_theme();
+	DLG_COLOR(title,               COLOR_BLUE,   COLOR_WHITE, true);
+	DLG_COLOR(button_key_active,   COLOR_YELLOW, COLOR_BLUE,  true);
+	DLG_COLOR(button_label_active, COLOR_WHITE,  COLOR_BLUE,  true);
+	DLG_COLOR(searchbox_title,     COLOR_BLUE,   COLOR_WHITE, true);
+	DLG_COLOR(position_indicator,  COLOR_BLUE,   COLOR_WHITE, true);
+	DLG_COLOR(tag,                 COLOR_BLUE,   COLOR_WHITE, true);
+	DLG_COLOR(tag_key,             COLOR_BLUE,   COLOR_WHITE, true);
+
+}
+
 /*
  * Select color theme
  */
@@ -145,9 +158,11 @@ static int set_theme(const char *theme)
 {
 	int use_color = 1;
 	if (!theme)
-		set_classic_theme();
+		set_bluetitle_theme();
 	else if (strcmp(theme, "classic") == 0)
 		set_classic_theme();
+	else if (strcmp(theme, "bluetitle") == 0)
+		set_bluetitle_theme();
 	else if (strcmp(theme, "blackbg") == 0)
 		set_blackbg_theme();
 	else if (strcmp(theme, "mono") == 0)
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index ed22b13..5992673 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -171,7 +171,8 @@ static const char mconf_readme[] = N_(
 "Available themes are\n"
 " mono       => selects colors suitable for monochrome displays\n"
 " blackbg    => selects a color scheme with black background\n"
-" classic    => theme with blue background. The classic look. (default)\n"
+" classic    => theme with blue background. The classic look\n"
+" bluetitle  => a LCD friendly version of classic. (default)\n"
 "\n"),
 menu_instructions[] = N_(
 	"Arrow keys navigate the menu.  "
-- 
1.4.1

