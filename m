Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030578AbWBHXXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbWBHXXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbWBHXXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:23:52 -0500
Received: from ns2.suse.de ([195.135.220.15]:58860 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030578AbWBHXXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:23:52 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation
Date: Wed, 8 Feb 2006 23:41:01 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, pj@sgi.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com> <20060208133909.183f19ea.akpm@osdl.org> <Pine.LNX.4.62.0602081402310.4735@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602081402310.4735@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602082341.02243.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 23:11, Christoph Lameter wrote:
> On Wed, 8 Feb 2006, Andrew Morton wrote:
> 
> > > I think it should be put into 2.6.16. Andrew?
> > 
> > Does every single caller of __alloc_pages(__GFP_FS) correctly handle a NULL
> > return?  I doubt it, in which case this patch will cause oopses and hangs.
> 
> I sent you a patch with static inline.....

noinline 

> But I am having second thoughts  
> about this patch. Paul is partially right. Maybe we can move the logic 
> into the out_of_memory handler for now? That would allow us to implement 
> more sophisticated things later 

I have my doubts that's really worth it, but ok.

> (for example page migration would allow us 
> to move memory of processes that can also allocate on other nodes from the 
> nodes where we lack memory) and Paul may put something in there to 
> address his concerns.
> 
> ---
> 
> Terminate process that fails on a constrained allocation

Patch looks good for me too.  Thanks.

Unfortunately Andrew's point with the GFP_NOFS still applies :/
But I would consider any caller of this not handling NULL be broken.
Andrew do you have any stronger evidence it's a real problem?

Another way would be to force a default non strict policy with GFP_NOFS, but
that would be somewhat ugly again and impact the fast paths.

-Andi
