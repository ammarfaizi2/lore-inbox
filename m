Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVHWIqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVHWIqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 04:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVHWIqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 04:46:49 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11725 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932094AbVHWIqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 04:46:49 -0400
Date: Tue, 23 Aug 2005 11:46:33 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: Pekka Enberg <penberg@gmail.com>, nathans@sgi.com, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, greg@kroah.com, hch@infradead.org
Subject: [PATCH] mm: return ENOBUFS instead of ENOMEM in generic_file_buffered_write
In-Reply-To: <20050823012839.649645c2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0508231145060.30649@sbz-30.cs.Helsinki.FI>
References: <11394.1124781401@kao2.melbourne.sgi.com>
 <200508190055.25747.dtor_core@ameritech.net> <20050823073258.GE743@frodo>
 <84144f02050823005573569fcb@mail.gmail.com> <20050823012839.649645c2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As noticed by Dmitry Torokhov, write() can not return ENOMEM:

http://www.opengroup.org/onlinepubs/000095399/functions/write.html

Therefore fixup generic_file_buffered_write() in mm/filemap.c (pointed out by
Nathan Scott).

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 filemap.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-mm/mm/filemap.c
===================================================================
--- 2.6-mm.orig/mm/filemap.c
+++ 2.6-mm/mm/filemap.c
@@ -1942,7 +1942,7 @@ generic_file_buffered_write(struct kiocb
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {
-			status = -ENOMEM;
+			status = -ENOBUFS;
 			break;
 		}
 
