Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265785AbUGHFU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUGHFU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUGHFU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:20:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:59024 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265780AbUGHFUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:20:07 -0400
Date: Wed, 7 Jul 2004 22:19:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jul 2004, Herbert Xu wrote:
>
> Chris Wright <chrisw@osdl.org> wrote:
> > Fixup another round of sparse warnings of the type:
> >        warning: Using plain integer as NULL pointer
> 
> What's wrong with using 0 as the NULL pointer? In contexts where
> a plain 0 is unsafe, NULL is usually unsafe as well.

It's not about "unsafe". It's about being WRONG.

The fact is, people who write "0" are either living in the stone age, or 
are not sure about the type. "0" is an _integer_. It's not a pointer. It 
may be legal C, but that doesn't make it right anyway. "0" also happens to 
be one of the more _common_ integers, so mistakes happen.

Looking at the code, people that used "0" for NULL pointers quite often 
obviously were NOT aware of the types. The code just happened to pass 
through the compiler without warnings.

The same is true the other way too. I've seen too many damn people who use 
NULL in an integer context, and any compiler system that makes NULL be 
just a plain "0" is frigging _broken_.  NULL is _not_ an integer. Never 
has been, and if the compiler doesn't warn loudly about obviously idiotic 
code, then the compiler is broken.

In other words:

	char * p = 0;	/* IS WRONG! DAMMIT! */
	int i = NULL;	/* THIS IS WRONG TOO! */

and anybody who writes code like the above either needs to get out of the 
kernel, or needs to get transported to the 21st century. 

		Linus
