Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWD0CHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWD0CHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWD0CHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:07:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:16529 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964862AbWD0CHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:07:51 -0400
Date: Wed, 26 Apr 2006 21:07:40 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>
Subject: [PATCH] selinux: check for failed kmalloc in security_sid_to_context
Message-ID: <20060427020740.GA23112@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check for NULL kmalloc return value before writing to it.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 security/selinux/ss/services.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

3d9cf05c7fa2578f87648dd0862e70cf7959ad7a
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 6149248..20b1065 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -593,6 +593,10 @@ int security_sid_to_context(u32 sid, cha
 
 			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
 			scontextp = kmalloc(*scontext_len,GFP_ATOMIC);
+			if (!scontextp) {
+				rc = -ENOMEM;
+				goto out;
+			}
 			strcpy(scontextp, initial_sid_to_string[sid]);
 			*scontext = scontextp;
 			goto out;
-- 
1.3.0

