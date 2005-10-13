Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbVJMT1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbVJMT1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbVJMT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:27:17 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:53133 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751630AbVJMT1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:27:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=jaB8kDEEY2HVDFeswPdIkC5ufNtx5Yto/sF9m5rZRwJ90xRSoxK614GXbkKZtAaX9363TNEUhEvMF1GAjK5R9D5yxHeZp+37FxJ3CR37HnBCbN6ZvmyKQVRlGmnetbcuyeLK97L7UyZp0LpksYXyurF6mjPcRh3LFluxB9Lt2kA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/14] Big kfree NULL check cleanup - security
Date: Thu, 13 Oct 2005 21:30:10 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@namei.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132130.10463.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the security/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in security/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 security/keys/key.c            |    3 +--
 security/selinux/ss/policydb.c |   12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.14-rc4-orig/security/keys/key.c	2005-10-11 22:41:35.000000000 +0200
+++ linux-2.6.14-rc4/security/keys/key.c	2005-10-13 11:47:59.000000000 +0200
@@ -114,8 +114,7 @@ struct key_user *key_user_lookup(uid_t u
  found:
 	atomic_inc(&user->usage);
 	spin_unlock(&key_user_lock);
-	if (candidate)
-		kfree(candidate);
+	kfree(candidate);
  out:
 	return user;
 
--- linux-2.6.14-rc4-orig/security/selinux/ss/policydb.c	2005-10-11 22:41:35.000000000 +0200
+++ linux-2.6.14-rc4/security/selinux/ss/policydb.c	2005-10-13 11:49:17.000000000 +0200
@@ -633,22 +633,22 @@ void policydb_destroy(struct policydb *p
 	cond_policydb_destroy(p);
 
 	for (tr = p->role_tr; tr; tr = tr->next) {
-		if (ltr) kfree(ltr);
+		kfree(ltr);
 		ltr = tr;
 	}
-	if (ltr) kfree(ltr);
+	kfree(ltr);
 
 	for (ra = p->role_allow; ra; ra = ra -> next) {
-		if (lra) kfree(lra);
+		kfree(lra);
 		lra = ra;
 	}
-	if (lra) kfree(lra);
+	kfree(lra);
 
 	for (rt = p->range_tr; rt; rt = rt -> next) {
-		if (lrt) kfree(lrt);
+		kfree(lrt);
 		lrt = rt;
 	}
-	if (lrt) kfree(lrt);
+	kfree(lrt);
 
 	for (i = 0; i < p->p_types.nprim; i++)
 		ebitmap_destroy(&p->type_attr_map[i]);



