Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWEBNVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWEBNVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWEBNVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:21:47 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:9989 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964808AbWEBNVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:21:46 -0400
Date: Tue, 2 May 2006 15:21:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Avi Kivity <avi@argo.co.il>
Cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
Message-ID: <20060502132139.GA16647@w.ods.org>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44573525.7040507@argo.co.il>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 01:32:05PM +0300, Avi Kivity wrote:
> Willy Tarreau wrote:
> >Sorry , but all the examples that have been given in C++ are clearly
> >unreadable and impossible to understand.
> 
> If you don't know C++, sure.
> 
> Maybe this piece of code
> 
>  f [] = []
>  f (x:xs) = f [y | y <- xs, y < x] ++ [x] ++ f [y | y <- xs, y > x]
> 
> Isn't very readable to a C or C++ coder, but it's meaning is instantly 
> clear to one who knows the language it's written in. The equivalent C or 
> C++ code is ~30 lines long and you might need a pen and paper to work 
> out what it does.

It would be the exact same problem I discribed above. If nobody understand
what it does, or if people need some deep thoughts to guess its behaviour,
the result will be negative. Currently, everyone can read the kernel code.
I was a terrible looser in C 11 years ago when I first looked at it, but I
did not need specific knowledge of implicit things that the kernel does to
understand what the code did, and to propose patches.

Right now, lots of newbies review the code and find bugs. If you write it
in a language such as above, it will quickly end up like the BSD kernels,
with a small very competent core team and lots of newbies around them.

> > I'd also like to note that
> >people were arguing about what the code was really doing, this means
> >that this language is absolutely not suited to such usages where you
> >want to know the exact behaviour. 
> 
> Were they C coders or C++ coders?

I don't know, what I can say is that they were people who regularly discuss
the kernel semantics on other threads. That's what matters. Those people are
good at finding kernel bugs and proposing interesting algorithms, it's a shame
that they had to discuss langage semantics on 5 lines of code !

> >At least in C, this sort of thing
> >has never happened. 
> 
> Like the recent prevent_tail_call() thing? Granted, C++ is a lot tricker 
> than C. Much self-restraint is needed, and even then you can wind up 
> where you didn't want to go.

I've not followed the issue, sorry.

> >People argue about what must be locked and important
> >things like this you'd never want the compiler to decide for you.
> >
> >  
> 
> No one suggests that C++ can decide what needs to be locked or not. To 
> be sure, if there was a language where you could specify the locking 
> rules in a central place (the class/struct declaration, for example) and 
> let the compiler apply them, races and deadlocks would be much scarcer, 
> and people could argue about what needs to be locked when the data 
> structure is written, not every time it is used.

I seems like pro-C++ people constantly tell the other ones "look, C++ can
code for you so that you won't have to worry about boring parts. Of coure,
if you need to know, you're still able to write is the old way". Since we
always want to know, I guess we'd use the C++ compiler (the slow one), with
pure-C code borrowing nothing from the C++ language. That would only be a
pure loss.

> >To be secure, you first have to understand what the code precisely does,
> >not what it should do depending on how the compiler might optimise it.
> >  
> 
> If optimization changes your code's behaivor, your code is broken. 
> People rely on the C++ optimizer for much the same things as C: to 
> inline zero- or one- line functions and remove unused code. (There is 
> just one exception in C++ where the optimizer _is_ allowed to modify 
> behavior, but it is for an obviously correct scenario).
> 
> >I'm still thinking that people who have problems understanding what the
> >code does want a level of abstraction between them and the CPU so that
> >the compiler thinks for them.
> 
> No, they want not to repeat code and code patterns. It's the same 
> motivation that lead to the invention of functions:
> 
> - functions allow you to reuse code instead of open-coding common 
> sequences
> - constructors/destructors allow you to reuse the do/undo (lock/unlock, 
> etc.) pattern without writing it in full every time
> - templates allow you to reuse code even when the data types change 
> (like the preprocessor but not limited to linked lists)
> - virtual functions allow you to dispatch a function based on the 
> object's type, without writing the boilerplate casting
> - exceptions allow you to do the detect error/undo partial 
> modifications/propagate error thing without blowing up the code by a 
> factor of five
> 
> It's just shorthand: but shorthand allows you to see what the code is 
> doing instead of how it handles all the standard problems that occur 
> again and again in programming.

I'm still not convinced. Every time I came across C++ code, it was an immense
unreadable crap (indentation, cAmEl case, "funny" operators which you have to
stop at because you need a few seconds of thought before confusing them with
others, etc...). Code that cannot be read at 3am. If you want a good example
of this, download and read p7zip. It does lots of magic^Wimplicit things which
quickly got me lost. I agree, I'm not a C++ developper. But many language are
slightly understandable to non-fellows, and this one looks really nasty.

You told us examples of programs you have written. If this is true, I have
a lot of respect for this, because it still seems impossible to me. I
understand they were closed source, but if you come across open source
kernel code that is readable by newbies, I think many people would be
interested to get a clue.

> The C people are content to stop at functions, but resist _all_ of the 
> rest (it's okay to do some template-like magic with typeof, because it's 
> still C, right?).
> 
> > I still don't see the *current* problem
> >you are trying to fix. Linux is written in C, as many other kernels and
> >it works. Nobody knows what it would become if rewritten in C++. Maybe
> >it will be better, maybe it would not run anymore on embedded systems,
> >maybe it would become fully buggy because nobody except a little bunch
> >of C++ coders would understand it... At least, I'm sure it will not be
> >the smart people who currently work on it.
> >  
> 
> Maybe it would be smaller, faster, more robust, and have even more 
> flexible and fast-paced development.
> 
> Perhaps people who developed kernel-level code in _both_ C and C++ would 
> be qualified to speculate on that (I have, but apparently I don't have a 
> clue).
> 
> >Best of all, I'm even sure that people who are trying to push C++ in
> >the kernel would never ever write a line of code once it would be
> >accepted, because they don't seem to know what they're talking about
> >when it applies to kernel code.
> >  
> 
> Thanks.

Regards,
Willy

