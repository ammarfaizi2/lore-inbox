Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWGCX3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWGCX3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWGCX3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:29:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13991 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932078AbWGCX3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:29:19 -0400
Date: Mon, 3 Jul 2006 16:26:57 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
In-Reply-To: <20060703221712.GB14273@infradead.org>
Message-ID: <Pine.LNX.4.64.0607031624210.8547@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
 <20060703221712.GB14273@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006, Christoph Hellwig wrote:

> On Mon, Jul 03, 2006 at 02:55:34PM -0700, Christoph Lameter wrote:
> > I keep seeing zones on various platforms that are never used and wonder
> > why we compile support for them into the kernel.
> > 
> > IA64 on SGI for example only uses ZONE_DMA other IA64 platforms can
> > also use ZONE_NORMAL.
> 
> Which btw is utterly wrong.  It should have a 4GB ZONE_DMA32 and everything
> else in ZONE_NORMAL.

So we want to change the definition of ZONE_DMA to refer to the first 16MB 
only? ZONE_DMA32 is always a 4GB border? (Andy disagrees about DMA32 see 
his message!).

It seems to me that DMA can be run on ZONE_NORMAL. ZONE_DMAxx is used for 
situations in which DMA cannot be done to all of memory. ZONE_DMA allows 
an architecture to define a single exception zone that ends at 
MAX_DMA_ADDRESS (which is arch specific).

