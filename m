Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSLBFYO>; Mon, 2 Dec 2002 00:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbSLBFYO>; Mon, 2 Dec 2002 00:24:14 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:12680 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264907AbSLBFYO>;
	Mon, 2 Dec 2002 00:24:14 -0500
Date: Mon, 2 Dec 2002 16:31:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Zou Pengcheng <pczou@redflag-linux.com>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: Re: [PATCH] dnotify fix for readv/writev (Linux 2.4.20)
Message-Id: <20021202163111.560d218d.sfr@canb.auug.org.au>
In-Reply-To: <200212020922.43820.pczou@redflag-linux.com>
References: <200212020922.43820.pczou@redflag-linux.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 2 Dec 2002 09:22:43 +0800 Zou Pengcheng <pczou@redflag-linux.com> wrote:
>
> this is a patch to fix the dnotify bug of readv/writev. 
> 
> Orignally DN_MODIFY is issued on readv while DN_ACCESS is issued on writev, 
> which is obviously wrong. This patch fixes such problem.
> 
> cheers,
>   -- Pengcheng Zou

This is the equivalent patch for 2.5.50+.

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK/fs/read_write.c 2.5.50-BK-dnotify/fs/read_write.c
--- 2.5.50-BK/fs/read_write.c	2002-12-02 16:25:50.000000000 +1100
+++ 2.5.50-BK-dnotify/fs/read_write.c	2002-12-02 16:28:39.000000000 +1100
@@ -447,7 +447,7 @@
 		kfree(iov);
 	if ((ret + (type == READ)) > 0)
 		dnotify_parent(file->f_dentry,
-				(type == READ) ? DN_MODIFY : DN_ACCESS);
+				(type == READ) ? DN_ACCESS : DN_MODIFY);
 	return ret;
 }
 
