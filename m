Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTEYMnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbTEYMnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 08:43:31 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:37896 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S262073AbTEYMna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 08:43:30 -0400
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm9
Date: Sun, 25 May 2003 14:56:33 +0200
User-Agent: KMail/1.5.2
References: <20030525042759.6edacd62.akpm@digeo.com>
In-Reply-To: <20030525042759.6edacd62.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305251456.39404.rudmer@legolas.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 May 2003 13:27, Andrew Morton wrote:
>
> . 2.5.69-mm9 is not for the timid.  It includes extensive changes to the
>   ext3 filesystem and the JBD layer.  It withstood an hour of testing on my
>   4-way, but it probably has a couple of holes still.

there seems to be no problem, it survives a kernel compile.
Only the patch for fs/buffer.c seems to be reverted, it was there in -mm8
(original patch by wli, adjusted to cleanly apply against -mm9)

	Rudmer


--- linux-2.5.69-mm9/fs/buffer.c.orig	2003-05-25 14:33:53.000000000 +0200
+++ linux-2.5.69-mm9/fs/buffer.c	2003-05-25 14:34:51.000000000 +0200
@@ -1505,6 +1505,7 @@
 		bh = __bread_slow(bh);
 	return bh;
 }
+EXPORT_SYMBOL(__bread);
 
 
 struct buffer_head *
@@ -1517,7 +1518,7 @@
 		bh = __bread_slow_wq(bh, wait);
 	return bh;
 }
-EXPORT_SYMBOL(__bread);
+EXPORT_SYMBOL(__bread_wq);
 
 /*
  * invalidate_bh_lrus() is called rarely - at unmount.  Because it is only 
for
--- linux-2.5.69-mm9/kernel/ksyms.c.orig	2003-05-25 14:34:45.000000000 +0200
+++ linux-2.5.69-mm9/kernel/ksyms.c	2003-05-25 14:34:51.000000000 +0200
@@ -123,6 +123,7 @@
 EXPORT_SYMBOL(init_mm);
 EXPORT_SYMBOL(blk_queue_bounce);
 EXPORT_SYMBOL(blk_congestion_wait);
+EXPORT_SYMBOL(blk_congestion_wait_wq);
 #ifdef CONFIG_HIGHMEM
 EXPORT_SYMBOL(kmap_high);
 EXPORT_SYMBOL(kunmap_high);
@@ -216,6 +217,7 @@
 EXPORT_SYMBOL(submit_bh);
 EXPORT_SYMBOL(unlock_buffer);
 EXPORT_SYMBOL(__wait_on_buffer);
+EXPORT_SYMBOL(__wait_on_buffer_wq);
 EXPORT_SYMBOL(blockdev_direct_IO);
 EXPORT_SYMBOL(block_write_full_page);
 EXPORT_SYMBOL(block_read_full_page);

