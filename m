Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUEGLOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUEGLOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 07:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUEGLOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 07:14:08 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:24485 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263551AbUEGLOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 07:14:04 -0400
Date: Fri, 7 May 2004 13:14:02 +0200
From: Romain Lievin <lkml@lievin.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] tipar char driver: wront timeout value
Message-ID: <20040507111402.GA9624@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes a bug on the timeout value. The formula used to calculate jiffies from timeout was wrong.
The new formula is ok and takes care of integer computation/rounding.

This bug has already been fixed in the 2.6 kernel.

Please apply, Romain.

=============[ cut here ]===============
diff -Naur linux-2.4.26.orig/drivers/char/tipar.c linux-2.4.26/drivers/char/tipar.c
--- linux-2.4.26.orig/drivers/char/tipar.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.26/drivers/char/tipar.c	2004-04-19 09:22:36.000000000 +0200
@@ -124,7 +124,7 @@
 
 /* ----- global defines ----------------------------------------------- */
 
-#define START(x) { x=jiffies+HZ/(timeout/10); }
+#define START(x) { x = jiffies + (HZ * timeout) / 10; }
 #define WAIT(x)  { \
   if (time_before((x), jiffies)) return -1; \
   if (need_resched()) schedule(); }

-- 
Romain Liévin :		<roms@lievin.net>
Web site :		http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"






