Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUCIW0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUCIW0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:26:06 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:33736 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262238AbUCIW0A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:26:00 -0500
Date: Tue, 9 Mar 2004 23:25:59 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Print function names during do_initcall debugging
Message-ID: <20040309222559.GX17857@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Please merge the following patch. It prints __init function names while
all calls are executed at do_initcalls().

--- a/init/main.c	23 Feb 2004 22:50:26 -0000	1.1.1.51
+++ b/init/main.c	9 Mar 2004 22:00:19 -0000
@@ -36,6 +36,7 @@
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
+#include <linux/kallsyms.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
@@ -495,8 +496,10 @@
 	for (call = &__initcall_start; call < &__initcall_end; call++) {
 		char *msg;
 
-		if (initcall_debug)
-			printk("calling initcall 0x%p\n", *call);
+		if (initcall_debug) {
+			printk(KERN_DEBUG "Calling initcall 0x%p: ", *call);
+			print_symbol("%s()\n", (unsigned long) *call);
+		}
 
 		(*call)();
 

MfG, JBG

-- 
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
   ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
