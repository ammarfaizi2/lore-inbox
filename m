Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSHAVDt>; Thu, 1 Aug 2002 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSHAVDs>; Thu, 1 Aug 2002 17:03:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:53002 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315455AbSHAVDr>; Thu, 1 Aug 2002 17:03:47 -0400
Message-ID: <3D49A1CC.7080608@evision.ag>
Date: Thu, 01 Aug 2002 23:02:04 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
References: <Pine.GSO.4.21.0208011610020.12627-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Thu, 1 Aug 2002, Thunder from the hill wrote:
> 
> 
>>Hi,
>>
>>On Wed, 31 Jul 2002, Alexander Viro wrote:
>>
>>>What the bleedin' hell is wrong with <name> <start> <len>\n - all in ASCII?  
>>>Terminated by \0.  No need for flags, no need for endianness crap, no
>>>need to worry about field becoming too narrow...
>>
>>Well, why not long[] fields? Might be more powerful, and possibly not any 
>>slower than ASCII.
> 
> 
> More powerful in which way?  I see where it's less powerful - sizeof(long)
> is platform-dependent and so is endianness.  More powerful?  Maybe, if
> you have integers that do not have decimal representation.  I've never
> heard of such beasts, but sure would appreciate some examples.
> 
> As for the Martin's comments...  Martin, if you can't write a function
> that checks whether array of characters has a contents fitting the
> description above - stand up and say so.  Aloud.  In public.

Actually you asked me to just shut up. Becouse I assume that you guessed
that I'm able to write the corresponding code?

I will anser anyway ;-)

Sure I'm able to do this. However if I hear the words parser I 
immediately think *complete* parsers in the formal sense.
Not a bunch of reg exp guessing. Neither do
I think about that error prone scanning for '\0' or fumbling
with xxx[strln(xxx)]. And yes using lex and yacc *is actually* easy
for me.

So unless you provide me with a... well for example, *complete* BNF
grammar definition of /proc I will always claim that using it or ASCII 
based interfaces is:

1. Not easy.

2. Like walking on moving sand.

Oh well: I will accept EBNF as well...

Looking at some structs relives one from this headache.


> The fact that thousands of selfstyled "programmers" manage to screw that
> up says only one thing - that they should not be allowed anywhere near
> programming.  Because the same guys screw up in _anything_ they do,
> no matter what data types are involved.  ASCII is tough?  Make it "arithmetics
> is tough".  Examples on demand, including real gems like
> 	fread(&foo, sizeof(foo), 1, fp);
> 	if (foo.x >= 100000 || foo.y >= 100000)
> 		/* fail and exit */
> 	p = (char *)malloc(foo.x * foo.y);
> 	if (!p)
> 		/* fail and exit */
> 	for (i = 0; i < foo.x; i++)
> 		fread(p + i*foo.y. 1, foo.y, fp);
> and similar wonders (if anybody wonders what's wrong with the code above,
> you need to learn how multiplication is defined on int and compare 10^10 with
> 2^32).  And yes, it's real-life code, from often-used programs.  Used on
> untrusted data, at that.

Storing the constants in question in the above code sample
as ASCII at the start of where foo is pointing at, would have hardly
saved the poor overworked programmers mind from precisely the same
mistake he did above. (Needless to say that you actually forgott
to mention that the code fails on <= 32 bit systems. Inestad of 
providing te "hint" for guessing where the actual error is.)

It would have just duplicated the code size, becouse he would
have to do the ASCII parsing and additionaly he would
have to deal with moving offsets for reading the actual data.
Just more room for more mistakes.

The example above is a bad example to support your point therefore.
Actually it fires back. Like firing sharp rounds through
an AK47 with an exercise device still attached to the end of the pipe.

> Should we declare that arithmetics is dangerous?

It is it is... Dealing with the 5 axioms of peano leads you to
many many wired concepts. Like for example - infinity!!!

