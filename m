Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUEBA5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUEBA5I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUEBA5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:57:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:23773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262866AbUEBA5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:57:05 -0400
Date: Sat, 1 May 2004 17:56:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pasi Savolainen <psavo@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1
Message-Id: <20040501175642.565bbb47.akpm@osdl.org>
In-Reply-To: <slrnc98gnc.cgh.psavo@varg.dyndns.org>
References: <20040430014658.112a6181.akpm@osdl.org>
	<slrnc98gnc.cgh.psavo@varg.dyndns.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Savolainen <psavo@iki.fi> wrote:
>
>  I've also wondered a bit about slabtop, is this really OK for half-a-day
>  uptime and not really changing since?:
> 
>    OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>  348220 348135  99%    0.19K  17411       20     69644K dentry_cache
>  313138 313049  99%    0.50K  44734        7    178936K ext3_inode_cache
>   10530   7354  69%    0.05K    135       78       540K buffer_head

2.6.6-rc3-mm1 is totally broken in the slab-shrinking area (sorry).

--- 25/mm/vmscan.c~shrink_slab-handle-GFP_NOFS-fix	2004-05-01 14:34:25.446391008 -0700
+++ 25-akpm/mm/vmscan.c	2004-05-01 14:34:37.424570048 -0700
@@ -156,7 +156,7 @@ static int shrink_slab(unsigned long sca
 			shrinker->nr = LONG_MAX;	/* It wrapped! */
 
 		if (shrinker->nr <= SHRINK_BATCH)
-			break;
+			continue;
 		while (shrinker->nr) {
 			long this_scan = shrinker->nr;
 			int shrink_ret;

_

