Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWAIVEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWAIVEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAIVEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:04:11 -0500
Received: from gold.veritas.com ([143.127.12.110]:18296 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751347AbWAIVEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:04:09 -0500
Date: Mon, 9 Jan 2006 21:04:21 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Mike Christie <michaelc@cs.wisc.edu>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Doug Gilbert <dougg@torque.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm
In-Reply-To: <43C2CB3E.3070208@cs.wisc.edu>
Message-ID: <Pine.LNX.4.61.0601092057150.16617@goblin.wat.veritas.com>
References: <20060107052221.61d0b600.akpm@osdl.org> 
 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com> 
 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com> 
 <20060109175748.GD25102@redhat.com>  <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
  <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com> 
 <9a8748490601091048x46716e25u2fe2ebe9b5fbc9bb@mail.gmail.com> 
 <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com>
 <9a8748490601091139pf5fb6a0v3c8b3bcb41b85940@mail.gmail.com>
 <Pine.LNX.4.61.0601092005510.16057@goblin.wat.veritas.com> <43C2CB3E.3070208@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2006 21:04:09.0613 (UTC) FILETIME=[3C1BB3D0:01C61560]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Mike Christie wrote:
> 
> Oops yeah, that is right. We switched from __get_free_pages to alloc_pages.
> 
> Will alloc_pages() always return lowmem pages or can it return highmem pages?
> Just wondering becuase I guess if it can return highmem pages I need to
> replace the page_adress calls to kmap/kunmap ones right?

Good thinking, but the page_address patch is safe for now.  You can only
get highmem from alloc_pages if you say __GFP_HIGHMEM to it (perhaps
inside GFP_HIGHUSER), and at present you're not.  You probably should,
depending on what the underlying device can handle: at present there's
lowDma choosing GFP_DMA, and that probably should be extended to cover
other possibilities.  I'm not familiar with the driver end of these
things, James would give much better advice on how to proceed there:
or perhaps he'll advise that it's best left simply as is (with the
page_address fix) after all.

Hugh
