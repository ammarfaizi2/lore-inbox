Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbULIXHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbULIXHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbULIXHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:07:39 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34466 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261659AbULIXHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:07:34 -0500
Date: Thu, 9 Dec 2004 15:07:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12: rss tasklist vs sloppy rss
In-Reply-To: <20041209225259.GG2714@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0412091500360.1102@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
 <Pine.LNX.4.58.0412091348130.7478@schroedinger.engr.sgi.com>
 <20041209225259.GG2714@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004, William Lee Irwin III wrote:
> Unless the algorithms being compared are properly implemented, they're
> straw men, not valid comparisons.

Sloppy rss left the rss in the section of mm that contained the counters.
So that has a separate cacheline. The idea of putting the atomic ops in a
group was to only have one exclusive cacheline for mmap_sem and the rss.
Which could lead to more bouncing of a single cache line rather than
bouncing multiple cache lines less. But it seems to me that the problem
essentially remains the same if the rss counter is not split.
