Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVKBPCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVKBPCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVKBPCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:02:38 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:56963 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965070AbVKBPCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:02:37 -0500
To: Ingo Molnar <mingo@elte.hu>
cc: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 
In-reply-to: Your message of Wed, 02 Nov 2005 13:00:48 +0100.
             <20051102120048.GA10081@elte.hu> 
Date: Wed, 02 Nov 2005 07:02:23 -0800
Message-Id: <E1EXK87-0008JB-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2005 13:00:48 +0100, Ingo Molnar wrote:
> 
> * Gerrit Huizenga <gh@us.ibm.com> wrote:
> 
> > 
> > On Wed, 02 Nov 2005 11:41:31 +0100, Ingo Molnar wrote:
> > > 
> > > * Gerrit Huizenga <gh@us.ibm.com> wrote:
> > > 
> > > > > generic unpluggable kernel RAM _will not work_.
> > > > 
> > > > Actually, it will.  Well, depending on terminology.
> > > 
> > > 'generic unpluggable kernel RAM' means what it says: any RAM seen by the 
> > > kernel can be unplugged, always. (as long as the unplug request is 
> > > reasonable and there is enough free space to migrate in-use pages to).
> >  
> >  Okay, I understand your terminology.  Yes, I can not point to any
> >  particular piece of memory and say "I want *that* one" and have that
> >  request succeed.  However, I can say "find me 50 chunks of memory
> >  of your choosing" and have a very good chance of finding enough
> >  memory to satisfy my request.
> 
> but that's obviously not 'generic unpluggable kernel RAM'. It's very 
> special RAM: RAM that is free or easily freeable. I never argued that 
> such RAM is not returnable to the hypervisor.
 
 Okay - and 'generic unpluggable kernel RAM' has not been a goal for
 the hypervisor based environments.  I believe it is closer to being
 a goal for those machines which want to hot-remove DIMMs or physical
 memory, e.g. those with IA64 machines wishing to remove entire nodes.

> > > reliable unmapping of "generic kernel RAM" is not possible even in a 
> > > virtualized environment. Think of the 'live pointers' problem i outlined 
> > > in an earlier mail in this thread today.
> > 
> >  Yeah - and that isn't what is being proposed here.  The goal is to 
> >  ask the kernel to identify some memory which can be legitimately 
> >  freed and hasten the freeing of that memory.
> 
> but that's very easy to identify: check the free list or the clean 
> list(s). No defragmentation necessary. [unless the unit of RAM mapping 
> between hypervisor and guest is too coarse (i.e. not 4K pages).]

 Ah, but the hypervisor often manages large page sizes, e.g. 64 MB.
 It doesn't manage page rights for each guest OS at the 4 K granularity.
 Hypervisors are theoretically light in terms of memory needs and
 general footprint.  Picture the overhead of tracking rights/permissions
 of each page of memory and its assignment to any of, say, 256 different
 guest operating systems.  For a machine of any size, that would be
 a huge amount of state for a hypervisor to maintain.  Would you
 really want a hypervisor to keep that much state?  Or is it more
 reasonably for a hypervisor to track, say, 64 MB chunks and the
 rights of that memory for a number of guest operating systems?  Even
 if the number of guests is small, the data structures for fast
 memory management would grow quickly.

gerrit
