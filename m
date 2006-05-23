Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWEWGcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWEWGcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 02:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWEWGcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 02:32:00 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:3712 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932108AbWEWGcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 02:32:00 -0400
Date: Mon, 22 May 2006 23:35:00 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>, chrisw@sous-sol.org,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuset: remove extra cpuset_zone_allowed check in __alloc_pages
Message-ID: <20060523063500.GB18769@moss.sous-sol.org>
References: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com> <20060522182356.fbea4aec.pj@sgi.com> <Pine.LNX.4.64.0605221858250.7165@schroedinger.engr.sgi.com> <20060522192248.b114fea3.pj@sgi.com> <Pine.LNX.4.64.0605221925350.7272@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605221925350.7272@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is redundant with check in wakeup_kswapd.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 mm/page_alloc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -951,8 +951,7 @@ restart:
 		goto got_pg;
 
 	do {
-		if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
-			wakeup_kswapd(*z, order);
+		wakeup_kswapd(*z, order);
 	} while (*(++z));
 
 	/*
