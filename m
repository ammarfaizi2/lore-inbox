Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268123AbTBYMlf>; Tue, 25 Feb 2003 07:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268129AbTBYMlf>; Tue, 25 Feb 2003 07:41:35 -0500
Received: from gherkin.frus.com ([192.158.254.49]:9606 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S268123AbTBYMld>;
	Tue, 25 Feb 2003 07:41:33 -0500
Subject: [PATCH] 2.5.63: aicasm Makefile
To: gibbs@scsiguy.com
Date: Tue, 25 Feb 2003 06:51:47 -0600 (CST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM741935458-11570-0_
Content-Transfer-Encoding: 7bit
Message-Id: <20030225125147.CC4DA4F0B@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM741935458-11570-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

The Makefile for aicasm has been broken since 2.5.48.  The order in
which objects are specified on the linker command line *is* significant,
and if "-ldb" is made part of AICASM_CFLAGS rather than appearing after
the "-o $(PROG)", I get an undefined symbol error (__db185_open).

The attached patch is against 2.5.54-2.5.63 inclusive.  Original
posting 1 December 2002.  Patch included in 2.5.62-ac1 (Thanks, Alan!),
but didn't make it into 2.5.63.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM741935458-11570-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch63_aicasm

--- linux/drivers/scsi/aic7xxx/aicasm/Makefile~	2002-12-24 07:09:29.000000000 -0600
+++ linux/drivers/scsi/aic7xxx/aicasm/Makefile	2003-01-07 16:47:01.000000000 -0600
@@ -10,9 +10,10 @@
 GENSRCS=	$(YSRCS:.y=.c) $(LSRCS:.l=.c)
 
 SRCS=	${CSRCS} ${GENSRCS}
+LIBS=	-ldb
 CLEANFILES= ${GENSRCS} ${GENHDRS} $(YSRCS:.y=.output)
 # Override default kernel CFLAGS.  This is a userland app.
-AICASM_CFLAGS:= -I/usr/include -I. -ldb
+AICASM_CFLAGS:= -I/usr/include -I.
 YFLAGS= -d
 
 NOMAN=	noman
@@ -30,7 +31,7 @@
 endif
 
 $(PROG):  ${GENHDRS} $(SRCS)
-	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG)
+	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG) $(LIBS)
 
 aicdb.h:
 	@if [ -e "/usr/include/db3/db_185.h" ]; then		\

--ELM741935458-11570-0_--
