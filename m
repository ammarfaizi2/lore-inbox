Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSJJGOr>; Thu, 10 Oct 2002 02:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJJGOr>; Thu, 10 Oct 2002 02:14:47 -0400
Received: from dp.samba.org ([66.70.73.150]:13770 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263143AbSJJGOr>;
	Thu, 10 Oct 2002 02:14:47 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15781.7200.98489.515226@nanango.paulus.ozlabs.org>
Date: Thu, 10 Oct 2002 16:20:16 +1000 (EST)
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: drivers/block/rd.c compile error
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change went into drivers/block/rd.c in 2.5 recently:

diff -urN old/drivers/block/rd.c linux-2.5/drivers/block/rd.c
--- old/drivers/block/rd.c	2002-10-10 16:12:54.000000000 +1000
+++ linux-2.5/drivers/block/rd.c	2002-10-10 08:46:28.000000000 +1000
@@ -213,7 +213,7 @@
 		kunmap(vec->bv_page);
 
 		if (rw == READ) {
-			flush_dcache_page(page);
+			flush_dcache_page(sbh->b_page);
 		} else {
 			SetPageDirty(page);
 		}

The trouble with that is that there is no variable called sbh defined
in this function, rd_blkdev_pagecache_IO.  Thus we get a compile error
on PPC.  The problem wouldn't show up on x86 since flush_dcache_page
is a no-op (i.e. do { } while (0)) there.

What was the change trying to achieve?  What was wrong with
flush_dcache_page(page)?

Thanks,
Paul.
