Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSKRT05>; Mon, 18 Nov 2002 14:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSKRT00>; Mon, 18 Nov 2002 14:26:26 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:62117 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264679AbSKRTYw> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (9/16): ebcdic conversion bug.
Date: Mon, 18 Nov 2002 20:20:45 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182020.45678.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ebcdic conversion for strings of n*256 + 1 characters.

diff -urN linux-2.5.48/include/asm-s390/ebcdic.h linux-2.5.48-s390/include/asm-s390/ebcdic.h
--- linux-2.5.48/include/asm-s390/ebcdic.h	Mon Nov 18 05:29:32 2002
+++ linux-2.5.48-s390/include/asm-s390/ebcdic.h	Mon Nov 18 20:11:44 2002
@@ -32,7 +32,7 @@
                 "0: tr   0(256,%0),0(%2)\n"
 		"   la   %0,256(%0)\n"
 		"1: ahi  %1,-256\n"
-		"   jp   0b\n"
+		"   jnm  0b\n"
 		"   ex   %1,0(1)"
                 : "+&a" (addr), "+&a" (nr)
                 : "a" (codepage) : "cc", "memory", "1" );
diff -urN linux-2.5.48/include/asm-s390x/ebcdic.h linux-2.5.48-s390/include/asm-s390x/ebcdic.h
--- linux-2.5.48/include/asm-s390x/ebcdic.h	Mon Nov 18 05:29:56 2002
+++ linux-2.5.48-s390/include/asm-s390x/ebcdic.h	Mon Nov 18 20:11:44 2002
@@ -32,7 +32,7 @@
 		"0: tr    0(256,%0),0(%2)\n"
 		"   la    %0,256(%0)\n"
 		"1: ahi   %1,-256\n"
-		"   jp    0b\n"
+		"   jnm   0b\n"
 		"   ex    %1,0(1)"
 		: "+&a" (addr), "+&a" (nr)
 		: "a" (codepage) : "cc", "memory", "1" );

