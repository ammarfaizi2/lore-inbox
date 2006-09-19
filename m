Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWISNrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWISNrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 09:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbWISNrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 09:47:39 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:41178 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751866AbWISNri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 09:47:38 -0400
Date: Tue, 19 Sep 2006 09:47:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
       Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: [PATCH] SELinux: Fix bug in security_sid_mls_copy
Message-ID: <Pine.LNX.4.64.0609190945180.17323@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkat Yekkirala <vyekkirala@TrustedCS.com>

The following fixes a bug where random mem is being tampered with in the 
non-mls case; encountered by Jashua Brindle on a gentoo box.

Please apply.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>

---

 security/selinux/ss/services.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 27ee28c..7eb69a6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1841,7 +1841,7 @@ int security_sid_mls_copy(u32 sid, u32 m
 	u32 len;
 	int rc = 0;
 
-	if (!ss_initialized) {
+	if (!ss_initialized || !selinux_mls_enabled) {
 		*new_sid = sid;
 		goto out;
 	}

