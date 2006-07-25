Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWGYOLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWGYOLa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWGYOLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:11:30 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:29109 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932155AbWGYOLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:11:30 -0400
Subject: [patch 1/1] selinux: fix bug in security_compute_sid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@trustedcs.com>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Jul 2006 10:13:36 -0400
Message-Id: <1153836816.7104.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkat Yekkirala <vyekkirala@trustedcs.com>

Initializes newcontext sooner to allow for its destruction in all cases.
Please apply for 2.6.18.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/ss/services.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.18-rc2-git2/security/selinux/ss/services.c linux-2.6.18-rc2-git2-x/security/selinux/ss/services.c
--- linux-2.6.18-rc2-git2/security/selinux/ss/services.c	2006-07-24 11:25:49.000000000 -0400
+++ linux-2.6.18-rc2-git2-x/security/selinux/ss/services.c	2006-07-25 08:11:58.000000000 -0400
@@ -833,6 +833,8 @@ static int security_compute_sid(u32 ssid
 		goto out;
 	}
 
+	context_init(&newcontext);
+
 	POLICY_RDLOCK;
 
 	scontext = sidtab_search(&sidtab, ssid);
@@ -850,8 +852,6 @@ static int security_compute_sid(u32 ssid
 		goto out_unlock;
 	}
 
-	context_init(&newcontext);
-
 	/* Set the user identity. */
 	switch (specified) {
 	case AVTAB_TRANSITION:

-- 
Stephen Smalley
National Security Agency

