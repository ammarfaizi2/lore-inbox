Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUJHWYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUJHWYs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUJHWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:24:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:60103 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265900AbUJHWYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:24:46 -0400
Date: Fri, 8 Oct 2004 15:24:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041008152430.R2357@build.pdx.osdl.net>
References: <1096669179.27818.29.camel@krustophenia.net> <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us> <1097193102.9372.25.camel@krustophenia.net> <1097269108.1442.53.camel@krustophenia.net> <20041008144539.K2357@build.pdx.osdl.net> <1097272140.1442.75.camel@krustophenia.net> <20041008145252.M2357@build.pdx.osdl.net> <1097273105.1442.78.camel@krustophenia.net> <20041008151911.Q2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041008151911.Q2357@build.pdx.osdl.net>; from chrisw@osdl.org on Fri, Oct 08, 2004 at 03:19:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(relative to last one)

use in_group_p

--- security/realtime.c~cap_bprm_set	2004-10-08 15:21:03.835639904 -0700
+++ security/realtime.c	2004-10-08 15:23:13.574916536 -0700
@@ -60,26 +60,15 @@
 MODULE_PARM_DESC(mlock, " enable memory locking privileges.");
 
 /* helper function for testing group membership */
-static inline int gid_ok(int gid, int e_gid) {
-	int i;
-	int rt_ok = 0;
-
+static inline int gid_ok(int gid, int e_gid)
+{
 	if (gid == -1)
 		return 0;
 
 	if ((gid == e_gid) || (gid == current->gid))
 		return 1;
 
-	get_group_info(current->group_info);
-	for (i = 0; i < current->group_info->ngroups; ++i) {
-		if (gid == GROUP_AT(current->group_info, i)) {
-			rt_ok = 1;
-			break;
-		}
-	}
-	put_group_info(current->group_info);
-
-	return rt_ok;
+	return in_group_p(gid);
 }
 
 int realtime_bprm_set_security(struct linux_binprm *bprm)
