Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751994AbWCJTQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbWCJTQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbWCJTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:16:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64397 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751994AbWCJTQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:16:09 -0500
Date: Fri, 10 Mar 2006 11:16:04 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Magnus Damm <magnus@valinux.co.jp>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 01/03] Unmapped: Implement two LRU:s
In-Reply-To: <20060310034417.8340.49483.sendpatchset@cherry.local>
Message-ID: <Pine.LNX.4.64.0603101113210.28805@schroedinger.engr.sgi.com>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
 <20060310034417.8340.49483.sendpatchset@cherry.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2006, Magnus Damm wrote:

> Use separate LRU:s for mapped and unmapped pages.
> 
> This patch creates two instances of "struct lru" per zone, both protected by
> zone->lru_lock. A new bit in page->flags named PG_mapped is used to determine
> which LRU the page belongs to. The rmap code is changed to move pages to the 
> mapped LRU, while the vmscan code moves pages back to the unmapped LRU when 
> needed. Pages moved to the mapped LRU are added to the inactive list, while
> pages moved back to the unmapped LRU are added to the active list.

The swapper moves pages to the unmapped list? So the mapped LRU 
lists contains unmapped pages? That would get rid of the benefit that I 
saw from this scheme. Pretty inconsistent.


