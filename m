Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTJHQBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 12:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTJHQBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 12:01:05 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:47196 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261699AbTJHQBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 12:01:02 -0400
Date: Wed, 8 Oct 2003 11:59:06 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Matt_Domsch@Dell.com, <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <Pine.LNX.4.44.0310081648560.3138-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310081156320.5568-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, Hugh Dickins wrote:
> On Wed, 8 Oct 2003 Matt_Domsch@Dell.com wrote:

> > We've seen a similar failure with the RHEL2.1 kernel w/o RMAP patches
> > too.  So we fully believe it's possible in stock 2.4.x.
> 
> A similar failure - but what exactly?
> And what is the actual race which would account for it?
> 
> I don't mind you and Rik fixing bugs!
> I'd just like to understand the bug before it's fixed.

1) cpu A adds page P to the swap cache, loading page->flags
   and modifying it locally

2) a second thread scans a page table entry and sees that
   the page was accessed, so cpu B moves page P to the
   active list

3) cpu A undoes the PG_inactive -> PG_active bit change,
   corrupting the page->flags of P

The -rmap VM doesn't do anything to this bug, except making
it easy to trigger due to some side effects.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

