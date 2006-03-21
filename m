Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWCUQcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWCUQcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWCUQag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30732 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030306AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 34/46] kbuild: when warning symbols exported twice now tell user this is the problem
In-Reply-To: <1142958056929-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <1142958057218-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning now looks like this:
WARNING: vmlinux: 'strcpy' exported twice. Previous export was in vmlinux

Which gives much better hint how to fix it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7b75b13cda8bd21e8636ea985f76e1ce5bd1a470
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3648683..e2bf4c9 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -191,7 +191,7 @@ static struct symbol *sym_add_exported(c
 		s = new_symbol(name, mod);
 	} else {
 		if (!s->preloaded) {
-			warn("%s: duplicate symbol '%s' previous definition "
+			warn("%s: '%s' exported twice. Previous export "
 			     "was in %s%s\n", mod->name, name,
 			     s->module->name,
 			     is_vmlinux(s->module->name) ?"":".ko");
-- 
1.0.GIT


