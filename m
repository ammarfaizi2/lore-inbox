Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVJIToI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVJIToI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVJITmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:42:40 -0400
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]:25240 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751027AbVJITmc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:42:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/6] uml: add mode=skas0 as a synonym of skas0
Date: Sun, 09 Oct 2005 21:37:18 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051009193718.26019.60494.stgit@zion.home.lan>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
References: <200510092118.21032.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Too many people were confused by skas0 and tried using "mode=skas0". And after
all, they are right - accept this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/start_up.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -143,11 +143,22 @@ static int __init skas0_cmd_param(char *
 	return 0;
 }
 
+/* The two __uml_setup would conflict, without this stupid alias. */
+
+static int __init mode_skas0_cmd_param(char *str, int* add)
+	__attribute__((alias("skas0_cmd_param")));
+
 __uml_setup("skas0", skas0_cmd_param,
 		"skas0\n"
 		"    Disables SKAS3 usage, so that SKAS0 is used, unless \n"
 	        "    you specify mode=tt.\n\n");
 
+__uml_setup("mode=skas0", mode_skas0_cmd_param,
+		"mode=skas0\n"
+		"    Disables SKAS3 usage, so that SKAS0 is used, unless you \n"
+		"    specify mode=tt. Note that this was recently added - on \n"
+		"    older kernels you must use simply \"skas0\".\n\n");
+
 static int force_sysemu_disabled = 0;
 
 static int __init nosysemu_cmd_param(char *str, int* add)

