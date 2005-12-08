Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVLHTet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVLHTet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVLHTet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:34:49 -0500
Received: from serv01.siteground.net ([70.85.91.68]:43697 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932284AbVLHTet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:34:49 -0500
Date: Thu, 8 Dec 2005 11:34:39 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: pcibus_to_node value when no pxm info is present for the pci bus
Message-ID: <20051208193439.GB3776@localhost.localdomain>
References: <20051207223414.GA4493@localhost.localdomain> <Pine.LNX.4.62.0512081104280.29958@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512081104280.29958@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 11:05:24AM -0800, Christoph Lameter wrote:
> On Wed, 7 Dec 2005, Ravikiran G Thirumalai wrote:
> 
> > Most of the arches seem to return -1 for pcibus_to_node if there is no pxm
> > kind of proximity information for the pci busses.  Arch specific code on
> > those arches check if nodeid >= 0  before using the nodeid for kmalloc_node
> > etc. But some code paths in x86_64/i386 does not doe this --
> > x86_64/dma_alloc_pages() and e1000 node local descriptor (I am to blame for 
> > the second one).  Also, pcibus_to_node seems to be 0 when there is no pxm 
> > info available.
> 
> kmalloc_node falls back to kmalloc for node == -1. So there does not need 
> to be a check.

Ah! yes,

>  
> > The question is, what should be the default pcibus_to_node if there is no
> > pxm info? Answer seems like -1 -- in which case dma_alloc_pages and e1000
> > driver has to be fixed.
> 
> Why would they have to be fixed?

alloc_pages_node (used  by dma_alloc_pages) does not seem to do the check 
though.  I guess alloc_pages_node needs to be fixed then.

Thanks,
Kiran
