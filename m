Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbULXAVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbULXAVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 19:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbULXAVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 19:21:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:21731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261342AbULXAVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 19:21:36 -0500
Date: Thu, 23 Dec 2004 16:25:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix mm/rmap.c build failure if CONFIG_SWAP is not
 defined (2.6.10-rc3-bk16)
Message-Id: <20041223162553.15783f1c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412240037211.3504@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412240037211.3504@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> I just tried a allnoconfig build of 2.6.10-rc3-bk16, and it fails on 
> mm/rmap.c since swap_token_default_timeout is not defined by 
> include/linux/swap.h if CONFIG_SWAP is not defined.

yup.  I have this queued up:

--- 25/include/linux/swap.h~fix-config_swap-n-build	Thu Dec 23 14:34:08 2004
+++ 25-akpm/include/linux/swap.h	Thu Dec 23 14:34:08 2004
@@ -269,6 +269,7 @@ static inline void put_swap_token(struct
 #define move_from_swap_cache(p, i, m)		1
 #define __delete_from_swap_cache(p)		/*NOTHING*/
 #define delete_from_swap_cache(p)		/*NOTHING*/
+#define swap_token_default_timeout		0
 
 static inline int remove_exclusive_swap_page(struct page *p)
 {


