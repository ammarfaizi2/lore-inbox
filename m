Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbUDSNLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUDSNLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:11:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17881 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264380AbUDSNLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:11:44 -0400
Date: Mon, 19 Apr 2004 15:11:43 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: dqout dereference bug
Message-ID: <20040419131143.GF27169@atrey.karlin.mff.cuni.cz>
References: <20040416213222.GR20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416213222.GR20937@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Yes, the patch is right. The case sb == NULL should not happen but
it's always good to have clean code :). Linus/Andrew please apply.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


--- linux-2.6.5/fs/dquot.c~	2004-04-16 22:30:05.000000000 +0100
+++ linux-2.6.5/fs/dquot.c	2004-04-16 22:30:48.000000000 +0100
@@ -1145,11 +1145,13 @@
 int vfs_quota_off(struct super_block *sb, int type)
 {
 	int cnt;
-	struct quota_info *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt;
 
 	if (!sb)
 		goto out;
 
+	dqopt = sb_dqopt(sb);
+
 	/* We need to serialize quota_off() for device */
 	down(&dqopt->dqonoff_sem);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
