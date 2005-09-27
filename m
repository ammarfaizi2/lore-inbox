Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVI0AYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVI0AYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 20:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVI0AYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 20:24:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:53459 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750818AbVI0AYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 20:24:30 -0400
Subject: Re: [PATCH 1/9] add defrag flags
From: Dave Hansen <haveblue@us.ibm.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, Mike Kravetz <kravetz@us.ibm.com>
In-Reply-To: <21024267-29C3-4657-9C45-17D186EAD808@mac.com>
References: <4338537E.8070603@austin.ibm.com>
	 <43385412.5080506@austin.ibm.com>
	 <21024267-29C3-4657-9C45-17D186EAD808@mac.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 17:24:08 -0700
Message-Id: <1127780648.10315.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 20:16 -0400, Kyle Moffett wrote:
> On Sep 26, 2005, at 16:03:30, Joel Schopp wrote:
> > The flags are:
> > __GFP_USER, which corresponds to easily reclaimable pages
> > __GFP_KERNRCLM, which corresponds to userspace pages
> 
> Uhh, call me crazy, but don't those flags look a little backwards to  
> you?  Maybe it's just me, but wouldn't it make sense to expect  
> __GFP_USER to be a userspace allocation and __GFP_KERNRCLM to be an  
> easily reclaimable kernel page?

I think Joel simply made an error in his description.

__GFP_KERNRCLM corresponds to pages which are kernel-allocated, but have
some chance of being reclaimed at some point.  Basically, they're things
that will get freed back under memory pressure.  This can be direct, as
with the dcache and its slab shrinker, or more indirect as for control
structures like buffer_heads that get reclaimed after _other_ things are
freed.

-- Dave

