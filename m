Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVBBLOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVBBLOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 06:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVBBLOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 06:14:23 -0500
Received: from mail.suse.de ([195.135.220.2]:15254 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262282AbVBBLOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 06:14:09 -0500
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
From: Andreas Gruenbacher <agruen@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mpm@selenic.com, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CwI5w-0000mJ-00@gondolin.me.apana.org.au>
References: <E1CwI5w-0000mJ-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107342847.21040.18.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Feb 2005 12:14:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 11:50, Herbert Xu wrote:
> Andreas Gruenbacher <agruen@suse.de> wrote:
> > 
> > static inline void swap(void *a, void *b, int size)
> > {
> >        if (size % sizeof(long)) {
> >                char t;
> >                do {
> >                        t = *(char *)a;
> >                        *(char *)a++ = *(char *)b;
> >                        *(char *)b++ = t;
> >                } while (--size > 0);
> >        } else {
> >                long t;
> >                do {
> >                        t = *(long *)a;
> >                        *(long *)a = *(long *)b;
> >                        *(long *)b = t;
> >                        size -= sizeof(long);
> >                } while (size > sizeof(long));
> >        }
> > }
> 
> What if a/b aren't aligned?

That would be the case if the entire array was unaligned, or (size %
sizeof(long)) != 0. If people sort arrays that are unaligned even though
the element size is a multiple of sizeof(long) (or sizeof(u32) as Matt
proposes), they are just begging for bad performance. Otherwise, we're
doing byte-wise swap anyway.

-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

