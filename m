Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWFGVNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWFGVNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWFGVNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:13:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:42120 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932420AbWFGVNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:13:02 -0400
Date: Wed, 7 Jun 2006 16:11:19 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Cedric Le Goater <clg@fr.ibm.com>
Subject: [PATCH] utsname: remove unused exit_utsname()
Message-ID: <20060607211119.GC30604@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The exit_utsname() inline function hasn't been in use since we switched
to using nsproxies.  Remove it's definition.  Thanks to Cedric for
noticing.

(This patch is on 2.6.17-rc5-mm3)

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 include/linux/utsname.h |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

fa0b64ea95feed3a62a94f807aba6c94f7f70d4b
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 0d500fe..bffb379 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -56,15 +56,6 @@ static inline void put_uts_ns(struct uts
 {
 	kref_put(&ns->kref, free_uts_ns);
 }
-
-static inline void exit_utsname(struct task_struct *p)
-{
-	struct uts_namespace *uts_ns = p->nsproxy->uts_ns;
-	if (uts_ns) {
-		put_uts_ns(uts_ns);
-	}
-}
-
 #else
 static inline int unshare_utsname(unsigned long unshare_flags,
 			struct uts_namespace **new_uts)
@@ -78,9 +69,6 @@ static inline int copy_utsname(int flags
 static inline void put_uts_ns(struct uts_namespace *ns)
 {
 }
-static inline void exit_utsname(struct task_struct *p)
-{
-}
 #endif
 
 static inline struct new_utsname *utsname(void)
-- 
1.1.6
