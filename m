Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbUC2USB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUC2USB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:18:01 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:9972 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S263135AbUC2UR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:17:58 -0500
Date: Mon, 29 Mar 2004 13:17:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][KGDB] Drop 'E' packet support
Message-ID: <20040329201756.GK2895@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  After working on the docs a bit based on the textfile from Anurekh
Saxena, I'd like to commit the following patch (and similar hunks to the
i386-lite and x86_64 patch) to drop support for the 'E' packet.

This isn't something supported by stock GDB, nor AFAIK is it something
that's been submitted for inclusion in GDB.  So I'd really like to drop
this entirely until it's something gdb CVS supports (and I assume would
be documented in
http://sources.redhat.com/gdb/current/onlinedocs/gdb_33.html#SEC656 ).
I could stand putting off the question for now and putting it in the
non-lite patches, but I'd really rather not.

If no one objects, I'd like to commit this noon, -0700 on 30 March.
diff -u linux-2.6.4/kernel/kgdb.c linux-2.6.4/kernel/kgdb.c
--- linux-2.6.4/kernel/kgdb.c	2004-03-19 08:22:37.147169789 -0700
+++ linux-2.6.4/kernel/kgdb.c	2004-03-29 13:13:11.440594007 -0700
@@ -130,11 +130,6 @@
 }
 
 void __attribute__ ((weak))
-    kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
-{
-}
-
-void __attribute__ ((weak))
     kgdb_disable_hw_debug(struct pt_regs *regs)
 {
 }
@@ -875,12 +870,6 @@
 				int_to_threadref(&thref, threadid);
 				pack_threadid(remcom_out_buffer + 2, &thref);
 				break;
-
-			case 'E':
-				/* Print exception info */
-				kgdb_printexceptioninfo(exVector, err_code,
-							remcom_out_buffer);
-				break;
 			case 'T':
 				if (memcmp(remcom_in_buffer + 1,
 					   "ThreadExtraInfo,", 16)) {

-- 
Tom Rini
http://gate.crashing.org/~trini/
