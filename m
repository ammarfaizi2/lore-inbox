Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUCTTuy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbUCTTuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:50:51 -0500
Received: from waste.org ([209.173.204.2]:25232 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263519AbUCTTuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:50:44 -0500
Date: Sat, 20 Mar 2004 13:50:39 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] make inflate work with gcc3.5 and 4k stacks
Message-ID: <20040320195039.GT11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick fix to work around gcc3.5's automatic inline and broken stack
requirements calculation. Without this, I see stack overflows at boot
with 4k stacks.

gcc3.5 - fix inflate inlining

 tiny-mpm/lib/inflate.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN lib/inflate.c~inflate-noinline lib/inflate.c
--- tiny/lib/inflate.c~inflate-noinline	2004-03-20 13:39:18.000000000 -0600
+++ tiny-mpm/lib/inflate.c	2004-03-20 13:40:13.000000000 -0600
@@ -686,7 +686,7 @@ DEBG("<stor");
 
 
 
-STATIC int inflate_fixed(void)
+STATIC int noinline inflate_fixed(void)
 /* decompress an inflated type 1 (fixed Huffman codes) block.  We should
    either replace this with a custom decoder, or at least precompute the
    Huffman tables. */
@@ -740,7 +740,7 @@ DEBG("<fix");
 
 
 
-STATIC int inflate_dynamic(void)
+STATIC int noinline inflate_dynamic(void)
 /* decompress an inflated type 2 (dynamic Huffman codes) block. */
 {
   int i;                /* temporary variables */

_


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
