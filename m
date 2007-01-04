Return-Path: <linux-kernel-owner+w=401wt.eu-S965069AbXADShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbXADShp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbXADShp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:37:45 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53102 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965069AbXADSho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:37:44 -0500
Date: Thu, 4 Jan 2007 12:37:34 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Mimi Zohar <zohar@us.ibm.com>
Subject: [PATCH -mm] integrity: don't return a value from void function
Message-ID: <20070104183734.GB21305@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] integrity: don't return a value from void function

include/linux/integrity.h:integrity_measure() returns void,
but the non-integrity dummy version does 'return 0;'.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/integrity.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index a318a2f..45f1d0c 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -86,7 +86,7 @@ static inline int integrity_verify_data(
 static inline void integrity_measure(struct dentry *dentry,
 			const unsigned char *filename, int mask)
 {
-	return integrity_ops->measure(dentry, filename, mask);
+	integrity_ops->measure(dentry, filename, mask);
 }
 #else
 static inline int integrity_verify_metadata(struct dentry *dentry,
@@ -107,7 +107,6 @@ static inline int integrity_verify_data(
 static inline void integrity_measure(struct dentry *dentry,
 			const unsigned char *filename, int mask)
 {
-	return 0;
 }
 #endif
 #endif
-- 
1.4.1

