Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUGJV7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUGJV7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUGJV7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 17:59:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27010 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266449AbUGJV7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 17:59:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 10 Jul 2004 18:59:23 -0300
In-Reply-To: <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
Message-ID: <orhdsfo75w.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 10, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> On Fri, 9 Jul 2004, Eric W. Biederman wrote:
>> 
>> Does this mean constructs like:
>> ``if (pointer)'' and ``if (!pointer)'' are also outlawed.

> Of course not.

> Why should they be?

Err...  Because the conditional expression is implicitly compared with
0 [6.8.4.1]/#2.  If 0 is not to be used explicitly in pointer
contexts, why should it be ok to use it implicitly?

> What's considered bad form is:
[snip]
>  - thinking the constant "0" is a pointer.

> There's no reason why "if (!ptr)" would be wrong.

[6.5.3.3]/#5 defines the result of the logical negation operator
based on the result of comparing the expression with 0.

> But it has nothing to do with the _value_ zero, or testing pointers for
> being non-NULL. The value zero is not about semantic confusion, it's just 
> a bit pattern. And testing pointers is not ambiguous: when you test a 
> pointer, it's _un_ambigiously checking that pointer for NULL.

I don't see why (!ptr) is any more confusing than (ptr != 0), and why
(ptr != NULL) would be any clearer.  Is `ptr != 0' one of the cases
that are not bad?

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
