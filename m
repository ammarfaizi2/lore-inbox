Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267787AbTBRMzX>; Tue, 18 Feb 2003 07:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267792AbTBRMzX>; Tue, 18 Feb 2003 07:55:23 -0500
Received: from gherkin.frus.com ([192.158.254.49]:57729 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S267787AbTBRMyb>;
	Tue, 18 Feb 2003 07:54:31 -0500
Subject: [PATCH] aicasm Makefile
To: gibbs@scsiguy.com
Date: Tue, 18 Feb 2003 07:04:31 -0600 (CST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM741507071-19856-0_
Content-Transfer-Encoding: 7bit
Message-Id: <20030218130431.EC8594EEF@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM741507071-19856-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

The Makefile for aicasm has been broken since 2.5.48.  The order in
which objects are specified on the linker command line *is* significant,
and if "-ldb" is made part of AICASM_CFLAGS rather than appearing after
the "-o $(PROG)", I get an undefined symbol error (__db185_open).

The attached patch is against 2.5.54-2.5.62 inclusive.  If anyone is
wondering, yes, this is a repeat posting on this subject (original was
1 December 2002).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM741507071-19856-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch62_aicasm

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

--ELM741507071-19856-0_--
