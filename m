Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136460AbRASXL2>; Fri, 19 Jan 2001 18:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136548AbRASXLT>; Fri, 19 Jan 2001 18:11:19 -0500
Received: from purplecoder.com ([206.64.99.91]:28589 "EHLO
	gateway.purplecoder.com") by vger.kernel.org with ESMTP
	id <S136460AbRASXLK>; Fri, 19 Jan 2001 18:11:10 -0500
Message-ID: <3A68809B.E12EF3D9@purplecoder.com>
Date: Fri, 19 Jan 2001 12:59:55 -0500
From: Mark I Manning IV <mark4@purplecoder.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Coding Style
Content-Type: multipart/mixed;
 boundary="------------915F5CCE557543463D7E6243"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------915F5CCE557543463D7E6243
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi ppl..  This is my first posting here and it will probably generate
MORe flames than any previous posting but that isnt realy my intent,. 
The attached doccument is My answer to teh linux Coding Style doc as
found in teh kernel sources bz2.  It is done in parody of teh original
doc and is meant to be laughed at as much as taken seriously.... no
offense is intended towards the original author :)

Anyway, here goes  -->
--------------915F5CCE557543463D7E6243
Content-Type: text/plain; charset=us-ascii;
 name="CodingStyle"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CodingStyle"



  An answer to the Linux kernel coding style 

This is a short document describing the preferred coding style for any
sane project.  Coding style is very personal, and I won't _force_ my
views on anybody, but please at least consider the points made here. 

First off, I'd suggest printing out a copy of the GNU coding standards,
and NOT reading it.  Burn them, it's a great symbolic gesture.  

Anyway, here goes:


    Chapter 1: Indentation

Tabs are 8 characters so NO tabs should be used in ANY source file what 
so ever.  There are some silly people that insist on hitting the tab key 
when they should really be hitting the SPACE key (and for your info Linus
PI is EXACTLY 3... ish :)

Rationale:  Tabs force your code out to the right edge of the display
leaving no room for comments.  You don't need great big gaping spaces to
delineate the start and end of a block, TWO spaces do this just fine.


    Chapter 2: Placing Braces

The other issue that always comes up in C styling is the placement of
braces.  Unlike the indent size, there are few technical reasons to
choose one placement strategy over the other.  The most ridiculous way
is shown to us by the idiots Kernighan and Ritchie.  I.E, to put the 
opening brace last on the line, and put the closing brace first, thusly:

  if (x is true) {
    we do y              // original text failed to comment here
  }

Functions are not a special case simply because they can't be nested, 
they just happen to be the only thing K&R brace correctly.  Anyway, 
nesting if, and & but loops is evil.

  int function(int x)   
  {
    body of function    // correctly braced and commented :)
  }

Sane people all over the world have claimed that the K&R inconsistency
is...  well...  inconsistent, and they are all right-thinking people
who know that (a) K&R are _wrong_ and (b) K&R are very wrong.

Note that the closing brace is empty on a line of its own, _except_ in
the cases where it is followed by a continuation of the same statement,
ie a "while" in a do-statement or an "else" in an if-statement, like
this:

  do
  {
    body of do-loop     // why do you insist on not commenting ?
  } while (condition);  // more on this later :)         

Linus states that the placement of the first brace at the end of the 
first line keeps your code less vertical and thus saves you some space
for comments.  This commenting style just plane sucks, it fragments your
source file creating all kinds of visual clutter making them impossible 
to read.  New lines ARE A RENEWABLE resource, if they aren't then you need 
to buy more ram for your 8086 (or is it a z80 ?).

code code code
{
  code code code
}

comment comment comment

code code code

comment comment

code
{
  code

  comment

  code
}

...looks like shit....

code code code          // comment comment comment
{
  code code code        // comment comment comment
}

code code code          // comment comment

code                    // comment
{
  code                  // comment
  code                  // comment
}

...is much neater and also takes up allot less vertical space (thus
blowing the argument Linus was making about braces eating up 
real estate).  Yes we could shrink this further by bracing as per
K&R but that would only serve to cram everything into an unreadable
blob.  SOME whitespace IS needed!!

One other thing.  Allot of people neglect to brace a statement if 
it has a single line body.  This is VERY bad, always brace your
statements....

 if (x = 1)
   if (y = 2)
     if (z = 3)
       for (i = 1; i < 10; i++)
         if ....
           switch (foo)
             .....

...is really stupid.  DON'T DO IT!

    Chapter 3: Naming

Just read the document written by Linus, he is 100% correct here,
Hungarian notation is not only brain damaged it is brain damaging.
I know, I was forced to use it once and I am defiantly brain 
damaged :)

Oh... yea... that bit about function growth hormone imbalance 
syndrome was cute man :)
	
	
    Chapter 4: Functions

Again, I point you in the direction of the original document.

I would however like to state that the C switch statement is evil and
to be avoided at all costs.  If you really need to use one for what 
ever reason then each case in that switch statement should be a
CALL TO A FUNCTION!  Never place the source for that function inline 
unless it is only ONE line of code (or at a push TWO lines).  You can 
always make the compiler inline it for you!!!

Rationale.  

 switch(foo)
 {
   case 1:
   ...   500 lines of code
   case 2:                      // at this point ALL context for the
   ...  500 lines of code       // switch is lost. I.E. unreadable!
 }         

Even if its only 9 or 10 lines of code you STILL lose context on the
switch statement.  Poorly factored code is difficult to read. Very few
C coders know how to factor their code well.


    Chapter 5: Commenting

Comments are good, the more you comment your code the better. These
comments are not for you, they are for the poor schmuck that has to 
deal with your scratching later.  Never underestimate the stupidity
of this guy, don't leave anything to chance.  Never assume that HE 
will understand your logic simply because YOU do.

Rationale.  If you have thunked about your code enough to comment
it then you have thunked about it enough to CODE IT!


    Chapter 6: You've made a mess of it

Just read what Linus wrote.  Oh... Linus, its AN infinite number not
A infinite number...  and erm... what's emacs ??


    Chapter 7:  Configuration-files

Read what Linus wrote here, its a classic example of how to be totally
inconsistent.  Indentation should be 3 here but 2 there and 8 over 
there and 10 in this file but don't go over 29 in this file here... 

DOH!

-----------------------------------------------------------------------

Ok.. So I'm a heretic... I admit it!

I have never really liked the C language, it seems to me that it has a
habit of making ANY idiot think he/she can be a coder.  C is an easy 
language to learn but to be a good C coder takes years of hard study
and a TRUE artistic flair for programming.  This means that 99% of all 
C code is JUNK code.  

Before you all go running for your 1911 45 ACP's and 30-06's Linux is 
most defiantly in the 1% here, I just don't like the source format :P~  

Comments and flames are welcome....

Mark I Manning IV                  mark4@purplecoder.com

-----------------------------------------------------------------------    
--------------915F5CCE557543463D7E6243--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
