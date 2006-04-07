Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWDGOg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWDGOg7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDGOg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:36:58 -0400
Received: from [151.97.230.9] ([151.97.230.9]:47580 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932352AbWDGOcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 09/17] uml: fix critical typo for TT mode
Date: Fri, 07 Apr 2006 16:31:10 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143110.19201.91963.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Noticed this for a compilation-time warning, so I'm fixing it even for TT mode -
this is not put_user, but copy_to_user, so we need a pointer to sp, not sp
itself (we're trying to write the word pointed to by the "sp" var.).

Jeff, have I misunderstood anything?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-i386/signal.c   |    2 +-
 arch/um/sys-x86_64/signal.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/sys-i386/signal.c b/arch/um/sys-i386/signal.c
index f5d0e1c..618fd85 100644
--- a/arch/um/sys-i386/signal.c
+++ b/arch/um/sys-i386/signal.c
@@ -147,7 +147,7 @@ int copy_sc_to_user_tt(struct sigcontext
 	 * delivery.  The sp passed in is the original, and this needs
 	 * to be restored, so we stick it in separately.
 	 */
-	err |= copy_to_user(&SC_SP(to), sp, sizeof(sp));
+	err |= copy_to_user(&SC_SP(to), &sp, sizeof(sp));
 
 	if(from_fp != NULL){
 		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index e75c4e1..a4c46a8 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -137,7 +137,7 @@ int copy_sc_to_user_tt(struct sigcontext
 	 * delivery.  The sp passed in is the original, and this needs
 	 * to be restored, so we stick it in separately.
 	 */
-	err |= copy_to_user(&SC_SP(to), sp, sizeof(sp));
+	err |= copy_to_user(&SC_SP(to), &sp, sizeof(sp));
 
 	if(from_fp != NULL){
 		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
