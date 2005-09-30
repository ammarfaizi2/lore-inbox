Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVI3Mae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVI3Mae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVI3Mae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:30:34 -0400
Received: from galileo.bork.org ([134.117.69.57]:26847 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S1030277AbVI3Mad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:30:33 -0400
Date: Fri, 30 Sep 2005 08:30:32 -0400
From: Martin Hicks <mort@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, rohit.seth@intel.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Martin Hicks <mort@sgi.com>
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in __alloc_pages
Message-ID: <20050930123031.GZ32494@localhost>
References: <20050929150155.A15646@unix-os.sc.intel.com> <719460000.1128034108@[10.10.2.4]> <20050929161118.27f9f1eb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929161118.27f9f1eb.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 29, 2005 at 04:11:18PM -0700, Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> >
> > It looks like we're now dropping into direct reclaim as the first thing
> > in __alloc_pages before even trying to kick off kswapd. When the hell
> > did that start? Or is that only meant to trigger if we're already below
> > the low watermark level?
> 
> That's all the numa goop which Martin Hicks added.  It's all disabled if
> z->reclaim_pages is zero (it is).  However we could be testing that flag a
> bit earlier, I think.
> 
> And yeah, some de-spaghettification would be nice.  Certainly before adding
> more logic.
> 
> Martin, should we take out the early zone reclaim logic?  It's all
> unreachable at present anyway.
> 

Yes, Please do.

mh


-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com
