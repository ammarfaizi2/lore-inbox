Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUGJG7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUGJG7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUGJG7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:59:52 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:50642 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S266173AbUGJG7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:59:50 -0400
Date: Sat, 10 Jul 2004 08:58:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040710065847.GE20947@dualathlon.random>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org> <Pine.LNX.4.58.0407092319180.1764@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407092319180.1764@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 11:23:52PM -0700, Linus Torvalds wrote:
> I really don't see the point of complaining about the fixes. There's just
> _no_ way to say that "0" is more readable than "NULL" in any of the cases.  
> I dare you - show _one_ case where a 0/NULL patch was wrong or even
> remotely debatable. I dare you.

I definitely agree.

Several years ago I once wrote a singificant piece of code for a projet
with #define NULL -1UL, this actually wasn't my choice but a requirement
of the project (the headers were pre-defined) but it worked perfectly
since we never did '!ptr' we always did 'ptr == NULL' instead (etc..).
So at runtime it has never been a problem because we coded with NULL !=
0 in mind. Of course I known normally NULL is always equal to 0 but I
didn't realize that defining NULL !=0 wasn't exactly the C language (I
learnt it later on the hard way in some mailing list, I believe at some
point I did patches like the one in this thread but claiming it to be a
bugfix, and not just a cleanup ;).

IIRC my argument about these patches being bugfixes, was about an
architecture with a valid page mapped at address 0, that wouldn't
generate a segfault. This is incidentally why we had to use NULL = -1
instead of NULL = 0. The answer I got at that time form some C guru is
that I would need to hack the compiler specifically for such achitecture
to accomodate for NULL = -1, so that '!ptr' will be the same as 'ptr ==
-1UL' (for pointers). In practice I think it has been a lot easier for
us to avoid using '!ptr' than to hack gcc... 
