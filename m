Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbUBBPkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 10:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUBBPkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 10:40:07 -0500
Received: from witte.sonytel.be ([80.88.33.193]:65432 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265673AbUBBPkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 10:40:01 -0500
Date: Mon, 2 Feb 2004 16:39:54 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/inode.c warning if !HIGHMEM (was: Re: Linux 2.4.25-pre5)
In-Reply-To: <Pine.GSO.4.58.0401191611460.551@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0402021638211.19699@waterleaf.sonytel.be>
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
 <Pine.GSO.4.58.0401191611460.551@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Geert Uytterhoeven wrote:
> On Thu, 15 Jan 2004, Marcelo Tosatti wrote:
> > Summary of changes from v2.4.25-pre4 to v2.4.25-pre5
> > ============================================
> >
> > Rik van Riel:
> >   o Reclaim inodes with highmem pages when low on memory
>
> This introduces a warning when compiling fs/inode.c if CONFIG_HIGHMEM is not
> set, since in that case avg_pages is defined but not used.

And it's still there in -pre8. This patch kills the warning:

--- linux-2.4.25-pre8/fs/inode.c.orig	2004-01-24 19:55:47.000000000 +0100
+++ linux-2.4.25-pre8/fs/inode.c	2004-01-24 21:20:54.000000000 +0100
@@ -790,7 +790,10 @@
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
-	int count, avg_pages;
+	int count;
+#ifdef CONFIG_HIGHMEM
+	int avg_pages;
+#endif
 	struct inode * inode;

 	spin_lock(&inode_lock);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
