Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVAQKbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVAQKbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVAQKbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:31:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15110 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262759AbVAQKbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:31:03 -0500
Date: Mon, 17 Jan 2005 11:30:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] fix placement of static inline in nfsd.h
Message-ID: <20050117103057.GK4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
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
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jesper Juhl on 7 Dec 2004.

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




