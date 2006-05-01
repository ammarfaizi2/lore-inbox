Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWEATxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWEATxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWEATxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:53:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:28864 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932209AbWEATxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:53:55 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 1/7] uts namespaces: introduce temporary helpers
Message-ID: <20060501203901.XF1836@sergelap.austin.ibm.com>
References: <20060501203900.XF1836@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501203903.XF1836@sergelap.austin.ibm.com>
X-Mutt-References: <20060501203903.XF1836@sergelap.austin.ibm.com>
X-Mutt-Fcc: ~/Mail/SENT
Date: Mon,  1 May 2006 14:53:52 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define utsname() and init_utsname() which return &system_utsname.
Users of system_utsname will be changed to use these helpers, after
which system_utsname will disappear.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 include/linux/utsname.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

751c1567989ac921a1f861c05234a58c9181cfd3
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


