Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVAFB1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVAFB1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVAFB1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:27:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47265 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262690AbVAFB1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:27:49 -0500
Date: Wed, 5 Jan 2005 20:27:22 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
In-Reply-To: <41DC7D86.8050609@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
 <20050105020859.3192a298.akpm@osdl.org> <20050105180651.GD4597@dualathlon.random>
 <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
 <20050105174934.GC15739@logos.cnet> <20050105134457.03aca488.akpm@osdl.org>
 <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Nick Piggin wrote:

> I think what Andrea is worried about is that blk_congestion_wait is 
> fairly vague, and can be a source of instability in the scanning 
> implementation.

The recent OOM kill problem has been happening:
1) with cache pressure on lowmem only, due to a block device write
2) with no block congestion at all
3) with pretty much all pageable lowmme pages in writeback state

It appears the VM has trouble dealing with the situation where
there is no block congestion to wait on...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
