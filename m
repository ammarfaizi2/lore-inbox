Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265049AbUGGLAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbUGGLAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUGGLAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:00:00 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:11999 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265049AbUGGK76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 06:59:58 -0400
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Andrew Morton <akpm@osdl.org>
Cc: kevcorry@us.ibm.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       torvalds@osdl.org, agk@redhat.com
In-Reply-To: <20040706161641.01c1bbce.akpm@osdl.org>
References: <200407011035.13283.kevcorry@us.ibm.com>
	 <200407021233.09610.kevcorry@us.ibm.com>
	 <20040702124218.0ad27a85.akpm@osdl.org>
	 <200407061323.27066.kevcorry@us.ibm.com>
	 <20040706142335.14efcfa4.akpm@osdl.org>
	 <1089151650.985.129.camel@new.localdomain>
	 <20040706152817.38ce1151.akpm@osdl.org>
	 <1089154845.985.164.camel@new.localdomain>
	 <20040706161641.01c1bbce.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1089197914.986.17.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 07 Jul 2004 06:58:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 19:16, Andrew Morton wrote:
Jim Houston <jim.houston@comcast.net> wrote:
> >
> > With out the test above an id beyond the allocated space will alias
> > to one that exists.  Perhaps the highest id currently allocated is 
> > 100, there will be two layers in the radix tree and the while loop
> > above will only look at the 10 least significant bits.  If you call
> > idr_find with 1025 it will return the pointer associated with id 1.
> 
> OK.
> 
> > The patch I sent was against linux-2.6.7, so I missed the change to
> > MAX_ID_SHIFT.
> 
> How about this?
>  
>  	n = idp->layers * IDR_BITS;
> +	if (id >= (1 << n))
> +		return NULL;
> +
>  	p = idp->top;
> +
>  	/* Mask off upper bits we don't use for the search. */
>  	id &= MAX_ID_MASK;
>  

Hi Andrew,

It's not quite right.  If you want to keep a count in the upper bits
you have to mask off that count before checking if the id is beyond the
end of the allocated space.

Jim Houston - Concurrent Computer Corp.

