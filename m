Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133051AbRAVVz5>; Mon, 22 Jan 2001 16:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135303AbRAVVzr>; Mon, 22 Jan 2001 16:55:47 -0500
Received: from purplecoder.com ([206.64.99.91]:44770 "EHLO
	gateway.purplecoder.com") by vger.kernel.org with ESMTP
	id <S133051AbRAVVzn>; Mon, 22 Jan 2001 16:55:43 -0500
Message-ID: <3A6C630E.C2CB784C@purplecoder.com>
Date: Mon, 22 Jan 2001 11:42:54 -0500
From: Mark I Manning IV <mark4@purplecoder.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Satchell <satch@fluent-access.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT?] Coding Style
In-Reply-To: <4.3.2.7.2.20010122130852.00b92a80@mail.fluent-access.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell wrote:
> 
> One goal of language designers is to REMOVE the need for comments.  With a

this is a crock of (deleted).  You are chaising rainbows dood, you will
NEVER remove teh need for comments but its obvious you remove teh
comments.

> good fourth-generation or fifth-generation language, the need for comments
> diminishes to a detailed description of the data sets and any highly
> unusual operations or transforms on the data.

sorry but i could not disagree more

> 
> I've even gone so far as to "invent" my own languages, and the parsers to
> go with them, to reduce the need to comment by making the code easy for
> humans to read.  Not only are such systems easier to debug (with good
> language design) but are highly maintainable and usually not all that
> difficult to extend when necessary.

no lprogramming anguage can describe describe the design of the
applications written in it.  you NEED to comment your code.  100% Self
commenting code is a falacy.  50% self commenting code is almost
impossible to achieve.  COMMENT IT!

> 
> Remember, the line-by-line commenting requirement was mandatory in
> assembler programming, because the nature of assembler made you outline
> each step by tiring step.  

You talk like you dislike assembler as much as i dislike c :)


>                           When I worked for Rockwell, I was granted a
> partial wavier when I showed them my assembler-language commenting
> style:  pseudo-code at the top of each block of assembler code.

very ugly.  The S4 meter from landys and gyr (now siemens) actually uses
c code above each assembler routine as a form of commeting.  using code
to comment code is fine as long as you COMMENT the comments!

 
> Comments do NOT make code maintenance easier.  Too many comments obscure
> what is really going on. 

well... i disagree, years of consulting work and having to deal with
hunks of legacy code with no comments and huge functions etc etc et
(every coders worst nightmare) has taught me that comments are very much
needed (even bad comments are preferable to none at all)

> Linus' style actually increases the
> maintainability of the code, because if the code doesn't accurately show
> how it implements the goal specified in the block comment, the coder hasn't
> done his/her job.

TRUE.  Code should be written well enough that it isnt naturally
obfuscated but this does NOT remove the need for comments.

 
> Want to improve the maintainability of C code?  Consider the following:
> 
> 1)  Keep functional parts small.  If the code won't fit in a hundred lines
> or so of code, then you haven't factored the problem well
> enough.  Functional parts != functions.  

> A program with thousands of
> well-encapsulated function parts strung together into a single function is
> easier to maintain than a "well-factored" program with its parts spread all
> over hell.  

Cram a gazillion simple operations into a single function and you end up
with chaos, totally unfactored code is almost impossible to read.

> Diagnostic programmers have learned the hard way that factoring
> a program can make it difficult to ensure test coverage and even more
> difficult to determine if a part of the code is buggy or whether it found a
> hardware error that it was looking for. 

then they dont know how to test a program.  period


> In my ANSI C code, you will see the following a lot:
> 
> #define DO /*syntactic sugar */
> 
>      DO {
>         </* first functional part, with owned variables */
>      }
> 
>      DO {
>          </* next functional part, with its owned variables */
>      }
> 

> 
> 2)  Reduce visual complexity where possible.  Instead of using nested
> if-then-else statements, consider unrolling the nested
> statement.  Example:  {if (a && c)...; if (b && c)...; instead of {if (c)
> {if (a)...; if(b)...;}

which is simpler...

  (x + y) ^ 2 

or...

  (x ^2) + (Y ^2) + 2xy


> 3)  Make creative use of a run-on if statement to improve error detection
> and recording.  One of my tricks is to code the following statement in
> application programs:
> 
>       if(   (err = "input file can't be opened", in = fopen(filename,
> "rb"), in == NULL)
>         ||  (err = "output file can't be opened", out = fopen(oname, "wb"),
> out = NULL)
>         ...
>           )

use clever little tricks in your c so as to confuse people ?  You are
obviously a very advanced c coder who knows well the intracasies of the
language.  The person who has to maintain your code 10 years after you
have left may not be.

>        {
>        /* report the error that occurred, using the char * variable "err"
> to indicate the exact error. */
>        }

granted, the above block of code was not that difficult to understand,
even tho I have never seen that particular trick used before but the
above statement still stands. (nice trick btw :)
 
> 4)  The functional part should be contained in a reasonable number of
> lines.  Large while and for loops should call functions instead of having
> bloated bodies.  Large case statements should call functions instead of
> running on and on and on.

i wish everyone understood this (not usually a failing within the linux
kernel but you should see some of the code I have had to deal with. doh!
:)

 
> 5)  For those statements that take compound statements (if, else, while,
> for, do while) the statement should ALWAYS be a compound
> statement.  Nothing introduces bugs faster than a tired programmer not
> realizing that he/she is inserting a statement in the target of one of
> these statements and thereby replacing the target with a new one.  This one
> issue has broken more patches in my experience than any other single item.

by always adding braces to your if/else statements etc the above becomes
alot simpler me thunks... -->
 
> The argument that "this introduces a blizzard of unnecessary braces" is
> overweighed by the guarantee that the programming coming down the pike
> later won't accidentally remove a target line because s/he is too tired or
> rushed to recognize that s/he has to ADD BRACES (and in the case of a
> severely nested statement where to add braces) in order to turn a
> single-line target into a two-line target.  (Of course, some of you never
> make mistakes like that.  Fine.)

erm something is wrong here, i am actually agreeing with this guy ???
erm i think i need to go lie down for a while, i dont feel so good :)

> 6)  When you have an "empty" statement as the compound statement, indicate
> it unambiguously.  I have yet to find a see compiler that doesn't handle
> the following construct correctly:
> 
>       while (wait_for_condition())
>          {}


       while ( ... )	// is good but the above looks much nicer
         ;

 
> (or, more in keeping with Linus' style without adding an extra line, "while
> (wait_for_condition()) {}" )
       
this i dislike, ites easy for the eye to pass over the {} but STILL not
quite as bad as...

    while ( ..... );		// yukk :)


> 7)  Name space pollution is always a problem, although in these days of
> computer with gigabytes of RAM it's less of a problem than it used to
> be.  

well ok... less of a problem for the COMPUTER :)

>   I started programming C when my main computer had 256K of RAM and the
> symbol table space for linking was limited.  

should have been coding asm :)

>                                              I got in the habit of using
>  structures to minimize the number of symbols I exposed. It also
> disambiguates local variables and parameters from file- and program-global
> variables.  

explain this one to me, i think it might be usefull...

> Style has little to do with art.  Style has to do with minimizing mistakes,
> both now and down the road.  If you don't like what I do, then don't do
> what I do.  Do what minimizes mistakes for you.

style can show your art though, no style usually means no art :)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
