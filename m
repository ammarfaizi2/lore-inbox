Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757574AbWK1WVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbWK1WVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757618AbWK1WVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:21:25 -0500
Received: from smtp-out.google.com ([216.239.45.12]:47482 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1755776AbWK1WVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:21:24 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=FzUc8nXnb+e8Lg9dync/jC4EVMasnnRV8uZpCPlbrIFrknWxbMXsD0E55//dX7F4v
	j1iccTu9feirtXE+MLRlw==
Subject: Re: [Patch1/4]: fake numa for x86_64 patch
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Mel Gorman <mel@csn.ul.ie>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611282009320.14388@skynet.skynet.ie>
References: <1164245649.29844.148.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0611271310200.11949@skynet.skynet.ie>
	 <1164651761.6619.33.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0611281321020.7436@skynet.skynet.ie>
	 <1164737207.14257.7.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0611282009320.14388@skynet.skynet.ie>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 28 Nov 2006 14:20:53 -0800
Message-Id: <1164752453.14257.60.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 21:34 +0000, Mel Gorman wrote:
> On Tue, 28 Nov 2006, Rohit Seth wrote:
> 
> > On Tue, 2006-11-28 at 13:24 +0000, Mel Gorman wrote:
> >> On Mon, 27 Nov 2006, Rohit Seth wrote:
> >>
> >>> Hi Mel,
> >>>
> >>> On Mon, 2006-11-27 at 13:18 +0000, Mel Gorman wrote:
> >>>> On Wed, 22 Nov 2006, Rohit Seth wrote:
> >>>>
> >>>>> This patch provides a IO hole size in a given address range.
> >>>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> This patch reintroduces a function that doubles up what
> >>>> absent_pages_in_range(start_pfn, end_pfn). I recognise you do this because
> >>>> you are interested in hole sizes before add_active_range() is called.
> >>>
> >>> Right.
> >>>
> >>>>
> >>>> However, what is not clear is why these patches are so specific to x86_64.
> >>>>
> >>>
> >>> Specifically in the fake numa case, we want to make sure that we don't
> >>> carve fake nodes that only have IO holes in it.  Unlike the real NUMA
> >>> case, here we don't have SRAT etc. to know the memory layout beforehand.
> >>>
> >>>
> >>>> It looks possible to do the work of functions like split_nodes_equal() in
> >>>> an architecture-independent manner using early_node_map rather than
> >>>> dealing with the arch-specific nodes array. That would open the
> >>>> possibility of providing fake nodes on more than one architecture in the
> >>>> future.
> >>>
> >>> The functions like splti_nodes_equal etc. can be abstracted out to arch
> >>> independent part.  I think the only API it needs from arch dependent
> >>> part is to find out how much real RAM is present in range without have
> >>> to first do add_active_range.
> >>>
> >>
> >> That is a problem because the ranges must be registered with
> >> add_active_range() to work out how much real RAM is present.
> >>
> >
> > Right.  And that is why I need e820_hole_size functionality. BTW, what
> > is the concern in having that function?
> >
> 
> Because it provides almost identical functionality to another function. If 
> that can be avoided, it's preferable.
> 

There are subtle difference in the way two function can be used.  They
are operating in two different environments. absent_pages work when
memory layout is already registered.  The e820_hole_size is the (low
level arch dependent) function that will be used to find out how the
memory lay out is going to be set for the cases when kernel has to
itself decide about the layout.

-rohit

