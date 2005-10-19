Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVJSSHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVJSSHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVJSSHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:07:11 -0400
Received: from serv01.siteground.net ([70.85.91.68]:53984 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751106AbVJSSHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:07:10 -0400
Date: Wed, 19 Oct 2005 11:07:02 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Alex Williamson <alex.williamson@hp.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051019180702.GA3680@localhost.localdomain>
References: <20051018232203.GB4535@localhost.localdomain> <1129684966.17545.50.camel@lts1.fc.hp.com> <20051019212041.6378.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019212041.6378.Y-GOTO@jp.fujitsu.com>
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

On Wed, Oct 19, 2005 at 09:47:02PM +0900, Yasunori Goto wrote:
> > On Tue, 2005-10-18 at 16:22 -0700, Ravikiran G Thirumalai wrote:
> 
> 
> Hmm.....
> How is this patch? This is another way.
> 
> I think that true issue is there is no way for requester to
> specify maxmum address at __alloc_bootmem_core().
> 
> "goal" is just to keep space lower address as much as possible.
> and __alloc_bootmem_core() doesn't care about max address for requester.
> I suppose it is a bit strange. The swiotlb's case is good example
> by it.

This works for me too.  After this patch I see
[  400.495902] Placing software IO TLB between 0x722a000 - 0xb22a000
which means, the new patch is not digging into the 16MB x86_64 DMA area too. 

Linus would you apply this for 2.6.14?  This is the patch which works for
both x86_64 and ia64 boxes.  I limited my approaches not to touch the core
bootmem allocator for 2.6.14,  but that doesn't seem to work for ia64 boxes.  
Fixing the bootmem is the correct approach IMHO.  But in case you feel 
this is too intrusive for 2.6.14, we can whip up an ugly #ifdef CONFIG_X86_64 
patch which patches swiotlb.c only.

Thanks Yasunori-san for the patch, and Alex for testing out all the patches.

Thanks.
Kiran
