Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVAFDmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVAFDmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 22:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVAFDmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 22:42:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262709AbVAFDmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 22:42:39 -0500
Date: Wed, 5 Jan 2005 22:42:11 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
In-Reply-To: <20050105173624.5c3189b9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
 <20050105020859.3192a298.akpm@osdl.org> <20050105180651.GD4597@dualathlon.random>
 <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
 <20050105174934.GC15739@logos.cnet> <20050105134457.03aca488.akpm@osdl.org>
 <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au>
 <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>
 <20050105173624.5c3189b9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:

>> The recent OOM kill problem has been happening:
>> 1) with cache pressure on lowmem only, due to a block device write
>> 2) with no block congestion at all
>> 3) with pretty much all pageable lowmme pages in writeback state
>
> You must have a wild number of requests configured in the queue.  Is 
> this CFQ?

Yes, it is with CFQ.  Around 650MB of lowmem is in writeback
stage, which is over 99% of the active and inactive lowmem
pages...

> I've done testing with "all of memory under writeback" before and it 
> went OK.  It's certainly a design objective to handle this well.  But 
> that testing was before we broke it.

I suspect something might still be broken.  It may take a few
days of continuous testing to trigger the bug, though ...

> The bug which you fixed would cause the VM to scan itself to death 
> without throttling.  Did the fix fix things?

Mostly fixed.  Things are down to the point where it often
takes over a day to bring out the bug.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
