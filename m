Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTJGLrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTJGLrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:47:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24990 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262268AbTJGLrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:47:19 -0400
Date: Tue, 7 Oct 2003 13:47:17 +0200
From: Jan Kara <jack@ucw.cz>
To: torvalds@osdl.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Quota bugfix
Message-ID: <20031007114717.GA25122@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I'm sending you a patch which should fix a problem with used-bytes
counter overflow in old quota format. The patch should apply well for
both 2.4.22 and 2.6.0-test6 kernels. Please apply.

							Honza

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota_v1.c.diff"

--- linux/fs/quota_v1.c	Tue Oct  7 12:44:00 2003
+++ linux/fs/quota_v1.c	Tue Oct  7 12:44:16 2003
@@ -21,7 +21,7 @@
 	m->dqb_curinodes = d->dqb_curinodes;
 	m->dqb_bhardlimit = d->dqb_bhardlimit;
 	m->dqb_bsoftlimit = d->dqb_bsoftlimit;
-	m->dqb_curspace = d->dqb_curblocks << QUOTABLOCK_BITS;
+	m->dqb_curspace = ((qsize_t)d->dqb_curblocks) << QUOTABLOCK_BITS;
 	m->dqb_itime = d->dqb_itime;
 	m->dqb_btime = d->dqb_btime;
 }

--y0ulUmNC+osPPQO6--
