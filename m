Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUCDPmC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUCDPmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:42:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36264 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261937AbUCDPl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:41:59 -0500
Date: Thu, 4 Mar 2004 10:41:51 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Dave McCracken <dmccr@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
In-Reply-To: <20040303160802.A30084@infradead.org>
Message-ID: <Pine.LNX.4.44.0403041040310.20043-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Christoph Hellwig wrote:
> On Wed, Mar 03, 2004 at 09:58:44AM -0600, Dave McCracken wrote:
> > It'd mean the page struct would have to have a count of the number of
> > mlock()ed regions it belongs to, and we'd have to update all the pages each
> > time we call it.
> 
> That would add another atomic_t to struct pages..

No need for that.  If a page is mlocked, it shouldn't be on any
of the LRU lists (since it can't be swapped out yadda yadda).

That means the locked count can share space in the struct page
with the list head used for the lru.

The only reason I haven't done this yet is that I didn't get
around to it...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

