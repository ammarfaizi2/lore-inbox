Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUCKIb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbUCKIb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:31:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:7861 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262902AbUCKIaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:30:24 -0500
Date: Thu, 11 Mar 2004 00:30:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311003023.6ae87569.akpm@osdl.org>
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
References: <20040310233140.3ce99610.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/

Needs this fix, if you use CONFIG_DEBUG_SPINLOCK

--- 25/fs/mpage.c~mpage-locking-bug	2004-03-11 00:29:21.000000000 -0800
+++ 25-akpm/fs/mpage.c	2004-03-11 00:29:25.000000000 -0800
@@ -672,7 +672,6 @@ mpage_writepages(struct address_space *m
 		}
 		pagevec_release(&pvec);
 	}
-	spin_unlock_irq(&mapping->tree_lock);
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
 	return ret;

_

