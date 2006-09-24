Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWIXVVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWIXVVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWIXVRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:45 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:9362 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932146AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 26/28] kbuild: fix "mkdir -p" usage in scripts/package/mkspec
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:22 +0200
Message-Id: <11591327073393-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327073816-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org> <115913
 2706423-git-send-email-sam@ravnborg.org> <115913270694-git-send-email-sam@ravnborg.org> <1159132706126-git-send-email-sam@ravnborg.org> <11591327063625-git-send-email-sam@ravnborg.org> <11591327063733-git-send-email-sam@ravnborg.org> <11591327073816-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Eike Beer <eike-kernel@sf-tec.de>

"mkdir -p" does not only mean not to complain if the directory already
exists, but also to create the parent directories if needed. This patch
removes "lib" from the list of directories to create as we will also create
"lib/modules".

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/package/mkspec |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index df89284..ffd61fe 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -63,9 +63,9 @@ fi
 
 echo "%install"
 echo "%ifarch ia64"
-echo 'mkdir -p $RPM_BUILD_ROOT/boot/efi $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+echo 'mkdir -p $RPM_BUILD_ROOT/boot/efi $RPM_BUILD_ROOT/lib/modules'
 echo "%else"
-echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib/modules'
 echo "%endif"
 
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make %{_smp_mflags} modules_install'
-- 
1.4.1

