Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWBMVLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWBMVLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWBMVLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:11:45 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:16090 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030186AbWBMVLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:11:42 -0500
Date: Mon, 13 Feb 2006 13:11:30 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v25
In-Reply-To: <Pine.LNX.4.62.0602131256000.3026@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0602131309120.2608@qynat.qvtvafvgr.pbz>
References: <200602120141.46084.kernel@kolivas.org>
 <Pine.LNX.4.62.0602131256000.3026@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Christoph Lameter wrote:

> spare ram when swapping??? We are already under memory pressure. Why make
> it worse by getting rid of the few bits of available memory? If a system
> swaps then we are per definition in the bad performance range. Add more
> memory.

when a program exits it's memory is now free, rather then just waiting 
until something uses this memory up normally, this patch attempts to fill 
that memory with things that are expected to be useful (things that were 
swapped out)

this won't be a win in all cases by any means, but if it uses disk 
bandwidth that would otherwise be idle and memory that is empty (and is at 
the tail of the LRU list so it's the first to be thrown away) the cost of 
doing this should be close to zero.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

