Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbUDFQkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbUDFQkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:40:39 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:5391 "HELO mail-ext.curl.com")
	by vger.kernel.org with SMTP id S263912AbUDFQkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:40:17 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gisgd9ipj.fsf@patl=users.sf.net>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405234957.69998.qmail@web40509.mail.yahoo.com>
	<20040406132750$3d4e@grapevine.lcs.mit.edu>
Date: 06 Apr 2004 12:40:15 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/20040406132750$3d4e@grapevine.lcs.mit.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <jesse@cats-chateau.net> writes:

> To prevent the memory leaks you have to have a mark and sweep GC.
> Which still doesn't prevent circular loop leaks.

What are you talking about?  A mark/sweep GC certainly DOES collect
circular data structures.

Perhaps you are thinking of reference counting GCs?

> Then you need a memory pool allocator to relocate all valid
> references.

Now you seem to talking about stop and copy, which is something else
again.  And it is not required to avoid memory leaks, although it does
fix fragmentation.

> The combination is NOT small. BTW, the JVM suffers from circular
> loop leaks too, since all it uses is reference counting (for speed).

Which JVM are you talking about?  Every JVM I know of uses a real
garbage collector, not some reference counting hack.

Perhaps you are thinking of Perl?

Sergiy is right: A Lisp interpreter and runtime can be quite small and
efficient.  And it can provide a secure "sandbox" for running
questionable code safely.

Whether it is a good idea in this context is another question.  My
concern is that it is hard (impossible?) to bound the memory
consumption, both stack AND heap, of a Lisp program statically.  I
would expect such bounds to be important for an implementation of a
security model.  With a Lisp program, you cannot be sure under what
conditions it will exceed whatever space you have alloted for it.
Which means that, although it cannot crash the kernel, it cannot be
used to build a reliable system, either...

 - Pat
