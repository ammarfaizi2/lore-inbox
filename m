Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbUCKI12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUCKI12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:27:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23434 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262845AbUCKI1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:27:01 -0500
Date: Thu, 11 Mar 2004 09:26:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311082657.GG6955@suse.de>
References: <20040310233140.3ce99610.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10 2004, Andrew Morton wrote:
> - Major surgery against the pagecache, radix-tree and writeback code.  This
>   work is to address the O_DIRECT-vs-buffered data exposure horrors which
>   we've been struggling with for months.

[snip]

Looks extremely kick ass! mpage is has a left-over spin_unlock in there
though, I need this to boot:

--- /opt/kernel/linux-2.6.4-mm1/fs/mpage.c	2004-03-11 09:10:02.070434880 +0100
+++ fs/mpage.c	2004-03-11 09:23:19.718019755 +0100
@@ -672,7 +672,6 @@
 		}
 		pagevec_release(&pvec);
 	}
-	spin_unlock_irq(&mapping->tree_lock);
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
 	return ret;

-- 
Jens Axboe

