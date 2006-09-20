Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWITSOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWITSOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWITSOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:14:54 -0400
Received: from mail.suse.de ([195.135.220.2]:42213 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932199AbWITSOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:14:53 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
Date: Wed, 20 Sep 2006 20:14:48 +0200
User-Agent: KMail/1.9.3
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1158718722.29000.50.camel@galaxy.corp.google.com> <p7364fikcbe.fsf@verdi.suse.de> <1158770670.8574.26.camel@galaxy.corp.google.com>
In-Reply-To: <1158770670.8574.26.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609202014.48815.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 18:44, Rohit Seth wrote:
> On Wed, 2006-09-20 at 13:27 +0200, Andi Kleen wrote:
> > Rohit Seth <rohitseth@google.com> writes:
> > >  					 */
> > > +#ifdef CONFIG_CONTAINERS
> > > +	struct container_struct *ctn; /* Pointer to container, may be NULL */
> > > +#endif
> > 
> > I still don't think it's a good idea to add a pointer to struct page for this.
> 
> I thought last time you supported adding a pointer to struct page (when
> you mentioned next gen slab will also consume page->mapping).  

I didn't. Alternative was a separate data structure.

> which one...I think the fields in page structure are already getting
> doubly used. 

There are lots of different cases. At least for anonymous memory 
->mapping should be free. Perhaps that could be used for anonymous
memory and a separate data structure for the important others.

slab should have at least one field free too, although it might be a different
one (iirc Christoph's rewrite uses more than the current slab, but it would
surprise me if he needed all) 
 
> > BTW your patchkit seems to be also in wrong order in that when 02 is applied
> > it won't compile.
> 
> Not sure if I understood that.  I've myself tested these patches on
> 2.6.18-rc6-mm2 kernel and they apply just fine.  Are you just trying to
> apply 02....if so then that wouldn't suffice.

I meant assuming the patchkit was applied you would break binary search
inbetween because not each piece compiles on its own.

-Andi
 
