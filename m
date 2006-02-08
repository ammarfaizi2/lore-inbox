Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWBHFFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWBHFFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWBHFFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:05:52 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:5005 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030337AbWBHFFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:05:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] mm: implement swap prefetching
Date: Wed, 8 Feb 2006 16:06:19 +1100
User-Agent: KMail/1.8.3
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@osdl.org, ck@vds.kolivas.org
References: <200602071028.30721.kernel@kolivas.org> <200602071502.41456.kernel@kolivas.org> <20060207204655.f1c69875.pj@sgi.com>
In-Reply-To: <20060207204655.f1c69875.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081606.19656.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 03:46 pm, Paul Jackson wrote:
> Con, responding to Nick:
> > > It introduces global cacheline bouncing in pagecache allocation and
> > > removal and page reclaim paths, also low watermark failure is quite
> > > common in normal operation, so that is another global cacheline write
> > > in page allocation path.
> >
> > None of these issues is going to remotely the target audience. If the
> > issue is how scalable such a change can be then I cannot advocate making
> > the code smart and complex enough to be numa and cpuset aware.. but then
> > that's never going to be the target audience. It affects a particular
> > class of user which happens to be quite a large population not affected
> > by complex memory hardware.
>
> How about only moving memory back to the Memory Node (zone) that it
> came from?  And providing some call that Christoph Lameters migration
> code can call, to disable or fix this up, so you don't end up bringing
> back pages on their pre-migration nodes?

Sounds good, and this is what I was hoping to be able to do; first I need to 
see the best time and place to get this information (and learn some more 
about the code).

> Just honoring the memory node placement should be sufficient.  No need
> to wrap your head around cpusets.

Phew. 

> If you don't do that, then consider disabling this thing entirely
> if CONFIG_NUMA is enabled.  This swap prefetching sounds like it
> could be a loose canon ball in a NUMA box.

That's probably a less satisfactory option since NUMA isn't that rare with the 
light numa of commodity hardware.

> As for non-NUMA boxes, like my humble desktop PC, I would -love-
> to have Firefox come back up faster in the morning.  I have a nightly
> cron jobs push everything out to swap, and it is slow going getting it
> back.
>
> The day will come (it has already gotten there for some of my
> colleagues who are using a small Altix system for their desktop
> software) when we want this prefetching for NUMA boxes too.

I do see that now. Thanks for your comments too.

Cheers,
Con
