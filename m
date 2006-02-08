Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbWBHQH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWBHQH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWBHQH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:07:27 -0500
Received: from ns.suse.de ([195.135.220.2]:1685 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965169AbWBHQH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:07:26 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Wed, 8 Feb 2006 17:06:26 +0100
User-Agent: KMail/1.8.2
Cc: Bharata B Rao <bharata@in.ibm.com>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <200602081645.24733.ak@suse.de> <Pine.LNX.4.62.0602080755500.908@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602080755500.908@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081706.26853.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 16:59, Christoph Lameter wrote:
> On Wed, 8 Feb 2006, Andi Kleen wrote:
> 
> > On Wednesday 08 February 2006 16:42, Christoph Lameter wrote:
> > 
> > > However, this has implications for policy_zone. This variable should store
> > > the zone that policies apply to. However, in your case this zone will vary 
> > > which may lead to all sorts of weird behavior even if we fix 
> > > bind_zonelist. To which zone does policy apply? ZONE_NORMAL or ZONE_DMA32?
> > 
> > It really needs to apply to both (currently you can't police 4GB of your 
> > memory on x86-64) But I haven't worked out a good design how to implement it yet.
> 
> So a provisional solution would be to simply ignore empty zones in 
> bind_zonelist?

That would likely prevent the crash yes (Bharata can you test?)

But of course it still has the problem of a lot of memory being unpolicied
on machines with >4GB if there's both DMA32 and NORMAL.

> Or fall back to earlier zones (which includes unpolicied  
> zones in the bind zone list?)

Or that.

Thanks,
-Andi

 
