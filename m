Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUGJJmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUGJJmy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 05:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUGJJmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 05:42:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44191 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266147AbUGJJmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 05:42:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Jul 2004 03:39:13 -0600
In-Reply-To: <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
Message-ID: <m1smc09p6m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 9 Jul 2004, Eric W. Biederman wrote:
> >
> > Does this mean constructs like:
> > ``if (pointer)'' and ``if (!pointer)'' are also outlawed.
> 
> Of course not.
> 
> Why should they be?

Only because the definition of the semantics of ``if'' is in terms of
comparisons with ``0'',  and I am familiar enough with the C
programming language that, that is how I read it.  It is still 
the case that because the comparison happens in pointer context the
``0'' referred  to is the null pointer constant.  

For some of us who are extremely familiar with C your argument is
confusing.  You make statements that sound like they are about the
definition of the C programming language when in fact they are
criticism of a given C programming style.  

Since I am already making distinctions 0 as the integer value and
0 as the pointer constant when 0 is implicitly introduced.  It is
really not confusing to me in the case of manifest constants.

> What's considered bad form is:
>  - assignments in boolean context (because of the confusion of "=" and 
>    "==")
>  - thinking the constant "0" is a pointer.

I would agree that using the constant "0" in a pointer context
when a more explicit NULL is bad form.  But "0" is the one
legal way in C to write the NULL pointer constant.

> There's no reason why "if (!ptr)" would be wrong. That has zero confusion 
> about 0 vs NULL.

For me it has exactly the same level of confusion as the cases that
are being fixed has.  I have to know the type to know if it is testing
against the NULL pointer constant or if it is testing against the
integer value zero.
 
> The confusion about "0" is that in traditional C it means two things: it 
> can either be an integer (the common case) or it can sometimes be a 
> pointer. That kind of semantic confusion is bad.

Either that or it can be called greater expressive power though fewer
concepts. 

I like the fact this allows cases like ``if (!ptr)'' and friends.
 
> But it has nothing to do with the _value_ zero, or testing pointers for
> being non-NULL. The value zero is not about semantic confusion, it's just 
> a bit pattern. And testing pointers is not ambiguous: when you test a 
> pointer, it's _un_ambigiously checking that pointer for NULL.

see above.

> Problems arise when there is room for confusion, and that's when the 
> compiler should (and does) warn. If something is unambiguous, it's not 
> bad.

The compiler is compiling the correct code so the code is clearly not
ambiguous.  But since types are not always obvious to a person
staring at the code using the more explicit form of the constant
i.e. NULL or '\0' instead of 0 adds useful redundancy.

Hopefully that explains why I objected to the way you can out against
using ``0'' as the null pointer constant.

Eric
