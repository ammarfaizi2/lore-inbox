Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266201AbUGJJwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUGJJwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 05:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266202AbUGJJwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 05:52:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46239 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266201AbUGJJwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 05:52:06 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
	<Pine.LNX.4.58.0407092319180.1764@ppc970.osdl.org>
	<20040710065847.GE20947@dualathlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Jul 2004 03:48:33 -0600
In-Reply-To: <20040710065847.GE20947@dualathlon.random>
Message-ID: <m1oemo9or2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> IIRC my argument about these patches being bugfixes, was about an
> architecture with a valid page mapped at address 0, that wouldn't
> generate a segfault. This is incidentally why we had to use NULL = -1
> instead of NULL = 0. The answer I got at that time form some C guru is
> that I would need to hack the compiler specifically for such achitecture
> to accomodate for NULL = -1, so that '!ptr' will be the same as 'ptr ==
> -1UL' (for pointers). In practice I think it has been a lot easier for
> us to avoid using '!ptr' than to hack gcc... 

Well gcc is not terribly hackable that way, something about decades
of code bloat...

The thing to keep in mind is that it was the integer to pointer
conversion that needed to be hacked.  (void *)0 is the null pointer
constant by definition.  So you it is technically illegal in that
context to use (ptr *)0 to refer to the first page of memory.  It
must be another number that you can convert and manipulate.

For a single program I do agree that it probably would not be worth it
but if you were delivering an architecture where people wrote lots
of code it would be better fix the compiler to be standards conforming.

Eric


