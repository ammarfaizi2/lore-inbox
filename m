Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUGGLMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUGGLMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbUGGLMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:12:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:51437 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265053AbUGGLMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:12:35 -0400
Date: Wed, 7 Jul 2004 04:10:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: jim.houston@comcast.net
Cc: kevcorry@us.ibm.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       torvalds@osdl.org, agk@redhat.com
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040707041059.17287591.akpm@osdl.org>
In-Reply-To: <1089197914.986.17.camel@new.localdomain>
References: <200407011035.13283.kevcorry@us.ibm.com>
	<200407021233.09610.kevcorry@us.ibm.com>
	<20040702124218.0ad27a85.akpm@osdl.org>
	<200407061323.27066.kevcorry@us.ibm.com>
	<20040706142335.14efcfa4.akpm@osdl.org>
	<1089151650.985.129.camel@new.localdomain>
	<20040706152817.38ce1151.akpm@osdl.org>
	<1089154845.985.164.camel@new.localdomain>
	<20040706161641.01c1bbce.akpm@osdl.org>
	<1089197914.986.17.camel@new.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston <jim.houston@comcast.net> wrote:
>
> On Tue, 2004-07-06 at 19:16, Andrew Morton wrote:
> Jim Houston <jim.houston@comcast.net> wrote:
> > >
> > > With out the test above an id beyond the allocated space will alias
> > > to one that exists.  Perhaps the highest id currently allocated is 
> > > 100, there will be two layers in the radix tree and the while loop
> > > above will only look at the 10 least significant bits.  If you call
> > > idr_find with 1025 it will return the pointer associated with id 1.
> > 
> > OK.
> > 
> > > The patch I sent was against linux-2.6.7, so I missed the change to
> > > MAX_ID_SHIFT.
> > 
> > How about this?
> >  
> >  	n = idp->layers * IDR_BITS;
> > +	if (id >= (1 << n))
> > +		return NULL;
> > +
> >  	p = idp->top;
> > +
> >  	/* Mask off upper bits we don't use for the search. */
> >  	id &= MAX_ID_MASK;
> >  
> 
> Hi Andrew,
> 
> It's not quite right.  If you want to keep a count in the upper bits
> you have to mask off that count before checking if the id is beyond the
> end of the allocated space.

OK, I'll fix that up.

But I don't want to keep a count in the upper bits!  I want rid of that
stuff altogether, completely, all of it.  It just keeps on hanging around :(

We should remove MAX_ID_* from the kernel altogether.
