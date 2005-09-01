Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVIAOPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVIAOPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVIAOPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:15:11 -0400
Received: from mx5.mailserveren.com ([213.236.237.251]:10440 "EHLO
	mx5.mailserveren.com") by vger.kernel.org with ESMTP
	id S965129AbVIAOPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:15:10 -0400
Subject: Re: [PATCH][RFC] vm: swap prefetch
From: Hans Kristian Rosbach <hk@isphuset.no>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       ck list <ck@vds.kolivas.org>
In-Reply-To: <200509012346.33020.kernel@kolivas.org>
References: <200509012346.33020.kernel@kolivas.org>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Date: Thu, 01 Sep 2005 16:18:23 +0200
Message-Id: <1125584303.25400.3.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 23:46 +1000, Con Kolivas wrote: 
> Here is a working swap prefetching patch for 2.6.13. I have resuscitated and 
> rewritten some early prefetch code Thomas Schlichter did in late 2.5 to 
> create a configurable kernel thread that reads in swap from ram in reverse 
> order it was written out. It does this once kswapd has been idle for a minute 
> (implying no current vm stress). This patch attached below is a rollup of two 
> patches the current versions of which are here:
> 
> http://ck.kolivas.org/patches/swap-prefetch/
> 
> These add an exclusive_timer function, and the patch that does the swap 
> prefetching. I'm posting this rollup to lkml to see what the interest is in 
> this feature, and for people to test it if they desire. I'm planning on 
> including it in the next -ck but wanted to gauge general user opinion for 
> mainline. Note that swapped in pages are kept on backing store (swap), 
> meaning no further I/O is required if the page needs to swap back out.

I would definitely use this if available.

That said, I have often thought it might be good to have something like
pre-writing swap, ie reverse what your patch does.

In other words it'd keep as much of swappable data on disk as possible,
but without removing it from memory. So when it comes time to free up
some memory, the data is already on disk so no performance penalty from
writing it out.

Hopefully something worth thinking about.

-HK

