Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSGSSpm>; Fri, 19 Jul 2002 14:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSGSSpm>; Fri, 19 Jul 2002 14:45:42 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:34287 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S316953AbSGSSpl>;
	Fri, 19 Jul 2002 14:45:41 -0400
To: "Joseph Malicki" <jmalicki@starbak.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: close return value
References: <200207182347.g6INlcl47289@saturn.cs.uml.edu>
	<s5gsn2fr922.fsf@egghead.curl.com>
	<015401c22f40$c4471380$da5b903f@starbak.net>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 19 Jul 2002 14:48:44 -0400
In-Reply-To: <015401c22f40$c4471380$da5b903f@starbak.net>
Message-ID: <s5gvg7bmu43.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joseph Malicki" <jmalicki@starbak.net> writes:

> Those mistakes are your ignorance.  The manpage is wrong.  It does
> return -1 on error.  Also, errno is in libc, not the kernel.  Man
> library functions do in fact use errno.

Sigh.  OK, so I should have read SuSv2 instead of my local man page.
Mea culpa.  (Once upon a time, the buffered I/O libc routines made no
promises about which system calls they made or when.  On such systems,
errno after printf() had no guaranteed semantics.)

> And it's not an issue of whether an error is "impossible".  It's
> whether or not you would do anything if it failed.  It's not totally
> uncommon to actually not care whether or not it succeeds, but a
> valiant attempt is enough, such as in the case of printf.

If it is a diagnostic printf() to the screen, sure.  But an fprintf()
to update some state file on disk is a different matter entirely.

> Sure, if you require an event to be successful to continue you
> should always check it.  And yes, it's nice to print an error
> message on close sometimes, if something is critical.  But the
> question to ask is what you would actually _DO_ about an error... if
> the answer is nothing, then why check it?

To abort, plain and simple.  As I said, if you really think your call
to close() or gettimeofday() or whatever can never fail, you are much
better off dying immediately than proceeding on the assumption that it
succeeded.

Of course, checking errors in order to handle them sanely is a good
thing.  Nobody is arguing that.  What I am arguing is that failing to
check errors when they can "never happen" is wrong.

Anyway, back to lurker mode for me.

 - Pat
