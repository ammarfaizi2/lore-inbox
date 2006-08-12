Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWHLM7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWHLM7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 08:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWHLM7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 08:59:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:32738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964832AbWHLM7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 08:59:30 -0400
X-Authenticated: #14349625
Subject: [patch] Re: 2.6.18-rc3-mm2 - OOM storm
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060810021957.38c82311.akpm@osdl.org>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <44DAF6A4.9000004@free.fr>  <20060810021957.38c82311.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 15:07:12 +0000
Message-Id: <1155395232.5948.21.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 02:19 -0700, Andrew Morton wrote:

> It would be interesting to try disabling CONFIG_ADAPTIVE_READAHEAD -
> perhaps that got broken.

A typo was pinning pagecache.  Fixes leak encountered with rpm -qaV.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.18-rc3-mm2/mm/filemap.c.org	2006-08-12 14:04:14.000000000 +0000
+++ linux-2.6.18-rc3-mm2/mm/filemap.c	2006-08-12 14:07:53.000000000 +0000
@@ -1498,7 +1498,7 @@ retry_find:
 			page_cache_readahead_adaptive(mapping, ra,
 						file, NULL, NULL,
 						pgoff, pgoff, pgoff + 1);
-			page = find_lock_page(mapping, pgoff);
+			page = find_get_page(mapping, pgoff);
 		} else if (PageReadahead(page)) {
 			page_cache_readahead_adaptive(mapping, ra,
 						file, NULL, page,


