Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWATKQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWATKQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWATKQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:16:28 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:29361 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750778AbWATKQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:16:27 -0500
Date: Fri, 20 Jan 2006 12:16:22 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: c-otto@gmx.de
cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Kernel BUG at include/linux/gfp.h:80
Message-ID: <Pine.LNX.4.58.0601201214060.13564@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

On 1/19/06, Carsten Otto <c-otto@gmx.de> wrote:
> As indicated the sounddriver seems to have some sort of problem. I
> disabled it and now I can boot (without problems).

Does the following patch fix your problem?

			Pekka

Index: 2.6/lib/swiotlb.c
===================================================================
--- 2.6.orig/lib/swiotlb.c
+++ 2.6/lib/swiotlb.c
@@ -444,7 +444,8 @@ swiotlb_alloc_coherent(struct device *hw
 	 * instead, or use ZONE_DMA32 (ia64 overloads ZONE_DMA to be a ~32
 	 * bit range instead of a 16MB one).
 	 */
-	flags |= GFP_DMA;
+	if (!(flags & GFP_DMA32))
+		flags |= GFP_DMA;
 
 	ret = (void *)__get_free_pages(flags, order);
 	if (ret && address_needs_mapping(hwdev, virt_to_phys(ret))) {
