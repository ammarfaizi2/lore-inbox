Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWHDKGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWHDKGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 06:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHDKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 06:06:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4524 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030321AbWHDKGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 06:06:05 -0400
Date: Fri, 4 Aug 2006 20:05:50 +1000
From: Nathan Scott <nathans@sgi.com>
To: jesper.juhl@gmail.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060804200549.A2414667@wobbly.melbourne.sgi.com>
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com>; from jesper.juhl@gmail.com on Fri, Aug 04, 2006 at 10:22:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:22:21AM +0200, Jesper Juhl wrote:
> I just hit a BUG that looks XFS related.
> 
> The machine is running 2.6.18-rc3-git3
> 
> (more info below the BUG messages)
> 

Thanks for reporting, Jesper - is it reproducible?  Could you try this
patch for me?  We had a couple of other reports of this, but the earlier
reporters have vanished ... could you let me know if this helps?

cheers.

-- 
Nathan

--- fs/xfs/xfs_alloc.c.orig	2006-08-04 20:00:34.333456250 +1000
+++ fs/xfs/xfs_alloc.c	2006-08-04 20:00:50.586472000 +1000
@@ -1949,14 +1949,8 @@ xfs_alloc_fix_freelist(
 		 * the restrictions correctly.  Can happen for free calls
 		 * on a completely full ag.
 		 */
-		if (targs.agbno == NULLAGBLOCK) {
-			if (!(flags & XFS_ALLOC_FLAG_FREEING)) {
-				xfs_trans_brelse(tp, agflbp);
-				args->agbp = NULL;
-				return 0;
-			}
+		if (targs.agbno == NULLAGBLOCK)
 			break;
-		}
 		/*
 		 * Put each allocated block on the list.
 		 */
