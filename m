Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVIUQra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVIUQra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVIUQrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:09 -0400
Received: from [151.97.230.9] ([151.97.230.9]:26510 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751119AbVIUQrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 05/10] uml: fix uname output on 32-bit binary on 64-bit host
Date: Wed, 21 Sep 2005 18:39:14 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921163913.30500.72827.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Translate uname output taken from the host if needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/user_util.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/um/kernel/user_util.c b/arch/um/kernel/user_util.c
--- a/arch/um/kernel/user_util.c
+++ b/arch/um/kernel/user_util.c
@@ -128,6 +128,12 @@ void setup_machinename(char *machine_out
 	struct utsname host;
 
 	uname(&host);
+#if defined(UML_CONFIG_UML_X86) && !defined(UML_CONFIG_64BIT)
+	if (!strcmp(host.machine, "x86_64")) {
+		strcpy(machine_out, "i686");
+		return;
+	}
+#endif
 	strcpy(machine_out, host.machine);
 }
 

