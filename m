Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316489AbSEUCT3>; Mon, 20 May 2002 22:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316490AbSEUCT2>; Mon, 20 May 2002 22:19:28 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:33247 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316489AbSEUCT2>;
	Mon, 20 May 2002 22:19:28 -0400
Date: Tue, 21 May 2002 12:19:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL PATCH] Fix order of #includes in init/version.c
Message-ID: <20020521021952.GD4745@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  compile.h must be #included before uts.h, or
uts.h will define UTS_MACHINE (incorrectly) which is then redefined in
compile.h.

diff -urN /home/dgibson/kernel/linuxppc-2.5/init/version.c linux-bluefish/init/version.c
--- /home/dgibson/kernel/linuxppc-2.5/init/version.c	Tue Feb  5 18:55:11 2002
+++ linux-bluefish/init/version.c	Tue May 21 12:06:11 2002
@@ -6,10 +6,10 @@
  *  May be freely distributed as part of Linux.
  */
 
+#include <linux/compile.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
-#include <linux/compile.h>
 
 #define version(a) Version_ ## a
 #define version_string(a) version(a)


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
