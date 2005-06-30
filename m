Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVF3RmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVF3RmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 13:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbVF3RmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 13:42:24 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:62667 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262756AbVF3RmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 13:42:17 -0400
Message-ID: <42C42EFD.8050306@namesys.com>
Date: Thu, 30 Jun 2005 10:42:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Edward Shishkin <edward@namesys.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiser BUG in 2.6.13-rc1
References: <20050630101157.GI2243@suse.de>
In-Reply-To: <20050630101157.GI2243@suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>Hi,
>
>Reiser is derefencing an uninitialized pointer, causing an oops on boot.
>
>Signed-off-by: Jens Axboe <axboe@suse.de>
>
>diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
>--- a/fs/reiserfs/super.c
>+++ b/fs/reiserfs/super.c
>@@ -1053,10 +1053,9 @@ static void handle_barrier_mode(struct s
> 
> static void handle_attrs( struct super_block *s )
> {
>-	struct reiserfs_super_block * rs;
>+	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
> 
> 	if( reiserfs_attrs( s ) ) {
>-		rs = SB_DISK_SUPER_BLOCK (s);
> 		if( old_format_only(s) ) {
> 			reiserfs_warning(s, "reiserfs: cannot support attributes on 3.5.x disk format" );
> 			REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
>
>  
>
Thanks Jens.

Edward, how is the fedora boot bug finding going? Is this it by any chance?

Hans
