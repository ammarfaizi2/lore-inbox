Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267763AbUHPQbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267763AbUHPQbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUHPQbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:31:42 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:26099 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267764AbUHPQbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:31:34 -0400
Subject: [PATCH][SELINUX] Fix name_bind audit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1092673814.16631.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 12:30:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch restores the proper auditing behavior for the name_bind check.  Please apply.

Author:  James Morris <jmorris@redhat.com>
Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c |    1 +
 1 files changed, 1 insertion(+)

diff -urN -X dontdiff linux-2.6.8-rc4.o/security/selinux/hooks.c linux-2.6.8-rc4.w/security/selinux/hooks.c
--- linux-2.6.8-rc4.o/security/selinux/hooks.c	2004-08-10 01:20:16.000000000 -0400
+++ linux-2.6.8-rc4.w/security/selinux/hooks.c	2004-08-11 11:36:48.000000000 -0400
@@ -3078,6 +3078,7 @@
 				goto out;
 			AVC_AUDIT_DATA_INIT(&ad,NET);
 			ad.u.net.sport = htons(snum);
+			ad.u.net.family = family;
 			err = avc_has_perm(isec->sid, sid,
 					   isec->sclass,
 					   SOCKET__NAME_BIND, NULL, &ad);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

