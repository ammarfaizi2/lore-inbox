Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933160AbVJCRN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160AbVJCRN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933159AbVJCRN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:13:29 -0400
Received: from fmr15.intel.com ([192.55.52.69]:5578 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S933157AbVJCRN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:13:28 -0400
Subject: Re: 2.6.14-rc2-mm1 (Oops, possibly Netfilter related?)
From: Rohit Seth <rohit.seth@intel.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <48080000.1128288669@[10.10.2.4]>
References: <20050921222839.76c53ba1.akpm@osdl.org>
	 <4338F136.1020404@reub.net><20050927004410.29ab9c03.akpm@osdl.org>
	 <925820000.1127847556@flay> <20051002101319.659afcde.pj@sgi.com>
	 <48080000.1128288669@[10.10.2.4]>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 03 Oct 2005 10:20:42 -0700
Message-Id: <1128360043.8472.23.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 17:13:13.0806 (UTC) FILETIME=[BCEBD6E0:01C5C83D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-02 at 14:31 -0700, Martin J. Bligh wrote:
> 
> --Paul Jackson <pj@sgi.com> wrote (on Sunday, October 02, 2005 10:13:19 -0700):
> 
> > Martin, responding to Andrew:
> >> > I've dropped that patch.  Joel Schopp is working on Mel Gorman's patches
> >> > which address fragmentation at this level.  If that code gets there then we
> >> > can take another look at
> >> > mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch.
> >> 
> >> Me no understand. We're going to deliberately cause fragmentation in order
> >> to defragment it again later ???
> > 
> > I thought that the patches of Mel Gorman and Joel Schopp were reducing
> > fragmentation, not causing it.
> 
> They were. but mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk
> seems to be going in the opposite direction.

mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk patch tries to
allocate more physical contiguous pages for pcp.  This would cause some
extra fragmentation at the higher orders but has the potential benefit
of spreading more uniformly across caches.  I agree though that for this
scheme to work nicely we should have the capability of draining the pcps
so that higher order requests can be serviced whenever possible.

-rohit

