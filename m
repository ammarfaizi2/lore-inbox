Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUGJPov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUGJPov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUGJPov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:44:51 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:772 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265048AbUGJPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:44:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
X-Message-Flag: Warning: May contain useful information
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
	<Pine.LNX.4.58.0407092319180.1764@ppc970.osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 10 Jul 2004 08:39:36 -0700
In-Reply-To: <Pine.LNX.4.58.0407092319180.1764@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 9 Jul 2004 23:23:52 -0700 (PDT)")
Message-ID: <52r7rj7txj.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Jul 2004 15:39:36.0947 (UTC) FILETIME=[1B1FAC30:01C46694]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus> I really don't see the point of complaining about the
    Linus> fixes. There's just _no_ way to say that "0" is more
    Linus> readable than "NULL" in any of the cases.  I dare you -
    Linus> show _one_ case where a 0/NULL patch was wrong or even
    Linus> remotely debatable. I dare you.

I don't know if any of the 0/NULL kernel patches were of this form,
but I've seen sparse complain about this in my code and found it
somewhat annoying.  I think the following is at least remotely debatable...

Suppose I have

	struct foo {
		int a;
		int b;
	};

then sparse is perfectly happy with someone clearing out a struct foo
like this:

	struct foo bar = { 0 };

but then if someone changes struct foo to be

	struct foo {
		void *x;
		int a;
		int b;
	};

sparse will complain about that initialization, and all of the fixes
I can think of seem somewhat worse than the original to me:

	struct foo bar = { NULL };   /* will I have to change this
                                        again if struct foo changes? */

or

	struct foo bar = { .a = 0 }; /* why do I have to name a member? */

or

	struct foo bar;
	memset(&bar, 0, sizeof bar); /* WRONG if a null pointer is not
                                        the bit pattern 0 */

 - Roland
