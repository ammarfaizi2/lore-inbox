Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWHBT2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWHBT2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWHBT2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:28:03 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:35728 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750883AbWHBT2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:28:01 -0400
Subject: [patch 3/3] selinux:  replace ctxid with sid in
	selinux_audit_rule_match interface
From: Stephen Smalley <sds@tycho.nsa.gov>
To: linux-audit@redhat.com, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 02 Aug 2006 15:30:19 -0400
Message-Id: <1154547019.16917.188.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ctxid with sid in selinux_audit_rule_match interface
for consistency with other interfaces.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---
 include/linux/selinux.h        |    6 +++---
 security/selinux/ss/services.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index df9098d..d1b7ca6 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -46,7 +46,7 @@ void selinux_audit_rule_free(struct seli
 
 /**
  *	selinux_audit_rule_match - determine if a context ID matches a rule.
- *	@ctxid: the context ID to check
+ *	@sid: the context ID to check
  *	@field: the field this rule refers to
  *	@op: the operater the rule uses
  *	@rule: pointer to the audit rule to check against
@@ -55,7 +55,7 @@ void selinux_audit_rule_free(struct seli
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
                              struct selinux_audit_rule *rule,
                              struct audit_context *actx);
 
@@ -144,7 +144,7 @@ static inline void selinux_audit_rule_fr
 	return;
 }
 
-static inline int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+static inline int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
                                            struct selinux_audit_rule *rule,
                                            struct audit_context *actx)
 {
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 85e4298..ed78334 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1923,7 +1923,7 @@ int selinux_audit_rule_init(u32 field, u
 	return rc;
 }
 
-int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
                              struct selinux_audit_rule *rule,
                              struct audit_context *actx)
 {
@@ -1946,11 +1946,11 @@ int selinux_audit_rule_match(u32 ctxid, 
 		goto out;
 	}
 
-	ctxt = sidtab_search(&sidtab, ctxid);
+	ctxt = sidtab_search(&sidtab, sid);
 	if (!ctxt) {
 		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
 		          "selinux_audit_rule_match: unrecognized SID %d\n",
-		          ctxid);
+		          sid);
 		match = -ENOENT;
 		goto out;
 	}
-- 
1.4.1



