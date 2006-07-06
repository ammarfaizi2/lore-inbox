Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWGFUi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWGFUi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWGFUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:37:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19717 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750827AbWGFUh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:37:28 -0400
Date: Thu, 6 Jul 2006 22:37:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [-mm patch] reiserfs: warn about the useless nolargeio option
Message-ID: <20060706203728.GR26941@stusta.de>
References: <20060703030355.420c7155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 03:03:55AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm5:
>...
> +inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch
>...
>  Misc updates.
>...

Since the nolargeio option no longer has any effect, print a warning 
instead of setting a write-only variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/reiserfs/super.c |   21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

--- linux-2.6.17-mm6-full/fs/reiserfs/super.c.old	2006-07-06 21:48:48.000000000 +0200
+++ linux-2.6.17-mm6-full/fs/reiserfs/super.c	2006-07-06 21:51:48.000000000 +0200
@@ -721,12 +721,6 @@
 	{NULL, 0, 0},
 };
 
-int reiserfs_default_io_size = 128 * 1024;	/* Default recommended I/O size is 128k.
-						   There might be broken applications that are
-						   confused by this. Use nolargeio mount option
-						   to get usual i/o size = PAGE_SIZE.
-						 */
-
 /* proceed only one option from a list *cur - string containing of mount options
    opts - array of options which are accepted
    opt_arg - if option is found and requires an argument and if it is specifed
@@ -955,19 +949,8 @@
 		}
 
 		if (c == 'w') {
-			char *p = NULL;
-			int val = simple_strtoul(arg, &p, 0);
-
-			if (*p != '\0') {
-				reiserfs_warning(s,
-						 "reiserfs_parse_options: non-numeric value %s for nolargeio option",
-						 arg);
-				return 0;
-			}
-			if (val)
-				reiserfs_default_io_size = PAGE_SIZE;
-			else
-				reiserfs_default_io_size = 128 * 1024;
+			reiserfs_warning(s, "reiserfs: nolargeio option is no longer supported");
+			return 0;
 		}
 
 		if (c == 'j') {

