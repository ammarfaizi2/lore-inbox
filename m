Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUHNKnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUHNKnw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 06:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUHNKnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 06:43:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:20947 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266364AbUHNKmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 06:42:05 -0400
Date: Sat, 14 Aug 2004 03:41:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Willy Tarreau <willy@w.ods.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
In-Reply-To: <20040814101039.GA27163@alpha.home.local>
Message-ID: <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
 <20040814101039.GA27163@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Aug 2004, Willy Tarreau wrote:
> 
> I've just compiled and booted 2.6.8 on my dual athlon. Everything went
> OK before I logged in as a non-root user whose home is mounted from
> another linux box over NFSv3/UDP.

Damn. I think the stupid typo in fs/nfs/file.c from the fcntl f_op removal
patch is the problem.

Andrew, since I'm gone in another hour, how about you try to make a
2.6.8.1 with this, since this is clearly a good reason for one?

		Linus

--- 1.40/fs/nfs/file.c	2004-08-09 11:58:00 -07:00
+++ edited/fs/nfs/file.c	2004-08-14 03:35:11 -07:00
@@ -89,7 +89,7 @@
 	int res;
 
 	res = nfs_check_flags(filp->f_flags);
-	if (!res)
+	if (res)
 		return res;
 
 	lock_kernel();
