Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267823AbTAMK6L>; Mon, 13 Jan 2003 05:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbTAMK6L>; Mon, 13 Jan 2003 05:58:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:18948 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267823AbTAMK6J>; Mon, 13 Jan 2003 05:58:09 -0500
Message-ID: <3E229DFD.72730D5C@aitel.hist.no>
Date: Mon, 13 Jan 2003 12:07:41 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.55 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: robw@optonline.net, linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
References: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com> <1042404503.1208.95.camel@RobsPC.RobertWilkens.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Wilkens wrote:

> > Any if-statement is a goto. As are all structured loops.
> 
> "structured" being a key word.  I like structure in code.  Let's face
> it, everyone likes code to be well structured, that's why there's the
> "CodingStyle" document -- people like the code to look a certain way so
> they can read it later.  Without structure, you don't have that
> 
If you like "structure" so much, consider the fact that gotos are
used in a very structured way in the kernel.  Books won't list
goto as a "structured keyword" but that don't prevent
it from being used in a structured and diciplined manner.

"Avoid gotos" is only a rule of thumb, for those that don't
know the finer points.  Gotos have a enormous potential for abuse,
but it isn't abused in the kernel because it is used by experts who
limit themselves to only using it right.  (Well, most of the time, but
that isn't what you complain about. :-)

One cannot expect a newbie to get this right while learning the
language,
so beginners get a "don't use gotos" rule.  And therefore it takes time
before they learn to read code containing gotos too - even _good_ code.

Please note that rules of thumb aren't absolute.  There is another
well known - don't play with fire.  Generally good, but some people
have to do a lot of it anyway in order to design better fire
extinguishers
and train firefighters. 

> > Ans sometimes structure is good. When it's good, you should use it.
> 
> Ok, we agree there.
> 
> > And sometimes structure is _bad_, and gets into the way, and using a
> > "goto" is just much clearer.
> 
> I can't foresee many scenarios where this would be the case.  Someone
> spoke, for example, about being indented too far and needing to jump out
> because there isn't a good "break" mechanism... Well, as it says in the
> coding style document -- if you're indented more then 3 levels in,
> "you're screwed anyway, and should fix your program".

Sometimes using gotos makes things clearer, _for those that have some
experience with this particular way of using gotos_. 

_Of course_ it isn't the clearest to _you_, because you, as a newbie,
have noe training or experience in this.  Get experience, learn to
recognise the very limited use of goto in the kernel, and you'll
probably agree.

Consider someone who takes a C course where they don't teach "switch"
because "if" can do the same thing.  He would consider "switch"
unnecessary.  And hard to read, due to lack of experience.  And just
like
you, he would urge people to not use switch because _he_ finds it harder
to read.  That doesn't make avoiding switch the right thing to do
though.

The same applies to goto.  It is a useful thing - if used right.
[...]
> As someone else pointed out, it's provable that goto isn't needed, and
> given that C is a minimalist language, I'm not sure why it was included.

Again, switch is as unnecessary, yet nobody wants to remove it.  And
yes,
switch can be abused too (replace all ifs with switch for example.)
The rule against goto is a beginners simplification, because the real
rules for using goto are harder to express.  They are wasted on people
who struggle with "for" and pointers - and then the beginners course
ends.

> > The Pascal language is a prime example of the latter problem. Because it
> > doesn't have a "break" statement, loops in (traditional) Pascal end up
> > often looking like total shit, because you have to add totally arbitrary
> > logic to say "I'm done now".
> 
> But at least the code is "readable" when you do that.  

Readable for who, is the question.  Some limited use of goto don't take
that long to learn.  I used to simply think "urgh, a goto" but didn't
complain - it wasn't _my_ kernel.  Now I understand that kind of code
and approve.  And I shudder thinking about some code I've written for
pay - doing ten allocations in a row, testing each, and freeing
everything in a nested fashion upon possible failure.

> Sure it's a
> little more work on the part of the programmer.  
Now, if we can avoid that extra work _without_ harm, then it is 
certainly worth it, no?

> But anyone reading the
> code can say "oh, so the loop exits when condition x is met", rather
> than digging through the code looking for any place their might be a
> goto.

What you describe is the problem with undiciplined use of goto.  Kernel
code don't use gotos in any arbitrary way.  Check, and you'll see
that 99% of it it is very diciplined, using gotos in one
well-defined way.  Much of it is explicitly coded function-internal
"exceptions", a structured concept newer than C.

(Yyou can surely find some bad examples too.  Either hacks with a
special reason, or things that really ought to be cleaned up.)

 > Of course, I'm not about to argue that the kernel should be rewritten
> in PASCAL, nor am I interested in reinventing the wheel.  We've got a
> good system here, let's just keep it good and make it better. 

Making it better is interesting.  Note that performance sometimes 
overrules style, and yes - there are cases where goto wins
on raw performance.  And that might pay off if it is a very
often executed piece of code.

Also, avoiding goto at all cost is extra work for programmers
_every time_.  Learning to use gotos "right" (I.e. advanced use of C)
is one-time learning and then it is free - everytime.

The use of gotos may be a learning curve for every kernel newbie, but
so is understanding the VFS or the VM system or any other big
complicated piece.  Wether or not that piece uses gotos. :-)

Helge Hafting
