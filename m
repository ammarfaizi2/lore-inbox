Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130852AbRCFCLA>; Mon, 5 Mar 2001 21:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130855AbRCFCKv>; Mon, 5 Mar 2001 21:10:51 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:28427 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S130852AbRCFCKc>; Mon, 5 Mar 2001 21:10:32 -0500
Date: Mon, 5 Mar 2001 18:10:25 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <E14a6pj-0008G3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31ksi3.0103051808160.28775-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Alan Cox wrote:

> > On Mon, 5 Mar 2001, Alexander Viro wrote:
> >
> > New Adaptec driver does not build. It won't. People, can anyone
> enlighten me
> > why do we use a user space library for a kernel driver at all?
>
> aicasm is an assembler for the aic7xxx risc instruction code, not part
> of
> the driver

May be. But it's not a reason to use the _OBSOLETE_ library. At least the
current one should be used...

Here comes the patch to use current libdb-3...

=== Cut ===
diff -urN linux-2.4.2ac12.orig/drivers/scsi/aic7xxx/aicasm/Makefile linux-2.4.2ac12/drivers/scsi/aic7xxx/aicasm/Makefile
--- linux-2.4.2ac12.orig/drivers/scsi/aic7xxx/aicasm/Makefile	Mon Mar  5 18:05:06 2001
+++ linux-2.4.2ac12/drivers/scsi/aic7xxx/aicasm/Makefile	Mon Mar  5 18:06:46 2001
@@ -8,7 +8,7 @@
 SRCS=	${GENSRCS} ${CSRCS}
 CLEANFILES= ${GENSRCS} ${GENHDRS} y.output
 # Override default kernel CFLAGS.  This is a userland app.
-AICASM_CFLAGS:= -I/usr/include -ldb1
+AICASM_CFLAGS:= -I/usr/include -ldb
 YFLAGS= -d

 NOMAN=	noman
diff -urN linux-2.4.2ac12.orig/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c linux-2.4.2ac12/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
--- linux-2.4.2ac12.orig/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c	Mon Mar  5 18:05:06 2001
+++ linux-2.4.2ac12/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c	Mon Mar  5 18:06:32 2001
@@ -36,7 +36,7 @@
 #include <sys/types.h>

 #ifdef __linux__
-#include <db1/db.h>
+#include <db/db_185.h>
 #else
 #include <db.h>
 #endif
=== Cut ===

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

