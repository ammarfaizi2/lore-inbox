Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968656AbWLET0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968656AbWLET0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968657AbWLET0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:26:00 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43265 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968656AbWLETZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:25:59 -0500
Date: Tue, 5 Dec 2006 11:25:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Mel Gorman <mel@skynet.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
Message-Id: <20061205112541.2a4b7414.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612050754560.11213@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie>
	<20061130173129.4ebccaa2.akpm@osdl.org>
	<Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>
	<20061201110103.08d0cf3d.akpm@osdl.org>
	<20061204140747.GA21662@skynet.ie>
	<20061204113051.4e90b249.akpm@osdl.org>
	<Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
	<20061204120611.4306024e.akpm@osdl.org>
	<Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
	<20061204131959.bdeeee41.akpm@osdl.org>
	<Pine.LNX.4.64.0612041337520.851@schroedinger.engr.sgi.com>
	<20061204142259.3cdda664.akpm@osdl.org>
	<Pine.LNX.4.64.0612050754560.11213@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 08:00:39 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Mon, 4 Dec 2006, Andrew Morton wrote:
> 
> > > > What happens when we need to run reclaim against just a section of a zone?
> > > > Lumpy-reclaim could be used here; perhaps that's Mel's approach too?
> > > 
> > > Why would we run reclaim against a section of a zone?
> > 
> > Strange question.  Because all the pages are in use for something else.
> 
> We always run reclaim against the whole zone not against parts. Why 
> would we start running reclaim against a portion of a zone?

Oh for gawd's sake.

If you want to allocate a page from within the first 1/4 of a zone, and if
all those pages are in use for something else then you'll need to run
reclaim against the first 1/4 of that zone.  Or fail the allocation.  Or
run reclaim against the entire zone.  The second two options are
self-evidently dumb.


