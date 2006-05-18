Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWERPtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWERPtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWERPtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:49:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:11687 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932084AbWERPta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:49:30 -0400
Date: Thu, 18 May 2006 10:49:20 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Subject: [PATCH 3/9] namespaces: utsname: introduce temporary helpers
Message-ID: <20060518154920.GD28344@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518154700.GA28344@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define utsname() and init_utsname() which return &system_utsname.
Users of system_utsname will be changed to use these helpers, after
which system_utsname will disappear.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 include/linux/utsname.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

f409a5279295edf372d670452fd84199fd6ba7e5
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 13e1da0..77e97a5 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -32,5 +32,15 @@ struct new_utsname {
 
 extern struct new_utsname system_utsname;
 
+static inline struct new_utsname *utsname(void)
+{
+	return &system_utsname;
+}
+
+static inline struct new_utsname *init_utsname(void)
+{
+	return &system_utsname;
+}
+
 extern struct rw_semaphore uts_sem;
 #endif
-- 
1.1.6
