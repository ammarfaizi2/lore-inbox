Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWDKQs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWDKQs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWDKQs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:48:56 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:40656 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751270AbWDKQsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:48:55 -0400
Subject: [patch 1/1] selinux: Fix MLS compatibility off-by-one bug
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Ron Yorston <rmy@tigress.co.uk>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 11 Apr 2006 12:53:06 -0400
Message-Id: <1144774386.20422.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Ron Yorston <rmy@tigress.co.uk>

This patch fixes an off-by-one error in the MLS compatibility code
that was causing contexts with a MLS suffix to be rejected, preventing
sharing partitions between FC4 and FC5.  Bug reported in  
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188068
Please apply, for 2.6.17 if possible.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@redhat.com>

---

 security/selinux/ss/mls.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16/security/selinux/ss/mls.c.selinux-debug	2006-04-06 19:47:15.000000000 +0100
+++ linux-2.6.16/security/selinux/ss/mls.c	2006-04-06 19:47:24.000000000 +0100
@@ -264,7 +264,7 @@ int mls_context_to_sid(char oldc,
 
 	if (!selinux_mls_enabled) {
 		if (def_sid != SECSID_NULL && oldc)
-			*scontext += strlen(*scontext);
+			*scontext += strlen(*scontext)+1;
 		return 0;
 	}
 

-- 
Stephen Smalley
National Security Agency

