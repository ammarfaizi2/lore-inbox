Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbULPMCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbULPMCU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 07:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbULPMCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 07:02:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14469 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262652AbULPMBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:01:51 -0500
Date: Thu, 16 Dec 2004 07:14:57 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: krmurthy@cisco.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Limiting memory allocated by buffer cache in 2.4 kernel
Message-ID: <20041216091457.GA8246@logos.cnet>
References: <013901c4e2b4$bd041ad0$f8074d0a@apac.cisco.com> <200412150956.23799.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412150956.23799.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 09:56:23AM -0800, Jesse Barnes wrote:
> On Wednesday, December 15, 2004 6:45 am, N.C.Krishna Murthy (krmurthy) wrote:
> > Hi,
> >  I am using linux 2.4.22 kernel. Is there any way to limit the amount
> > of memory allocated by buffer cache? Eariler versions used to have
> > /proc/sys/vm/buffermem.

Nope, there is no such feature. 

It may have worked in v2.2 (not sure about that though, have you checked?) but 
it surely doesnt in v2.4.

> For that matter, is there a way to do this in 2.6?  We've seen problems caused 
> by huge page caches pushing data allocations off-node, so it would be really 
> nice to have a limit control...

v2.6 doesnt have such feature either. 

Shouldnt be too hard to add hooks at page_cache_alloc()/page_cache_alloc_cold()  
level for dropping clean unmapped pages off the tail of the LRU once a given
limit is reached. Andrew ?
