Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbULFX2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbULFX2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbULFX1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:27:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:25550 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261703AbULFXZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:25:20 -0500
Date: Tue, 7 Dec 2004 00:35:25 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Olaf Kirch <okir@monad.swb.de>
Subject: [PATCH] fix placement of static inline in nfsd.h
Message-ID: <Pine.LNX.4.61.0412070024580.3390@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch fixes a bunch of warnings like these 

include/linux/nfsd/nfsd.h:137: warning: `inline' is not at beginning of declaration
include/linux/nfsd/nfsd.h:138: warning: `inline' is not at beginning of declaration
include/linux/nfsd/nfsd.h:139: warning: `inline' is not at beginning of declaration
include/linux/nfsd/nfsd.h:140: warning: `inline' is not at beginning of declaration

and these

include/linux/nfsd/nfsd.h:137: warning: `static' is not at beginning of declaration
include/linux/nfsd/nfsd.h:138: warning: `static' is not at beginning of declaration
include/linux/nfsd/nfsd.h:139: warning: `static' is not at beginning of declaration
include/linux/nfsd/nfsd.h:140: warning: `static' is not at beginning of declaration

when building with gcc -W

True, that's not how most people build, but some of us do in order to try 
and find potential trouble spots, and the less warnings we have to go 
through the better - especially when they can be cleaned up nice and safe 
with no real impact to the code like these ones.
Please apply.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk2-orig/include/linux/nfsd/nfsd.h linux-2.6.10-rc3-bk2/include/linux/nfsd/nfsd.h
--- linux-2.6.10-rc3-bk2-orig/include/linux/nfsd/nfsd.h	2004-10-18 23:55:28.000000000 +0200
+++ linux-2.6.10-rc3-bk2/include/linux/nfsd/nfsd.h	2004-12-07 00:23:16.000000000 +0100
@@ -134,10 +134,10 @@ void nfs4_state_shutdown(void);
 time_t nfs4_lease_time(void);
 void nfs4_reset_lease(time_t leasetime);
 #else
-void static inline nfs4_state_init(void){}
-void static inline nfs4_state_shutdown(void){}
-time_t static inline nfs4_lease_time(void){return 0;}
-void static inline nfs4_reset_lease(time_t leasetime){}
+static inline void nfs4_state_init(void){}
+static inline void nfs4_state_shutdown(void){}
+static inline time_t nfs4_lease_time(void){return 0;}
+static inline void nfs4_reset_lease(time_t leasetime){}
 #endif
 
 /*




-- 
Jesper Juhl


PS. I'm only subscribed to linux-kernel, not the nfs list, so please keep 
me on CC.


