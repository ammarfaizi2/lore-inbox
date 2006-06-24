Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWFXGzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWFXGzy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 02:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932920AbWFXGzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 02:55:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:18492 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750907AbWFXGzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 02:55:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=rfiBVo3cSfUYHEP9ZfioRhSkt5ajcyXHjJm8TTw1nEsXRm6hVAG/CPWTG2p8dYDCPE1tyjeZEYD0buv59YbCSUpjoNuNWVgw3ZlTq6y0KUj62d2yyafek16OFtc3zmvBdaOSgYO05wmG6WNth4IdPlE72KmrgiiXnZEAVSKD/WA=
Date: Sat, 24 Jun 2006 11:01:33 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH]: block_read_full_page: micro optimization
Message-Id: <20060624110133.18cdda30.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder, may be with such change kernel become little faster?

Signed-off-by: Paul Drynoff <pauldrynoff@gmail.com>

---

Index: linux-2.6.17-mm1/fs/buffer.c
===================================================================
--- linux-2.6.17-mm1.orig/fs/buffer.c
+++ linux-2.6.17-mm1/fs/buffer.c
@@ -2093,7 +2093,7 @@ int block_read_full_page(struct page *pa
 			}
 			if (!buffer_mapped(bh)) {
 				void *kaddr = kmap_atomic(page, KM_USER0);
-				memset(kaddr + i * blocksize, 0, blocksize);
+				memset(kaddr + (i << inode->i_blkbits), 0, blocksize);
 				flush_dcache_page(page);
 				kunmap_atomic(kaddr, KM_USER0);
 				if (!err)
