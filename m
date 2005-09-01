Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbVIAOSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVIAOSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbVIAOSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:18:42 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:40372 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965137AbVIAOSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:18:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Hans Kristian Rosbach <hk@isphuset.no>
Subject: Re: [PATCH][RFC] vm: swap prefetch
Date: Fri, 2 Sep 2005 00:18:32 +1000
User-Agent: KMail/1.8.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       ck list <ck@vds.kolivas.org>
References: <200509012346.33020.kernel@kolivas.org> <1125584303.25400.3.camel@linux>
In-Reply-To: <1125584303.25400.3.camel@linux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509020018.32993.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005 00:18, Hans Kristian Rosbach wrote:
> On Thu, 2005-09-01 at 23:46 +1000, Con Kolivas wrote:
> > Here is a working swap prefetching patch for 2.6.13. I have resuscitated
> > and rewritten some early prefetch code Thomas Schlichter did in late 2.5
> > to create a configurable kernel thread that reads in swap from ram in
> > reverse order it was written out. It does this once kswapd has been idle
> > for a minute (implying no current vm stress). This patch attached below
> > is a rollup of two patches the current versions of which are here:
> >
> > http://ck.kolivas.org/patches/swap-prefetch/
> >
> > These add an exclusive_timer function, and the patch that does the swap
> > prefetching. I'm posting this rollup to lkml to see what the interest is
> > in this feature, and for people to test it if they desire. I'm planning
> > on including it in the next -ck but wanted to gauge general user opinion
> > for mainline. Note that swapped in pages are kept on backing store
> > (swap), meaning no further I/O is required if the page needs to swap back
> > out.
>
> I would definitely use this if available.

Great.

> That said, I have often thought it might be good to have something like
> pre-writing swap, ie reverse what your patch does.
>
> In other words it'd keep as much of swappable data on disk as possible,
> but without removing it from memory. So when it comes time to free up
> some memory, the data is already on disk so no performance penalty from
> writing it out.
>
> Hopefully something worth thinking about.

Actually to some degree this patch does that, albeit only on things that are 
swapped out "naturally". Anything that is swapped out and is unnaturally 
swapped back in using prefetching is kept on swap, and you often find much 
more swap sitting around ready for freeing up ram whenever there is memory 
pressure again. 

Cheers,
Con
