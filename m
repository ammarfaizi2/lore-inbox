Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUIWNPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUIWNPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268446AbUIWNPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:15:02 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:27071 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S268438AbUIWNOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:14:36 -0400
Subject: Re: 2.6.9-rc2-mm2
From: Vladimir Saveliev <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
References: <20040922131210.6c08b94c.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-Px6J2jW/PPky4+MYNV19"
Message-Id: <1095945329.6117.25.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 23 Sep 2004 17:15:29 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Px6J2jW/PPky4+MYNV19
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Thu, 2004-09-23 at 00:12, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/
> 

> +reiser4-plugin_set_done-memleak-fix.patch
> +reiser4-init-max_atom_flusers.patch
> +reiser4-parse-options-reduce-stack-usage.patch
> +reiser4-sparce64-warning-fix.patch
> +reiser4-x86_64-warning-fix.patch
> +reiser4-fix-mount-option-parsing.patch
> +reiser4-parse-option-cleanup.patch
> +reiser4-comment-fix.patch
> +reiser4-fill_super-improve-warning.patch
> +reiser4-disable-pseudo.patch
> +reiser4-disable-repacker.patch
> 

Sorry, please replace reiser4-disable-repacker.patch with the attached
one.

>  reiser4 update
> 


--=-Px6J2jW/PPky4+MYNV19
Content-Disposition: attachment; filename=reiser4-disable-repacker.patch
Content-Type: text/plain; name=reiser4-disable-repacker.patch; charset=
Content-Transfer-Encoding: 7bit


This disables reiser4 online repacker.


 fs/reiser4/repacker.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN fs/reiser4/repacker.c~reiser4-disable-repacker fs/reiser4/repacker.c
--- linux-2.6.9-rc2-mm1/fs/reiser4/repacker.c~reiser4-disable-repacker	2004-09-18 13:07:01.852728941 +0400
+++ linux-2.6.9-rc2-mm1-vs/fs/reiser4/repacker.c	2004-09-23 14:01:45.738053471 +0400
@@ -624,6 +624,7 @@ static void done_repacker_sysfs_interfac
 
 reiser4_internal int init_reiser4_repacker (struct super_block *super)
 {
+#if defined(REISER4_REPACKER)
 	reiser4_super_info_data * sinfo = get_super_private(super);
 
 	assert ("zam-946", sinfo->repacker == NULL);
@@ -640,10 +641,14 @@ reiser4_internal int init_reiser4_repack
 	kcond_init(&sinfo->repacker->cond);
 
 	return init_repacker_sysfs_interface(super);
+#else
+	return 0;
+#endif /*REISER4_REPACKER*/
 }
 
 reiser4_internal void done_reiser4_repacker (struct super_block *super)
 {
+#if defined(REISER4_REPACKER)
 	reiser4_super_info_data * sinfo = get_super_private(super);
 	struct repacker * repacker;
 
@@ -658,4 +663,5 @@ reiser4_internal void done_reiser4_repac
 
 	kfree(repacker);
 	sinfo->repacker = NULL;
+#endif /*REISER4_REPACKER*/
 }

_

--=-Px6J2jW/PPky4+MYNV19--

