Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUDFXEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263905AbUDFXEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:04:23 -0400
Received: from [64.62.253.241] ([64.62.253.241]:53519 "EHLO staidm.org")
	by vger.kernel.org with ESMTP id S263836AbUDFXEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:04:22 -0400
Date: Mon, 5 Apr 2004 23:31:31 -0700
From: Bryan Rittmeyer <bryan@staidm.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink core hashes on small systems
Message-ID: <20040406063131.GA5186@staidm.org>
References: <20040405204957.GF6248@waste.org> <20040405140223.2f775da4.akpm@osdl.org> <20040405211916.GH6248@waste.org> <20040405143824.7f9b7020.akpm@osdl.org> <20040405225911.GJ6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405225911.GJ6248@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 05:59:11PM -0500, Matt Mackall wrote:
> On the large end, we obviously have diminishing returns for larger
> hashes and lots of dirty cachelines for hash misses. We almost
> certainly want sublinear growth here, but sqrt might be too
> aggressive.

Hand wavy.

Memory size is not necessarily predictive of optimal hash size;
certain embedded workloads may want huge TCP hashes but
render farms may only need a few dozen dentries. Why not
just start small and rehash when chains get too long (or too short)?
That gives better cache behavior _and_ memory usage at the
expensive of increased latency during rehash. Maybe that's OK?

> For 2.7, I've been thinking about pulling out a generic lookup API,
> which would allow replacing hashing with something like rbtree, etc.,
> depending on space and performance criterion.

rbtrees have different performance characteristics than a hash, and
hashing seems pretty optimal in the places it's currently used.
But, I'd love to be wrong if it means a faster kernel.

-Bryan

