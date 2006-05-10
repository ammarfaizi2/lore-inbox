Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWEJCLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWEJCLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWEJCLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:11:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2242 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751338AbWEJCLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:11:45 -0400
Date: Tue, 9 May 2006 21:11:39 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 3/9] uts namespaces: introduce temporary helpers
Message-ID: <20060510021139.GD32523@sergelap.austin.ibm.com>
References: <29vfyljM-2.2006059-s@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define utsname() and init_utsname() which return &system_utsname.
Users of system_utsname will be changed to use these helpers, after
which system_utsname will disappear.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 include/linux/utsname.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

227bebceeec2a4dcb495bbc0898cbb8af9aa2fb8
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 13e1da0..8f0decf 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -32,5 +32,13 @@ struct new_utsname {
 
 extern struct new_utsname system_utsname;
 
+static inline struct new_utsname *utsname(void) {
+	return &system_utsname;
+}
+
+static inline struct new_utsname *init_utsname(void) {
+	return &system_utsname;
+}
+
 extern struct rw_semaphore uts_sem;
 #endif
-- 
1.3.0

