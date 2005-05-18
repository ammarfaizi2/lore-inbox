Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVERWnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVERWnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVERWnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:43:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:5275 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262392AbVERWm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:42:58 -0400
Date: Thu, 19 May 2005 00:42:56 +0200
From: Andi Kleen <ak@suse.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050518224256.GF1250@wotan.suse.de>
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <20050513132945.GB16088@wotan.suse.de> <20050513155241.GA3522@redhat.com> <20050518220120.GJ2596@hygelac> <20050518220356.GC1250@wotan.suse.de> <20050518221540.GK2596@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518221540.GK2596@hygelac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 05:15:40PM -0500, Terence Ripperda wrote:
> On Thu, May 19, 2005 at 12:03:56AM +0200, ak@suse.de wrote:
> > > right now I think there were a lot of excessive printouts for
> > > debugging purposes. I also have no doubts that there are coding style
> > > differences that need to be cleaned up (feel free to tell me when my code
> > > sucks or isn't up to style).
> > 
> > Perhaps should concentrate on the basic design first.
> 
> sure, feel free to tell me if that sucks as well :)

The main thing I am not sure about in the basic design was
the overlapping handling. I suspect that needs to be discussed
again, perhaps even with input from some CPU vendor people.

My feeling is that overlapping is not good and should be avoided.

Then we need a user interface for the X server too, which
also needs to be designed. /proc/bus/pci/*/* has some ioctls
for this on other platforms that might be adapted (common
interface would be best of course), but I am
not sure the code is powerful enough for everything PAT offers.
Probably needs some enhancements (do we really want to support
the obscure PAT settings like write protect though?)

Do we need to handle the fixed range legacy MTRRs too?

It would be better to move the "range list using rbtree" code somewhere
into lib. It certainly seems to be needed often (I did my own
version for the NUMA policies ;-) and it doesn't make
much sense to duplicate all the time. iirc there is at least another
patch pending with a similar datastructure. 

I suppose you saw the list I sent to Dave. These are the things
that came to mind while reading it. I haven't gone over everything
in detail though.

I hope to have some time soon to go over all of this more closely.

-Andi
