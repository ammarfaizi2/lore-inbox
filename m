Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUJHWTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUJHWTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUJHWTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:19:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:5060 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265773AbUJHWTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:19:30 -0400
Date: Fri, 8 Oct 2004 15:19:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041008151911.Q2357@build.pdx.osdl.net>
References: <20041001142259.I1924@build.pdx.osdl.net> <1096669179.27818.29.camel@krustophenia.net> <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us> <1097193102.9372.25.camel@krustophenia.net> <1097269108.1442.53.camel@krustophenia.net> <20041008144539.K2357@build.pdx.osdl.net> <1097272140.1442.75.camel@krustophenia.net> <20041008145252.M2357@build.pdx.osdl.net> <1097273105.1442.78.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1097273105.1442.78.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 08, 2004 at 06:05:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

relative to last one.

--- security/realtime.c~module_param	2004-10-08 15:03:41.000000000 -0700
+++ security/realtime.c	2004-10-08 15:18:40.627410864 -0700
@@ -84,12 +84,8 @@
 
 int realtime_bprm_set_security(struct linux_binprm *bprm)
 {
-	/* Copied from security/commoncap.c: cap_bprm_set_security()... */
-	/* Copied from fs/exec.c:prepare_binprm. */
-	/* We don't have VFS support for capabilities yet */
-	cap_clear(bprm->cap_inheritable);
-	cap_clear(bprm->cap_permitted);
-	cap_clear(bprm->cap_effective);
+
+	cap_bprm_set_security(bprm);
 
 	/*  If a non-zero `any' parameter was specified, we grant
 	 *  realtime privileges to every process.  If the `gid'
@@ -104,28 +100,10 @@
 		if (mlock) {
 			cap_raise(bprm->cap_effective, CAP_IPC_LOCK);
 			cap_raise(bprm->cap_permitted, CAP_IPC_LOCK);
-			cap_raise(bprm->cap_effective,
-				  CAP_SYS_RESOURCE);
-			cap_raise(bprm->cap_permitted,
-				  CAP_SYS_RESOURCE);
+			cap_raise(bprm->cap_effective, CAP_SYS_RESOURCE);
+			cap_raise(bprm->cap_permitted, CAP_SYS_RESOURCE);
 		}
 	}
-
-	/*  To support inheritance of root-permissions and suid-root
-	 *  executables under compatibility mode, we raise all three
-	 *  capability sets for the file.
-	 *
-	 *  If only the real uid is 0, we only raise the inheritable
-	 *  and permitted sets of the executable file.
-	 */
-
-	if (bprm->e_uid == 0 || current->uid == 0) {
-		cap_set_full(bprm->cap_inheritable);
-		cap_set_full(bprm->cap_permitted);
-	}
-	if (bprm->e_uid == 0)
-		cap_set_full(bprm->cap_effective);
-
 	return 0;
 }
 
