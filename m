Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWFWRBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWFWRBY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWFWRBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:01:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4846 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751786AbWFWRBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:01:24 -0400
Date: Fri, 23 Jun 2006 10:00:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
In-Reply-To: <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0606230955230.6265@schroedinger.engr.sgi.com>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
 <1151019590.15744.144.camel@lappy> <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
 <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, Hugh Dickins wrote:

> Not even looked at the preview yet, but as far as mechanism goes,
> I'm sure it won't be worse than a few fixups away from good.

Sounds good.
 
> And have we even seen stats for it yet?  We know that it shouldn't
> affect the vast majority of loads (not mapping shared writable), but
> it won't be fixing any problem on them either; and we've had reports
> that it does fix the issue, but at what perf cost? (I may have missed)

I do not think that statistics are that important. One of the primary
advantages is that this fixes up a way to deadlock the machine through
dirtying too many pages. The other side effect is that dirty page
writeout can begin before an application terminates. We have had cases
where dirty memory was sitting for weeks in a machine because the process
did not terminate. These are major VM issues that need a resolution.

Also Peter has made the tracking configurable. So there is a way
to switch it off if it is harmful for some situations.

> Several people also have doubts as to whether it's right to be
> focussing just on shared writable here, whether the private also
> needs tweaking.  I'm undecided.  Can be considered a separate
> issue, but a cycle in -mm would help settle that question too.

You mean anonymous pages? Anonymous pages are always dirty unless
you consider swap and we currently do not take account of dirty anonymous 
pages. With swap we already have performance problems and maybe there are
additional issues to fix in that area. But these are secondary.


