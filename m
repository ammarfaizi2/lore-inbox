Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSLUR5I>; Sat, 21 Dec 2002 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSLUR5I>; Sat, 21 Dec 2002 12:57:08 -0500
Received: from host194.steeleye.com ([66.206.164.34]:25863 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262877AbSLUR5G>; Sat, 21 Dec 2002 12:57:06 -0500
Message-Id: <200212211805.gBLI55c03659@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: [PATCH] fix bug in scripts/kallsyms.c
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-14193470250"
Date: Sat, 21 Dec 2002 12:05:05 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-14193470250
Content-Type: text/plain; charset=us-ascii

kallsyms.c generates the symbol table in a .S file using the assembler .string 
macro.  Unfortunately, the .string macro is implemented in a platform specific 
way (it may or may not zero terminate the string).  On parisc, it doesn't zero 
terminate, so the symbol table search doesn't work.

The solution is to replace .string with .asciz which is guaranteed to do the 
correct thing on all platforms.

James


--==_Exmh_-14193470250
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== scripts/kallsyms.c 1.2 vs edited =====
--- 1.2/scripts/kallsyms.c	Thu Dec  5 13:57:11 2002
+++ edited/scripts/kallsyms.c	Sat Dec 21 11:43:11 2002
@@ -128,7 +128,7 @@
 		if (table[i].addr == last_addr)
 			continue;
 
-		printf("\t.string\t\"%s\"\n", table[i].sym);
+		printf("\t.asciz\t\"%s\"\n", table[i].sym);
 		last_addr = table[i].addr;
 	}
 	printf("\n");

--==_Exmh_-14193470250--


