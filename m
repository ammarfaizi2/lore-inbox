Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264431AbTLBXLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTLBXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:11:07 -0500
Received: from aneto.able.es ([212.97.163.22]:25811 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264431AbTLBXLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:11:03 -0500
Date: Wed, 3 Dec 2003 00:11:00 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow 2.6.0-test11 AIC build with db4
Message-ID: <20031202231100.GA30868@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all...

Just my first attempt with 2.6 ;)

This was included in 2.4 time ago. aicasm build does not detect db4 or db1 in some
setups:
- does not try for /usr/include/db4
- does not try for /usr/include/db1.

This corrects it. I'm building now, hope it boots... nvidia will be next issue.

--- linux-2.6.0-test11/drivers/scsi/aic7xxx/aicasm/Makefile.orig	2003-12-02 23:52:29.000000000 +0100
+++ linux-2.6.0-test11/drivers/scsi/aic7xxx/aicasm/Makefile	2003-12-03 00:01:04.000000000 +0100
@@ -34,10 +34,14 @@
 	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG) $(LIBS)
 
 aicdb.h:
-	@if [ -e "/usr/include/db3/db_185.h" ]; then		\
+	@if [ -e "/usr/include/db4/db_185.h" ]; then		\
+		echo "#include <db4/db_185.h>" > aicdb.h;	\
+	 elif [ -e "/usr/include/db3/db_185.h" ]; then		\
 		echo "#include <db3/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db2/db_185.h" ]; then		\
 		echo "#include <db2/db_185.h>" > aicdb.h;	\
+	 elif [ -e "/usr/include/db1/db_185.h" ]; then		\
+		echo "#include <db1/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db/db_185.h" ]; then		\
 		echo "#include <db/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db_185.h" ]; then		\

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
