Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbUDPVfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUDPVdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:33:35 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:38047 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262509AbUDPVdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:33:12 -0400
Date: Fri, 16 Apr 2004 22:32:22 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: jack@suse.cz
Subject: dqout dereference bug
Message-ID: <20040416213222.GR20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, jack@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
