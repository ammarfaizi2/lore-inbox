Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266154AbUGJGTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbUGJGTD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUGJGTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:19:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:35492 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266154AbUGJGTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:19:00 -0400
Date: Fri, 9 Jul 2004 23:18:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jul 2004, Eric W. Biederman wrote:
>
> Does this mean constructs like:
> ``if (pointer)'' and ``if (!pointer)'' are also outlawed.

Of course not.

Why should they be?

What's considered bad form is:
 - assignments in boolean context (because of the confusion of "=" and 
   "==")
 - thinking the constant "0" is a pointer.

There's no reason why "if (!ptr)" would be wrong. That has zero confusion 
about 0 vs NULL.

The confusion about "0" is that in traditional C it means two things: it 
can either be an integer (the common case) or it can sometimes be a 
pointer. That kind of semantic confusion is bad.

But it has nothing to do with the _value_ zero, or testing pointers for
being non-NULL. The value zero is not about semantic confusion, it's just 
a bit pattern. And testing pointers is not ambiguous: when you test a 
pointer, it's _un_ambigiously checking that pointer for NULL.

Problems arise when there is room for confusion, and that's when the 
compiler should (and does) warn. If something is unambiguous, it's not 
bad.

		Linus

