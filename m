Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbTJPOzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTJPOzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:55:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:29160 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262997AbTJPOzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:55:40 -0400
Date: Thu, 16 Oct 2003 07:55:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] constant_test_bit doesn't like my gcc
Message-Id: <20031016075531.484c0441.akpm@osdl.org>
In-Reply-To: <200310161255.36380.ioe-lkml@rameria.de>
References: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com>
	<20031015212134.41a427d3.akpm@osdl.org>
	<Pine.LNX.4.53.0310160020060.2328@montezuma.fsmlabs.com>
	<200310161255.36380.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> wrote:
>
> On Thursday 16 October 2003 06:22, Zwane Mwaikambo wrote:
> > On Wed, 15 Oct 2003, Andrew Morton wrote:
> > > >   static __inline__ int constant_test_bit(int nr, const volatile
> > > > unsigned long * addr) {
> > > >  -	return ((1UL << (nr & 31)) & (((const volatile unsigned int *)
> > > > addr)[nr >> 5])) != 0; +	return ((1UL << (nr & 31)) & (addr[nr >> 5]))
> > > > != 0;
> > > >   }
> > >
> > > Looks fine.  Does your compiler get this right?
> >
> > Yep, thanks.
> 
> Sorry, but I still don't get, what a "const volatile" is supposed to mean.

const: this function doesn't alter it

volatile: someone else does modify it, so the compiler needs to avoid
caching it in a register.

