Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272575AbTG1AmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272574AbTG1AE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:29 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272728AbTG0W6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:20 -0400
Date: Sun, 27 Jul 2003 21:26:36 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272026.h6RKQauS029828@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: allow 2.6 to build on old old setups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Mikael Pettersson)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/scripts/modpost.c linux-2.6.0-test2-ac1/scripts/modpost.c
--- linux-2.6.0-test2/scripts/modpost.c	2003-07-10 21:05:39.000000000 +0100
+++ linux-2.6.0-test2-ac1/scripts/modpost.c	2003-07-23 15:37:13.000000000 +0100
@@ -296,12 +296,14 @@
 		/* ignore global offset table */
 		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
 			break;
+#ifdef STT_REGISTER
 		if (info->hdr->e_machine == EM_SPARC ||
 		    info->hdr->e_machine == EM_SPARCV9) {
 			/* Ignore register directives. */
 			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
 				break;
 		}
+#endif
 		
 		if (memcmp(symname, MODULE_SYMBOL_PREFIX,
 			   strlen(MODULE_SYMBOL_PREFIX)) == 0) {

