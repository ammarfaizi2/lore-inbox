Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932910AbWFWH1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbWFWH1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWFWH1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:27:24 -0400
Received: from silver.veritas.com ([143.127.12.111]:38571 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932910AbWFWH1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:27:23 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,168,1149490800"; 
   d="scan'208"; a="39489629:sNHT24305680"
Date: Fri, 23 Jun 2006 08:27:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
In-Reply-To: <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
 <1151019590.15744.144.camel@lappy> <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Jun 2006 07:27:23.0048 (UTC) FILETIME=[78141280:01C69696]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Linus Torvalds wrote:
> On Fri, 23 Jun 2006, Peter Zijlstra wrote:
> >
> > Preview of the goodness,
> 
> Do people agree about this thing? If we want it in 2.6.18, we should merge 
> this soon. I'd prefer to not leave something like this to be a last-minute 
> thing before the merge window closes, and I get the feeling that we're 
> getting to where this should just go in sooner rather than later.
> 
> Comments? Hugh, does the last version address all your concerns?

Not even looked at the preview yet, but as far as mechanism goes,
I'm sure it won't be worse than a few fixups away from good.

However, I've never understood why it should be fasttracked into
2.6.18: we usually let such patchsets cook for a cycle in -mm.
2.6.N-rc can get wider exposure than 2.6.(N-1)-mm, reveal problems
missed all the while in -mm, but a cycle in -mm is still worthwhile.

My pathetically slow responses have hindered Peter's good work, yes,
but I don't think they've affected the overall appropriate timing.

Is there any particular reason why 2.6.18 rather than 2.6.19 be
the release that fixes this issue that's been around forever?

And have we even seen stats for it yet?  We know that it shouldn't
affect the vast majority of loads (not mapping shared writable), but
it won't be fixing any problem on them either; and we've had reports
that it does fix the issue, but at what perf cost? (I may have missed)

Several people also have doubts as to whether it's right to be
focussing just on shared writable here, whether the private also
needs tweaking.  I'm undecided.  Can be considered a separate
issue, but a cycle in -mm would help settle that question too.

But if you want to push for 2.6.18, I won't be aggrieved.

Hugh
