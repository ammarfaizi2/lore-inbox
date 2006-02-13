Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWBMVQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWBMVQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWBMVQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:16:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35035 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030183AbWBMVQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:16:11 -0500
Date: Mon, 13 Feb 2006 13:16:00 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: David Lang <dlang@digitalinsight.com>
cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v25
In-Reply-To: <Pine.LNX.4.62.0602131309120.2608@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.62.0602131313250.3110@schroedinger.engr.sgi.com>
References: <200602120141.46084.kernel@kolivas.org>
 <Pine.LNX.4.62.0602131256000.3026@schroedinger.engr.sgi.com>
 <Pine.LNX.4.62.0602131309120.2608@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, David Lang wrote:

> On Mon, 13 Feb 2006, Christoph Lameter wrote:
> > spare ram when swapping??? We are already under memory pressure. Why make
> > it worse by getting rid of the few bits of available memory? If a system
> > swaps then we are per definition in the bad performance range. Add more
> > memory.
> when a program exits it's memory is now free, rather then just waiting until
> something uses this memory up normally, this patch attempts to fill that
> memory with things that are expected to be useful (things that were swapped
> out)

Then trigger this action when a program exits and when you know there was 
enough freed up to justify such an action. However, this is still a 
heuristic. No one knows if the pages read from swap will be of any use at 
all. For all I know a process may want to allocate some memory and fail 
because the memory was needlessly spend to read in pages that no one 
needs.

