Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTLLMAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 07:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTLLMAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 07:00:34 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:63678 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264539AbTLLMAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 07:00:33 -0500
Date: Fri, 12 Dec 2003 07:00:30 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mem: and Swap: lines in /proc/meminfo
In-Reply-To: <20031211230511.GI15401@matchmail.com>
Message-ID: <Pine.LNX.4.44.0312120658001.17287-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Mike Fedyk wrote:

> > Note that the inactive clean pages count (more or less)
> > as free pages, too.
> 
> But I should count it as "Inactive" right?

Yeah.

> So, if it's clean, then the page has already been zeroed out, and is
> ready to be used but just needs some flags updated?  Or they contain
> possibly useful data, and just are not dirty?

The latter.

> So a page that is inactive, but not dirty will go directly in that
> list?

No, LRU ordering is preserved.  The inactive clean list is just the
last stage before the page really gets freed.

> What can happen to Inact_clean pages besides being freed, and used on
> the free memory list?

The data that's still in the page could be referenced again, in which
case the page gets moved to the inactive dirty list and from there on
to the active list.

In effect, the inactive clean list is a "soft free" list, which means
we can keep a larger number of pages almost-free, without wasting
memory.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

