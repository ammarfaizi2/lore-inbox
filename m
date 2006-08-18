Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbWHRQ5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbWHRQ5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWHRQ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:57:52 -0400
Received: from smtp-out.google.com ([216.239.45.12]:38104 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030492AbWHRQ5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:57:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=le774lh+2OwohJc/sWaOi5zO9N4AjHn6y+VtNixrq3lYI623nD4/HtuyI2OSIJvjn
	3iesCyWMF7xn7qFo78U7w==
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E58A89.8040001@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>
	 <1155834136.14617.29.camel@galaxy.corp.google.com> <44E58A89.8040001@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 18 Aug 2006 09:55:58 -0700
Message-Id: <1155920158.22899.8.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 13:38 +0400, Kirill Korotaev wrote:
> Rohit Seth wrote:
> > On Thu, 2006-08-17 at 17:27 +0400, Kirill Korotaev wrote:
> > 
> >>>If I'm reading this patch right then seems like you are making page
> >>>allocations to fail w/o (for example) trying to purge some pages from
> >>>the page cache belonging to this container.  Or is that reclaim going to
> >>>come later?
> >>
> >>charged kernel objects can't be _reclaimed_. how do you propose
> >>to reclaim tasks page tables or files or task struct or vma or etc.?
> > 
> > 
> > 
> > I agree that kernel objects cann't be reclaimed easily.  But what you
> > are proposing is also not right.  Returning failure w/o doing any
> > reclaim on pages (that are reclaimable) is not useful.  And this is why
> > I asked, is this change going to be part of next set of patches (as
> > current set of patches are only tracking kernel usage).

> 1. reclaiming user resources is not that good idea as it looks to you.
> such solutions end up with lots of resources spent on reclaim.
> for user memory reclaims mean consumption of expensive disk I/O bandwidth
> which reduces overall system throughput and influences other users.
> 

May be I'm overlooking something very obvious.  Please tell me, what
happens when a user hits a page fault and the page allocator is easily
able to give a page from its pcp list.  But container is over its limit
of physical memory.  In your patch there is no attempt by container
support to see if some of the user pages are easily reclaimable.  What
options a user will have to make sure some room is created.

> 2. kernel memory is mostly not reclaimable. can you reclaim vma structs or ipc ids?

I'm not arguing about that at all.  If people want to talk about
reclaiming kernel pages then that should be done independent of this
subject.



-rohit

