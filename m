Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWJAKx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWJAKx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWJAKw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:52:58 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:48350 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751560AbWJAKwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:52:49 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@neptun.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 8/13] kbuild: do not build mconf & lxdialog unless needed
Reply-To: sam@ravnborg.org
Date: Sun, 01 Oct 2006 12:52:41 +0200
Message-Id: <11596999672988-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11596999673444-git-send-email-sam@ravnborg.org>
References: <1159699966691-git-send-email-sam@ravnborg.org> <1159699967600-git-send-email-sam@ravnborg.org> <11596999673562-git-send-email-sam@ravnborg.org> <115969996719-git-send-email-sam@ravnborg.org> <11596999673039-git-send-email-sam@ravnborg.org> <11596999672694-git-send-email-sam@ravnborg.org> <11596999673444-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@neptun.ravnborg.org>

Due to a limitation in kbuild all objects referred
by xxx-y or xxx-objs will be build when one of
the targets needs to e build.

This caused lxdialog to be build pulling in ncurses
that is not always available.
So avoid building mconf & lxdialog unless really needed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/Makefile |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 0b415eb..7e7e147 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -111,11 +111,16 @@ # object files used by all kconfig flavo
 lxdialog := lxdialog/checklist.o lxdialog/util.o lxdialog/inputbox.o
 lxdialog += lxdialog/textbox.o lxdialog/yesno.o lxdialog/menubox.o
 
-hostprogs-y	:= conf mconf qconf gconf kxgettext
 conf-objs	:= conf.o  zconf.tab.o
 mconf-objs	:= mconf.o zconf.tab.o $(lxdialog)
 kxgettext-objs	:= kxgettext.o zconf.tab.o
 
+hostprogs-y := conf qconf gconf kxgettext
+
+ifeq ($(MAKECMDGOALS),menuconfig)
+	hostprogs-y += mconf
+endif
+
 ifeq ($(MAKECMDGOALS),xconfig)
 	qconf-target := 1
 endif
-- 
1.4.1

