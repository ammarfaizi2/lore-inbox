Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVKFC07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVKFC07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 21:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVKFC07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 21:26:59 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24983
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932088AbVKFC07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 21:26:59 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Zan Lynx <zlynx@acm.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Sat, 5 Nov 2005 20:25:47 -0600
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, Gregory Maxwell <gmaxwell@gmail.com>,
       Andy Nelson <andy@thermo.lanl.gov>, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@mbligh.org,
       mel@csn.ul.ie, nickpiggin@yahoo.com.au, torvalds@osdl.org
References: <20051104201248.GA14201@elte.hu> <200511042343.27832.ak@suse.de> <436D5CCD.3050901@acm.org>
In-Reply-To: <436D5CCD.3050901@acm.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511052025.48976.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 19:30, Zan Lynx wrote:
> > None of this is very attractive.
>
> You could allow the 'hugetlb zone' to shrink, allowing more kernel
> allocations.  User pages at the boundary would be moved to make room.

Please make that optional if you do.  In my potential use case, an OOM kill 
lets the administrator know they've got things configure wrong so they can 
can fix it and try again.  Containing and viciously reaping things like 
dentries is the behavior I want out of it.

Also, if you do shrink the hugetlb zone it might be possible to 
opportunistically expand it back to its original size.  There's no guarantee 
that a given kernel allocation will ever go away, but if it _does_ go away 
then the hugetlb zone should be able to expand to the next blocking 
allocation or the maximum size, whichever comes first.  (Given that my 
understanding of the layout may not match reality at all; don't ask me how 
the discontiguous memory stuff would work in here...)

Rob
