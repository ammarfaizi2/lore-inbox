Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318761AbSHLR1Z>; Mon, 12 Aug 2002 13:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318760AbSHLR0u>; Mon, 12 Aug 2002 13:26:50 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:8721 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S318758AbSHLR0n>; Mon, 12 Aug 2002 13:26:43 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix generic_file_send()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 13 Aug 2002 02:30:23 +0900
Message-ID: <874re09e8g.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sys_sendfile() call,

    do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
        in_file->f_op->sendfile(out_file, in_file, ppos, count);

But,

ssize_t generic_file_sendfile(struct file *in_file, struct file *out_file,
			      loff_t *ppos, size_t count)

fist arg of generic_file_sendfile() should be for output. This patch
fixes this typo.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- linux-2.5.31/mm/filemap.c~	2002-08-11 10:41:26.000000000 +0900
+++ linux-2.5.31/mm/filemap.c	2002-08-11 18:28:18.000000000 +0900
@@ -1109,7 +1109,7 @@
 	return written;
 }
 
-ssize_t generic_file_sendfile(struct file *in_file, struct file *out_file,
+ssize_t generic_file_sendfile(struct file *out_file, struct file *in_file,
 			      loff_t *ppos, size_t count)
 {
 	read_descriptor_t desc;
