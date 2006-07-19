Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWGSWrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWGSWrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 18:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWGSWrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 18:47:05 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:49286 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932559AbWGSWrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 18:47:04 -0400
Message-ID: <1153349221.44beb6653e039@portal.student.luth.se>
Date: Thu, 20 Jul 2006 00:47:01 +0200
From: ricknu-0@student.ltu.se
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se> <20060719212049.GA6828@martell.zuzino.mipt.ru>
In-Reply-To: <20060719212049.GA6828@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Alexey Dobriyan <adobriyan@gmail.com>:

> On Wed, Jul 19, 2006 at 10:38:20PM +0200, ricknu-0@student.ltu.se wrote:
> > A first step to a generic boolean-type. The patch just introduce the bool
> (in
> > arch. i386 only (for the moment)),
> 
> What's do special about i386?
Oh, nothing. Meant the patch is only for i386. Because I do not have any other
setup there were little reason to change for any more arches

> > -Why would we want it?
> > -There is already some how are depending on a "boolean"-type (like NTFS).
> Also,
> > it will clearify functions who returns a boolean from one returning a
> value, ex:
> > bool it_is_ok();
> > char it_is_ok();
> > The first one is obvious what it is doing, the secound might return some
> sort of
> > status.
> 
> It should be obvious from name whether function returns int which is a
> boolean or int which is a number.
Yes idealy, but sometimes a "obvious" name for someone is a uncertain for others
+ if it is suppose to be an boolean, why not decleare it as one. Have seen quite
a few: int a; /* boolean */

> > -Why false and not FALSE, why not "enum {...} bool"
> > -They are not #define(d) and shouldn't because it is a value, like 'a'.
> But
> > because it is just a value, then bool is just a variable and should be able
> to
> > handle 0 and 1 equally well.
> 
>   -Why we wouldn't want it
>   -C++ and Java fans will treat bool as a green light to the following
> 
> 	if (!(flags == true))
>   and
> 	if (!(flags == false))
Thank god (or someone) for all the C fans who codereview ;)

Have you actually seen code like that (please point me to the place in that case :)


> Please, show compiler flag[s] to enable warning[s] from gcc about
> 
> 	_Bool foo = 42;
> 
> Until you do that the whole activity is moot.
On it...


> > --- a/include/asm-i386/types.h
> > +++ b/include/asm-i386/types.h
> > @@ -10,6 +10,15 @@ typedef unsigned short umode_t;
> >   * header files exported to user space
> >   */
> >
> > +#if defined(__GNUC__) && __GNUC__ >= 3
> > +typedef _Bool bool;
> > +#else
> > +#warning You compiler doesn't seem to support boolean types, will set
> 'bool' as
> > an 'unsigned char'
> > +typedef unsigned char bool;
> 
> Why unsigned char? Why not unsigned int? What would this do wrt
> bitfields?
I just took the smallest alternetive to a bit. Many uses an unsigned char as
boolean, others who uses integer should not suffer either (none of whom I have
checked).


> > +#endif
> > +
> > +typedef bool u2;
> 
> What is it?

Oww, it should be u1 (unsigned 1-bit). Thanks!

