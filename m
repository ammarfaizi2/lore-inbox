Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVDLSC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVDLSC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVDLKct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:32:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:64455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262114AbVDLKbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:03 -0400
Message-Id: <200504121030.j3CAUuQ9005183@shell0.pdx.osdl.net>
Subject: [patch 018/198] end_buffer_write_sync() avoid pointless assignments
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/buffer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/buffer.c~end_buffer_write_sync-avoid-pointless-assignments fs/buffer.c
--- 25/fs/buffer.c~end_buffer_write_sync-avoid-pointless-assignments	2005-04-12 03:21:07.702965872 -0700
+++ 25-akpm/fs/buffer.c	2005-04-12 03:21:07.707965112 -0700
@@ -2838,14 +2838,14 @@ void ll_rw_block(int rw, int nr, struct 
 
 		get_bh(bh);
 		if (rw == WRITE) {
-			bh->b_end_io = end_buffer_write_sync;
 			if (test_clear_buffer_dirty(bh)) {
+				bh->b_end_io = end_buffer_write_sync;
 				submit_bh(WRITE, bh);
 				continue;
 			}
 		} else {
-			bh->b_end_io = end_buffer_read_sync;
 			if (!buffer_uptodate(bh)) {
+				bh->b_end_io = end_buffer_read_sync;
 				submit_bh(rw, bh);
 				continue;
 			}
_
