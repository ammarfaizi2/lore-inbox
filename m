Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUAHRH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUAHRH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:07:58 -0500
Received: from smtp06.auna.com ([62.81.186.16]:27090 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S265113AbUAHRH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:07:56 -0500
Date: Thu, 8 Jan 2004 18:07:52 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] aicasm build with db4
Message-ID: <20040108170752.GA5267@werewolf.able.es>
References: <Pine.LNX.4.58.0401072245150.6823@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.58.0401072245150.6823@home.osdl.org> (from torvalds@osdl.org on Thu, Jan 08, 2004 at 07:48:00 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.08, Linus Torvalds wrote:
> 
> Not a lot to say, the ChangeLog says it all (and I include the -rc2 log 
> too, since I forgot to actually ever post it). Mostly random smaller stuff 
> all over. The big merges were all in rc1 and do not seem to have caused 
> any huge headaches.
> 
> 		Linus
> 
> ---
> 
> Summary of changes from v2.6.1-rc2 to v2.6.1-rc3
> ============================================
> 

Would you mind including this for final 2.6.1 ? I allows aicasm build
with different db versions:

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


-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.1-rc1-jam2 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-3mdk))
