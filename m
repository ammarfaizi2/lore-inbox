Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUCKSrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUCKSrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:47:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:1173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261396AbUCKSrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:47:01 -0500
Date: Thu, 11 Mar 2004 10:46:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Redeeman <lkml@metanurb.dk>
Cc: norberto+linux-kernel@bensa.ath.cx, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311104650.009a8d3e.akpm@osdl.org>
In-Reply-To: <1079028899.5327.4.camel@redeeman.linux.dk>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<1079024816.5325.2.camel@redeeman.linux.dk>
	<200403111453.20866.norberto+linux-kernel@bensa.ath.cx>
	<20040311100957.00dd6e7f.akpm@osdl.org>
	<1079028899.5327.4.camel@redeeman.linux.dk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Redeeman <lkml@metanurb.dk> wrote:
>
>  i didnt do anything more than patch with mm1, is there a patch for doing
>  that spin_unlock_irq()? :)

--- 25/fs/mpage.c~a	2004-03-11 10:46:29.000000000 -0800
+++ 25-akpm/fs/mpage.c	2004-03-11 10:46:31.000000000 -0800
@@ -672,7 +672,6 @@ mpage_writepages(struct address_space *m
 		}
 		pagevec_release(&pvec);
 	}
-	spin_unlock_irq(&mapping->tree_lock);
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
 	return ret;

_

