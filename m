Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268848AbTCCW7u>; Mon, 3 Mar 2003 17:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268852AbTCCW7u>; Mon, 3 Mar 2003 17:59:50 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:2469 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268848AbTCCW7t>; Mon, 3 Mar 2003 17:59:49 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [trivial] avoid a warning for each module on s390x
Date: Tue, 4 Mar 2003 00:08:04 +0100
User-Agent: KMail/1.5
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Trivial Patches <trivial@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303040008.04468.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390x has a reference to _GLOBAL_OFFSET_TABLE_ in each module
that is resolved by the module loader. This patch prevents
modpost from emitting a warning about that symbol.

--- linux-2.5.63/scripts/modpost.c	Tue Feb 18 18:41:54 2003
+++ linux-s390x/scripts/modpost.c	Mon Feb 24 22:42:01 2003
@@ -289,6 +289,9 @@
 		/* undefined symbol */
 		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
 			break;
+		/* ignore global offset table */
+		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
+			break;
 		
 		s = alloc_symbol(symname);
 		/* add to list */
