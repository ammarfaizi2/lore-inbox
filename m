Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVI3BwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVI3BwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVI3BwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:52:16 -0400
Received: from fmr13.intel.com ([192.55.52.67]:31425 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751423AbVI3BwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:52:15 -0400
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in
	__alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Martin Hicks <mort@sgi.com>
In-Reply-To: <20050929161118.27f9f1eb.akpm@osdl.org>
References: <20050929150155.A15646@unix-os.sc.intel.com>
	 <719460000.1128034108@[10.10.2.4]>  <20050929161118.27f9f1eb.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 29 Sep 2005 18:58:25 -0700
Message-Id: <1128045505.3735.31.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 01:50:54.0241 (UTC) FILETIME=[64BB1910:01C5C561]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 16:11 -0700, Andrew Morton wrote:
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
...yeah just like sys_set_zone_reclaim.  was it intended to be added as
a system call?

-rohit

