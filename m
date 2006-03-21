Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWCUQWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWCUQWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWCUQVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28940 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030347AbWCUQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:14 -0500
Cc: Jan Beulich <JBeulich@novell.com>, Jan Beulich <jbeulich@novell.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 44/46] kconfig: fix time ordering of writes to .kconfig.d and include/linux/autoconf.h
In-Reply-To: <11429580571198-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <11429580573947-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since .kconfig.d is used as a make dependency of include/linux/autoconf.h, it
should be written earlier than the header file, to avoid a subsequent rebuild
to consider the header outdated.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/kconfig/confdata.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

dc9a49a4af9cdbe3d79183eefb12372b4dbc09c2
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index b0cbbe2..1b8882d 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -374,6 +374,7 @@ int conf_write(const char *name)
 		out_h = fopen(".tmpconfig.h", "w");
 		if (!out_h)
 			return 1;
+		file_write_dep(NULL);
 	}
 	sym = sym_lookup("KERNELVERSION", 0);
 	sym_calc_value(sym);
@@ -512,7 +513,6 @@ int conf_write(const char *name)
 	if (out_h) {
 		fclose(out_h);
 		rename(".tmpconfig.h", "include/linux/autoconf.h");
-		file_write_dep(NULL);
 	}
 	if (!name || basename != conf_def_filename) {
 		if (!name)
-- 
1.0.GIT


