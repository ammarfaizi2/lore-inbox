Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbULBUZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbULBUZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbULBUZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:25:33 -0500
Received: from thunk.org ([69.25.196.29]:45475 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261747AbULBUZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:25:21 -0500
Date: Thu, 2 Dec 2004 15:25:14 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: James Bruce <bruce@andrew.cmu.edu>, "J.A. Magallon" <jamagallon@able.es>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
Message-ID: <20041202202514.GA5882@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	James Bruce <bruce@andrew.cmu.edu>,
	"J.A. Magallon" <jamagallon@able.es>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org> <1101976424l.5095l.0l@werewolf.able.es> <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org> <41AED140.4000306@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101976424l.5095l.0l@werewolf.able.es> <41AED140.4000306@andrew.cmu.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 03:24:32AM -0500, James Bruce wrote:
> 
> I think this oft-repeated argument is a strawman, since C++ and C are 
> identical on primitive types, and for non-primitive types, C can't use 
> operators anyway.

While that may be true, the problem is that you don't know off the top
of your head whether something like:

	a = b + c + d + e;

involves primitive types or not just by inspection.  So it could be
something that takes no time at all, or a monstrosity which takes a
dozen or more memory allocations, and where it requires a Ph.D. in
understanding obfuscated code to figure out which overloaded operators
and which type coercions had actually taken place.  And remember, this
is a language where you can even override the comma (',') operator.
You think you know what a piece of code will do just by looking at it?
Think again!

This is perhaps one of the reasons why no one has bothered to make a
C++ analogue of the Obfuscated C Programming Contest.  There simply is
no challenge involved.  I have seen propietary codebases written in
C++, where said codebase was the crown jewel of the company, and while
the original C code was understandable, when it was re-written in C++,
it was completely unmaintainable and impossible to understand what was
going on.  I was reduced to placing printf's all over the place just
to figure out the flow of control.  

(Out of respect to the company involved, I won't name names, but it
was a filesystem-related product, and I was adding ext2 support to the
codebase at the time.  While on paper it may have made sense to use
C++ classes to represent different filesystem drivers, the
implementation was a complete and mitigated disaster, IMHO.  And this
is not the only C++ project I have seen where it would have been much
easier to understand the darned thing if it had been written in C
instead.)

On Thu, Dec 02, 2004 at 08:33:44AM +0000, J.A. Magallon wrote:
> Don't ge silly. I have written C++ code to deal with SSE operations
> on vectors, and there you really need to control the assembler produced,
> and with the correct const and & on correct places the code is as
> efficient as C. Or more. You can control everything.....
>
> It is as all things, you need to know it deeply to use it well.
> There are a ton of myths around C++.

If you know how to use a table saw deeply and well, you can use it
safely even with all of the safeties disabled and the blade guard
removed.  There are even a few cases where you have to do this.
However, I wouldn't recommend it for most people since it is far too
likely they will lose a finger or a hand....

That's the problem with C++; it is far too easy to misuse.  And with a
project as big as the Linux Kernel, and with as many contributors as
the Linux Kernel, at the end of the day, it's all about damage
control.  If we depend on peer review to understand whether or not a
patch is busted, it is rather important that something as simple as 

	a = b + c;

does what we think it does, and not something else because someone has
overloaded the '+' operator.  Or God help us, as I have mentioned
earlier, the comma operator.

> In short, with C++ you can generate code as efficient as C or asm.
> You just have to know how.

You can juggle running chain saws if you know how, too.  But I think I
would rather leave that to the Flying Karamazov Brothers.

							- Ted
