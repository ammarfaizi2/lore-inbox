Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262978AbTCWIp3>; Sun, 23 Mar 2003 03:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262980AbTCWIp3>; Sun, 23 Mar 2003 03:45:29 -0500
Received: from holomorphy.com ([66.224.33.161]:12695 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262978AbTCWIp0>;
	Sun, 23 Mar 2003 03:45:26 -0500
Date: Sun, 23 Mar 2003 00:56:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com, rwhron@earthlink.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm2 vs 2.5.65-mm3 (full objrmap)
Message-ID: <20030323085608.GI1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	dmccr@us.ibm.com, rwhron@earthlink.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <370130000.1048381666@[10.10.2.4]> <Pine.LNX.4.44.0303230723210.1595-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303230723210.1595-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 08:14:12AM +0000, Hugh Dickins wrote:
> I build with highpte on one machine for testing purposes, I don't have
> enough memory for it actually to be important.  I'm almost always
> working with Andrew's trees, so was using shpte when it was in, but
> not since.  I like the idea of shpte (and the UKVA idea), I couldn't
> see its constituency - the small processes immediately needed to cow
> all their page tables, and the large ones should have been using
> huge pages instead (or such was my misperception).

There's some recent benchmark data from hrandoz showing shpte is
actually doing very well on the speed front lately.

As far as constituency goes I mostly see unintelligent forking servers
(unfortunately these are all too common and tend not to cooperate by
using hugetlb etc.) and smaller machines wanting various trimmings from
kernel memory consumption benefitting. I personally see 2-3MB of
pagetable memory savings from it with end-user workstation loads (X,
xterms, xmms, web browsers, very little dynamic fork()/exec()'ing etc.),
which IMHO is a substantial reduction of the runtime footprint of the
kernel. It alone also conserves 5-6MB of pte_chains in addition to ptes
w/o objrmap. I've also overheard strong interest from software vendors.

-- wli
