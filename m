Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUHTQOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUHTQOe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268303AbUHTQOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:14:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18572 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268255AbUHTQOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:14:32 -0400
Date: Fri, 20 Aug 2004 12:14:17 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Alan Cox <alan@redhat.com>
cc: Arjan van de Ven <arjanv@redhat.com>, <y@redhat.com>,
       Oliver Neukum <oliver@neukum.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       <greg@kroah.com>, <linux-kernel@vger.kernel.org>, <sct@redhat.com>
Subject: Re: PF_MEMALLOC in 2.6
In-Reply-To: <20040820161018.GA2340@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0408201212530.10373-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Alan Cox wrote:
> On Fri, Aug 20, 2004 at 06:06:05PM +0200, Arjan van de Ven wrote:

> > > No, but this thread does make me consider PF_NOIO ;)
> > given that the task of this thread is to DO io ... ;)
> 
> But not to cause I/O.. what are the semantics of PF_NOIO ?

Any gfp_mask of this process gets GFP_NOIO set and other
appropriate bits cleared, so it will never cause IO but
only reclaim clean pages.

It should also not loop (too often) in alloc_pages and
try_to_free_pages...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

