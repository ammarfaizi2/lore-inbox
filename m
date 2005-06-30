Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVF3KKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVF3KKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVF3KKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:10:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6076 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262867AbVF3KK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:10:29 -0400
Date: Thu, 30 Jun 2005 12:11:59 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] reiser BUG in 2.6.13-rc1
Message-ID: <20050630101157.GI2243@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Reiser is derefencing an uninitialized pointer, causing an oops on boot.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1053,10 +1053,9 @@ static void handle_barrier_mode(struct s
 
 static void handle_attrs( struct super_block *s )
 {
-	struct reiserfs_super_block * rs;
+	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
 
 	if( reiserfs_attrs( s ) ) {
-		rs = SB_DISK_SUPER_BLOCK (s);
 		if( old_format_only(s) ) {
 			reiserfs_warning(s, "reiserfs: cannot support attributes on 3.5.x disk format" );
 			REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );

-- 
Jens Axboe

