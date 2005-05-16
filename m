Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVEPVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVEPVNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEPVNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:13:15 -0400
Received: from serv01.siteground.net ([70.85.91.68]:9912 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261881AbVEPVKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:10:23 -0400
Date: Mon, 16 May 2005 13:12:11 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-mm <linux-mm@kvack.org>, shai@scalex86.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in node
 memory alignment
In-Reply-To: <1116277014.1005.113.camel@localhost>
Message-ID: <Pine.LNX.4.62.0505161308010.25748@ScMPusgw>
References: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw> 
 <1116274451.1005.106.camel@localhost>  <Pine.LNX.4.62.0505161240240.13692@ScMPusgw>
  <1116276439.1005.110.camel@localhost>  <Pine.LNX.4.62.0505161253090.20839@ScMPusgw>
 <1116277014.1005.113.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Mon, 16 May 2005, Dave Hansen wrote:

> > > Do you know which pieces of code actually break if the alignment doesn't
> > > meet what that warning says?
> > 
> > I have seen nothing break but 4 MB allocations f.e. will not be allocated 
> > on a 4MB boundary with a 2 MB zone alignment. The page allocator always 
> > returnes properly aligned pages but 4MB allocations are an exception? 
> 
> I wasn't aware there was an alignment exception in the allocator for 4MB
> pages.  Could you provide some examples?

I never said that there was an aligment exception. The special case for 
4MB pages is created by the failure to properly align the zones in 
discontig.c.

But may be that is okay? Then we just need to remove the lines that 
detect the misalignment in the page allocator.
