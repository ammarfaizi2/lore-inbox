Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWITShw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWITShw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWITShw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:37:52 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:28516 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932229AbWITShu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:37:50 -0400
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: rohitseth@google.com
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <1158774657.8574.65.camel@galaxy.corp.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>
	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>
	 <451173B5.1000805@yahoo.com.au>
	 <1158774657.8574.65.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 20:37:42 +0200
Message-Id: <1158777463.28174.37.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 10:50 -0700, Rohit Seth wrote:
> On Thu, 2006-09-21 at 03:00 +1000, Nick Piggin wrote:
> > (this time to the lists as well)
> > 
> > Peter Zijlstra wrote:
> > 
> >  > I'd much rather containterize the whole reclaim code, which should not
> >  > be too hard since he already adds a container pointer to struct page.
> > 
> > 
> 
> Right now the memory handler in this container subsystem is written in
> such a way that when existing kernel reclaimer kicks in, it will first
> operate on those (container with pages over the limit) pages first.  But
> in general I like the notion of containerizing the whole reclaim code.

Patch 5/5 seems to have a horrid deactivation scheme.

> >  > I still have to reread what Rohit does for file backed pages, that gave
> >  > my head a spin.
> 
> Please let me know if there is any specific part that isn't making much
> sense.

Well, the whole over the limit handler is quite painfull, having taken a
second reading it isn't all that complex after all, just odd.

You just start invalidating whole files for file backed pages. Granted,
this will get you below the threshold. but you might just have destroyed
your working set.

Pretty much the same for you anonymous memory handler, you scan through
the pages in linear fashion and demote the first that you encounter.

Both things pretty thoroughly destroy the existing kernel reclaim.

