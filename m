Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbUJZGcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbUJZGcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUJZGcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:32:53 -0400
Received: from almesberger.net ([63.105.73.238]:5136 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261917AbUJZGcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:32:51 -0400
Date: Tue, 26 Oct 2004 03:32:41 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] make buffer head argument of buffer_##name "const"
Message-ID: <20041026033241.B7983@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is embarrassingly simple. Unfortunately, it doesn't meet
the requirements for the patch monkey, so here goes a "regular"
submission.

I've checked that the argument of test_bit is indeed "const" on
all architectures. The patch is for 2.6.9.

- Werner

---------------------------------- cut here -----------------------------------

Signed-off-by: Werner Almesberger <werner@almesberger.net>

--- linux-2.6.9/include/linux/buffer_head.h.orig	Tue Oct 26 02:57:54 2004
+++ linux-2.6.9/include/linux/buffer_head.h	Tue Oct 26 02:21:04 2004
@@ -76,7 +76,7 @@
 {									\
 	clear_bit(BH_##bit, &(bh)->b_state);				\
 }									\
-static inline int buffer_##name(struct buffer_head *bh)			\
+static inline int buffer_##name(const struct buffer_head *bh)		\
 {									\
 	return test_bit(BH_##bit, &(bh)->b_state);			\
 }

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
