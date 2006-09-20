Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWITSUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWITSUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWITSUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:20:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:11723 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932201AbWITSUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:20:09 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=MzRBFFrIpGDR97e/dm1oDti3pYLWpsyIQhjfvwRBSbTjR7aLRxXQhaFnIbv2OprDo
	HXyEr4rT0cP3F2Atd9q8w==
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200609202014.48815.ak@suse.de>
References: <1158718722.29000.50.camel@galaxy.corp.google.com>
	 <p7364fikcbe.fsf@verdi.suse.de>
	 <1158770670.8574.26.camel@galaxy.corp.google.com>
	 <200609202014.48815.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 11:19:37 -0700
Message-Id: <1158776378.8574.95.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 20:14 +0200, Andi Kleen wrote:
> On Wednesday 20 September 2006 18:44, Rohit Seth wrote:
> > On Wed, 2006-09-20 at 13:27 +0200, Andi Kleen wrote:
> > > Rohit Seth <rohitseth@google.com> writes:
> > > >  					 */
> > > > +#ifdef CONFIG_CONTAINERS
> > > > +	struct container_struct *ctn; /* Pointer to container, may be NULL */
> > > > +#endif
> > > 
> > > I still don't think it's a good idea to add a pointer to struct page for this.
> > 
> > I thought last time you supported adding a pointer to struct page (when
> > you mentioned next gen slab will also consume page->mapping).  
> 
> I didn't. Alternative was a separate data structure.
> 
> > which one...I think the fields in page structure are already getting
> > doubly used. 
> 
> There are lots of different cases. At least for anonymous memory 
> ->mapping should be free. Perhaps that could be used for anonymous
> memory and a separate data structure for the important others.
> 

It is not free for anonymous memory as it is overloaded with pointer to
anon_vma.  I think one single pointer consistent across all page usages
is just so much cleaner and simple...

> slab should have at least one field free too, although it might be a different
> one (iirc Christoph's rewrite uses more than the current slab, but it would
> surprise me if he needed all) 
>  
> > > BTW your patchkit seems to be also in wrong order in that when 02 is applied
> > > it won't compile.
> > 
> > Not sure if I understood that.  I've myself tested these patches on
> > 2.6.18-rc6-mm2 kernel and they apply just fine.  Are you just trying to
> > apply 02....if so then that wouldn't suffice.
> 
> I meant assuming the patchkit was applied you would break binary search
> inbetween because not each piece compiles on its own.


I've currently separated the patches based on where the changes are made
and something that makes each a logical block.  I will reorder the
patches next time so that each subsequent patch compiles.

-rohit

