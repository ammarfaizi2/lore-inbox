Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVBARy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVBARy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVBARy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:54:28 -0500
Received: from news.suse.de ([195.135.220.2]:54665 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262085AbVBARyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:54:19 -0500
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
From: Andreas Gruenbacher <agruen@suse.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <41FE6B42.7010807@grupopie.com>
References: <2.416337461@selenic.com>
	 <1107191783.21706.124.camel@winden.suse.de> <41FE6B42.7010807@grupopie.com>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107280438.12050.118.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Feb 2005 18:54:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 18:30, Paulo Marques wrote:
> Andreas Gruenbacher wrote:
> > [...]
> > 
> > static inline void swap(void *a, void *b, int size)
> > {
> >         if (size % sizeof(long)) {
> >                 char t;
> >                 do {
> >                         t = *(char *)a;
> >                         *(char *)a++ = *(char *)b;
> >                         *(char *)b++ = t;
> >                 } while (--size > 0);
> >         } else {
> >                 long t;
> >                 do {
> >                         t = *(long *)a;
> >                         *(long *)a = *(long *)b;
> >                         *(long *)b = t;
> >                         size -= sizeof(long);
> >                 } while (size > sizeof(long));
> 
> You forgot to increment a and b, and this should be "while (size);", no?

Correct, yes.

> Or better yet,
> 
> static inline void swap(void *a, void *b, int size)
> {
> 	long tl;
>          char t;
> 
> 	while (size >= sizeof(long)) {
>                  tl = *(long *)a;
>                  *(long *)a = *(long *)b;
>                  *(long *)b = tl;
> 		a += sizeof(long);
> 		b += sizeof(long);
>                  size -= sizeof(long);
> 	}
> 	while (size) {
>                  t = *(char *)a;
>                  *(char *)a++ = *(char *)b;
>                  *(char *)b++ = t;
> 		size--;
>          }
> }
> 
> This works better if the size is not a multiple of sizeof(long), but is 
> bigger than a long.

In case size is not a multiple of sizeof(long) here, you'll have
unaligned memory accesses most of the time anyway, so it probably
doesn't really matter.

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

