Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269868AbTGKKag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269869AbTGKKag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:30:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269868AbTGKKaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:30:35 -0400
Date: Fri, 11 Jul 2003 03:45:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: rathamahata@php4.ru, linux-kernel@vger.kernel.org
Subject: Re: [Bug 898] New: Very HIGH File & VM system latencies and system
 stop responding while extracting big tar  archive file.
Message-Id: <20030711034510.30065dc2.akpm@osdl.org>
In-Reply-To: <3F0E8A22.6020700@cyberone.com.au>
References: <111930000.1057904059@[10.10.2.4]>
	<200307111346.39731.rathamahata@php4.ru>
	<3F0E8A22.6020700@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> You're sure 2.5.74 got processes stuck in D? That means its possibly
>  a driver bug. If you can get 2.5.75 to hang, please also try with
>  elevator=deadline. Thank you.

No, this will be the reiserfs bug.

--- 25/fs/reiserfs/tail_conversion.c~reiserfs-dirty-memory-fix	2003-07-10 22:22:54.000000000 -0700
+++ 25-akpm/fs/reiserfs/tail_conversion.c	2003-07-10 22:22:54.000000000 -0700
@@ -191,7 +191,7 @@ unmap_buffers(struct page *page, loff_t 
 	bh = next ;
       } while (bh != head) ;
       if ( PAGE_SIZE == bh->b_size ) {
-	ClearPageDirty(page);
+	clear_page_dirty(page);
       }
     }
   } 

_

