Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVAQSHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVAQSHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVAQSHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:07:44 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:25097 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262829AbVAQRyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:54:12 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] FAT: show current nls config even if it's default.
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
	<874qhgosrf.fsf_-_@devron.myhome.or.jp>
	<87zmz8ne5p.fsf_-_@devron.myhome.or.jp>
	<877jmcne0o.fsf_-_@devron.myhome.or.jp>
	<873bx0ndze.fsf_-_@devron.myhome.or.jp>
	<87y8eslzdq.fsf_-_@devron.myhome.or.jp>
	<87u0pglzbf.fsf_-_@devron.myhome.or.jp>
	<87pt04lz7x.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:54:04 +0900
In-Reply-To: <87pt04lz7x.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:52:50 +0900")
Message-ID: <87llaslz5v.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Default config may be setted by distributer. By this change, certainly
the user can know current NLS using by FAT.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN fs/fat/inode.c~fat_show-default fs/fat/inode.c
--- linux-2.6.11-rc1/fs/fat/inode.c~fat_show-default	2005-01-13 03:53:45.000000000 +0900
+++ linux-2.6.11-rc1-hirofumi/fs/fat/inode.c	2005-01-13 03:53:45.000000000 +0900
@@ -690,11 +690,10 @@ static int fat_show_options(struct seq_f
 		seq_printf(m, ",gid=%u", opts->fs_gid);
 	seq_printf(m, ",fmask=%04o", opts->fs_fmask);
 	seq_printf(m, ",dmask=%04o", opts->fs_dmask);
-	if (sbi->nls_disk && opts->codepage != fat_default_codepage)
+	if (sbi->nls_disk)
 		seq_printf(m, ",codepage=%s", sbi->nls_disk->charset);
 	if (isvfat) {
-		if (sbi->nls_io &&
-		    strcmp(opts->iocharset, fat_default_iocharset))
+		if (sbi->nls_io)
 			seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
 
 		switch (opts->shortname) {
_
