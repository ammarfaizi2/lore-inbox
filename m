Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUCDRDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUCDRDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:03:41 -0500
Received: from waste.org ([209.173.204.2]:12449 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262017AbUCDRDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:03:40 -0500
Date: Thu, 4 Mar 2004 11:03:05 -0600
From: Matt Mackall <mpm@selenic.com>
To: Rik van Riel <riel@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave McCracken <dmccr@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040304170305.GL3883@waste.org>
References: <20040303160802.A30084@infradead.org> <Pine.LNX.4.44.0403041040310.20043-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403041040310.20043-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 10:41:51AM -0500, Rik van Riel wrote:
> On Wed, 3 Mar 2004, Christoph Hellwig wrote:
> > On Wed, Mar 03, 2004 at 09:58:44AM -0600, Dave McCracken wrote:
> > > It'd mean the page struct would have to have a count of the number of
> > > mlock()ed regions it belongs to, and we'd have to update all the pages each
> > > time we call it.
> > 
> > That would add another atomic_t to struct pages..
> 
> No need for that.  If a page is mlocked, it shouldn't be on any
> of the LRU lists (since it can't be swapped out yadda yadda).
> 
> That means the locked count can share space in the struct page
> with the list head used for the lru.

And we can drop the VM_RESERVED flag, which is currently used in a
bunch of places where it's not on lists already.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
