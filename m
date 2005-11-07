Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVKGQM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVKGQM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVKGQM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:12:59 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:30128 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S964840AbVKGQM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:12:59 -0500
Subject: [patch 1/1] selinux:  MLS compatibility
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 07 Nov 2005 11:08:55 -0500
Message-Id: <1131379735.20591.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables files created on a MLS-enabled SELinux system to be
accessible on a non-MLS SELinux system, by skipping the MLS component of
the security context in the non-MLS case.  Please apply, for 2.6.15 if
possible.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@namei.org>

---

 security/selinux/ss/mls.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/security/selinux/ss/mls.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/mls.c,v
retrieving revision 1.26
diff -u -p -r1.26 mls.c
--- linux-2.6/security/selinux/ss/mls.c	29 Aug 2005 14:13:22 -0000	1.26
+++ linux-2.6/security/selinux/ss/mls.c	4 Nov 2005 19:26:47 -0000
@@ -262,8 +262,11 @@ int mls_context_to_sid(char oldc,
 	struct cat_datum *catdatum, *rngdatum;
 	int l, rc = -EINVAL;
 
-	if (!selinux_mls_enabled)
+	if (!selinux_mls_enabled) {
+		if (def_sid != SECSID_NULL && oldc)
+			*scontext += strlen(*scontext);
 		return 0;
+	}
 
 	/*
 	 * No MLS component to the security context, try and map to

-- 
Stephen Smalley
National Security Agency

