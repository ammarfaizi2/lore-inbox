Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbTAYIYO>; Sat, 25 Jan 2003 03:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTAYIYO>; Sat, 25 Jan 2003 03:24:14 -0500
Received: from main.gmane.org ([80.91.224.249]:31705 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265777AbTAYIYN>;
	Sat, 25 Jan 2003 03:24:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Andres Salomon" <dilinger@voxel.net>
Subject: Re: 2.5.59-mm5
Date: Sat, 25 Jan 2003 03:33:24 -0500
Message-ID: <pan.2003.01.25.08.33.21.351761@voxel.net>
References: <20030123195044.47c51d39.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Cc: linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My atyfb_base.c compile fix (from 2.5.54) still hasn't found its way into
any of the main kernel trees.  The original patch generates a reject
against 2.5.59-mm5, so here's an updated patch.


On Thu, 23 Jan 2003 19:50:44 -0800, Andrew Morton wrote:

> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm5/
> 
> .  -mm3 and -mm4 were not announced - they were sync-up patches as we
>   worked on the I/O scheduler.
> 
> .  -mm5 has the first cut of Nick Piggin's anticipatory I/O scheduler.
>   Here's the scoop:
> 
[...]
> 
> anticipatory_io_scheduling-2_5_59-mm3.patch
>   Subject: [PATCH] 2.5.59-mm3 antic io sched
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/


--- a/drivers/video/aty/atyfb_base.c    2003-01-25 03:02:35.000000000 -0500
+++ b/drivers/video/aty/atyfb_base.c    2003-01-25 03:21:48.000000000 -0500
@@ -2587,12 +2587,12 @@
	if (info->screen_base)
		iounmap((void *) info->screen_base);
 #ifdef __BIG_ENDIAN
-	if (info->cursor && par->cursor->ram)
+	if (par->cursor && par->cursor->ram)
		iounmap(par->cursor->ram);
 #endif
 #endif
-	if (info->cursor)
-		kfree(info->cursor);
+	if (par->cursor)
+		kfree(par->cursor);
 #ifdef __sparc__
	if (par->mmap_map)
		kfree(par->mmap_map);

