Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWGRPMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWGRPMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGRPMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:12:20 -0400
Received: from dvhart.com ([64.146.134.43]:16309 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932265AbWGRPMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:12:20 -0400
Message-ID: <44BCFA4D.9030300@mbligh.org>
Date: Tue, 18 Jul 2006 11:12:13 -0400
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
References: <1153167857.31891.78.camel@lappy>  <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com> <1153224998.2041.15.camel@lappy> <Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com> <44BCE86A.4030602@mbligh.org> <Pine.LNX.4.64.0607180657160.30887@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607180657160.30887@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 18 Jul 2006, Martin J. Bligh wrote:
> 
> 
>>Someone remind me why we can't remove the memlocked pages from the LRU
>>again? Apart from needing a refcount of how many times they're memlocked
>>(or we just shove them back whenever they're unlocked, and let it fall
>>out again when we walk the list, but that doesn't fix the accounting
>>problem).
> 
> 
> We simply do not unmap memlocked pages (see try_to_unmap). And therefore
> they are not reclaimable.

The point is that they're still going to be included in your counts.


> On Tue, 18 Jul 2006, Andrew Morton wrote:
>>> Christoph Lameter <clameter@sgi.com> wrote:
>>>> > What other types of non freeable pages could exist?
>>> 
>>> PageWriteback() pages (potentially all of memory)
> 
> Doesnt write throttling take care of that?
> 
>>> Pinned pages (various transient conditions, mainly get_user_pages())
> 
> Hmm....
> 
>>> Some pages whose buffers are attached to an ext3 journal.
> 
> These are just pinned by an increased refcount right?
> 
>>> Possibly NFS unstable pages.
> 
> These are tracked by NR_NFS_UNSTABLE.
> 
> Maybe we need a NR_UNSTABLE that includes pinned pages?

The point of what we decided on Sunday was that we want to count the
pages that we KNOW are easy to free. So all of these should be
taken out of the count before we take it.

M.


