Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUGIUkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUGIUkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUGIUkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:40:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45468 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263943AbUGIUkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:40:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Jul 2004 14:36:09 -0600
In-Reply-To: <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
Message-ID: <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 8 Jul 2004, Herbert Xu wrote:
> >
> > Chris Wright <chrisw@osdl.org> wrote:
> > > Fixup another round of sparse warnings of the type:
> > >        warning: Using plain integer as NULL pointer
> > 
> > What's wrong with using 0 as the NULL pointer? In contexts where
> > a plain 0 is unsafe, NULL is usually unsafe as well.
> 
> It's not about "unsafe". It's about being WRONG.

Does this mean constructs like:
``if (pointer)'' and ``if (!pointer)'' are also outlawed.

And do we then need to initialize static pointers to NULL instead
of letting them be implicitly 0.

Is doing memset(&(struct with_embeded_pointers), 0, sizeof(struct))
also wrong?

I don't see that 0 is WRONG.  I do agree that ``((void *)0)'' is
slightly more typesafe than ``0'', but since we don't have a lot of
(void *) pointers in the kernel that is still the WRONG pointer type.

I do see that NULL has superior readability and maintainability and so
should be encouraged by Documentation/CodingStyle.

The B and K&R roots of a simple single type language are what give C
most of it's simplicity flexibility and power.  Please don't be so
eager to throw those out.  

You want to be so typesafe it sounds like you want to recode the
kernel in Pascal.  You've written sparse, so it should be just a little
more work to write a Pascal backend.  After that the kernel will be so
typesafe the compiler won't let us poor programmers get it wrong.

Eric
