Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUBBVEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbUBBTqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:46:03 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:34669 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265941AbUBBTp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:45:27 -0500
Date: Mon, 2 Feb 2004 20:45:28 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 13/42]
Message-ID: <20040202194528.GM6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tipar.c:76:1: warning: "minor" redefined
include/linux/kdev_t.h:81:1: warning: this is the location of the previous definition

Don't redefine 'minor' macro.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/char/tipar.c linux-2.4/drivers/char/tipar.c
--- linux-2.4-vanilla/drivers/char/tipar.c	Fri Jun 13 16:51:33 2003
+++ linux-2.4/drivers/char/tipar.c	Sat Jan 31 17:16:42 2004
@@ -73,7 +73,9 @@
 
 #define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
 #if LINUX_VERSION_CODE < VERSION(2,5,0)
-# define minor(x) MINOR(x)
+# ifndef minor
+#  define minor(x) MINOR(x)
+# endif
 # define need_resched() (current->need_resched)
 #endif
 
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"L'abilita` politica e` l'abilita` di prevedere quello che
 accadra` domani, la prossima settimana, il prossimo mese e
 l'anno prossimo. E di essere cosi` abili, piu` tardi,
 da spiegare  perche' non e` accaduto."
