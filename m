Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWIOIgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWIOIgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWIOIgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:36:44 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:1314 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750752AbWIOIgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:36:43 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <45091F9A.5020805@vmware.com>
References: <20060901110948.GD15684@skybase>  <45084C2E.4060203@vmware.com>
	 <1158224199.18478.22.camel@localhost>  <45091F9A.5020805@vmware.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 15 Sep 2006 10:36:39 +0200
Message-Id: <1158309400.23993.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 02:23 -0700, Zachary Amsden wrote:
> Martin Schwidefsky wrote
> > The discard fault happens on access to a volatile that has been
> > discarded. An important property of the s390 architecture comes into
> > play here: there are two page tables, a guest page table and a host page
> > table. What the guest perceives as its "physical" memory is in virtual
> > storage for the host. An address resolution has to walk two pages
> > tables, if a pte is invalid in either table you get a fault. A guest
> > fault if the invalid pte is in the guest table and a host fault if it is
> >   
> 
> Yes, I'm familiar with that trick.  Wasn't sure if you had it in 
> hardware or not.

The mainframes have that trick in hardware for about 30 years ..

> > in the host table. That gives s390 a simple method to implement
> > discarded pages: the hypervisor just unmaps the page from the host table
> > and changes the state of the guest page. I can see that you will have a
> > much harder time to implement this on i386.
> >   
> 
> Nah, I think we'll do just fine.

I wonder which trick you use, since there is only one page table one
i386 I can only imagine that you are tracking all page tables of the
guest.

> Thanks for the info - based on this, I think we can probably use the 
> volatile page / swap cache changes as well for VMware, also pretty much 
> unchanged.  Sorry to take so long to look at these patches, BTW - I was 
> on holiday for two weeks.

I've been sitting on these patches for months now and you are worrying
about two weeks..

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


