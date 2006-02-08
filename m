Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWBHErI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWBHErI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWBHErI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:47:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30406 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030222AbWBHErH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:47:07 -0500
Date: Tue, 7 Feb 2006 20:46:55 -0800
From: Paul Jackson <pj@sgi.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@osdl.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
Message-Id: <20060207204655.f1c69875.pj@sgi.com>
In-Reply-To: <200602071502.41456.kernel@kolivas.org>
References: <200602071028.30721.kernel@kolivas.org>
	<43E80F36.8020209@yahoo.com.au>
	<200602071502.41456.kernel@kolivas.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con, responding to Nick:
> > It introduces global cacheline bouncing in pagecache allocation and removal
> > and page reclaim paths, also low watermark failure is quite common in
> > normal operation, so that is another global cacheline write in page
> > allocation path.
> 
> None of these issues is going to remotely the target audience. If the issue is 
> how scalable such a change can be then I cannot advocate making the code 
> smart and complex enough to be numa and cpuset aware.. but then that's never 
> going to be the target audience. It affects a particular class of user which 
> happens to be quite a large population not affected by complex memory 
> hardware.

How about only moving memory back to the Memory Node (zone) that it
came from?  And providing some call that Christoph Lameters migration
code can call, to disable or fix this up, so you don't end up bringing
back pages on their pre-migration nodes?

Just honoring the memory node placement should be sufficient.  No need
to wrap your head around cpusets.

If you don't do that, then consider disabling this thing entirely
if CONFIG_NUMA is enabled.  This swap prefetching sounds like it
could be a loose canon ball in a NUMA box.

As for non-NUMA boxes, like my humble desktop PC, I would -love-
to have Firefox come back up faster in the morning.  I have a nightly
cron jobs push everything out to swap, and it is slow going getting it
back.

The day will come (it has already gotten there for some of my
colleagues who are using a small Altix system for their desktop
software) when we want this prefetching for NUMA boxes too.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
