Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVIVKAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVIVKAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVIVKAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:00:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751461AbVIVKAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:00:35 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0509211154210.2553@g5.osdl.org> 
References: <Pine.LNX.4.58.0509211154210.2553@g5.osdl.org>  <20050921101558.7ad7e7d7.akpm@osdl.org> <5378.1127211442@warthog.cambridge.redhat.com> <12434.1127314090@warthog.cambridge.redhat.com> <5543.1127327394@warthog.cambridge.redhat.com> <20050921114533.76815f03.akpm@osdl.org> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 22 Sep 2005 11:00:24 +0100
Message-ID: <27186.1127383224@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> > hrmph.  Of course it's a reasonable trick from a performance and
> > convenience and resource consumption POV.  But it's a new idiom and the
> > threshold for new idioms is non-zero.  We use it in struct page, but struct
> > page is special.
> 
> Hmm.. I don't feel it is that new, but maybe that's because I've used that 
> trick in other places. I think it's pretty common in a "type-safe C" way, 
> and it should probably be encouraged. A unique pointer type for special 
> usages, that you can't dereference even by mistake..

It's something that C isn't particularly good at. C++ is better at this as you
can define a class and overload the -> operator and the unary * operator if
you're feeling particularly evil or adventurous. But C it is...

> But adding a few comments might certainly be worth it. If only to teach 
> others the trick.

Maybe there should be some naming convention for quasi-pointers like this? I
could typedef it, for instance, and hang comments appropriate to its nature of
the typedef. Perhaps:

	typedef struct __key_ref_with_possession_attribute *key_ref;

And then give its accessor functions capital letters to make them stand out,
though that might give the false impression that they're actually preprocessor
macros.

Or perhaps I should rename two of the functions:

	key_mkref() -> construct_key_ref()
	key_deref() -> convert_key_ref_to_ptr() or extract_key_ptr()

Would that serve in lieu of commenting every time I use these things?

David
