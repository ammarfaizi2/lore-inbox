Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAWSLH>; Tue, 23 Jan 2001 13:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbRAWSLB>; Tue, 23 Jan 2001 13:11:01 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:10292 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S129729AbRAWSKs>; Tue, 23 Jan 2001 13:10:48 -0500
Message-Id: <4.3.2.7.2.20010123094723.00b192c0@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 23 Jan 2001 10:10:34 -0800
To: Steve Underwood <steveu@coppice.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: [OT?] Coding Style
In-Reply-To: <3A6D78EA.5B09C379@coppice.org>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com>
 <20010122082254.D9530@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:28 PM 1/23/01 +0800, Steve Underwood wrote:
>During a period of making a liveing out of
>sorting out severly screwed up projects I made a little comment
>stripper. I found comments so unreliable, and so seldom useful, I was
>better off reading the code without the confusion they might cause. I
>do, however, try to document the non-obvious through comments in what I
>write.

Ditto.  Mine had the option of leaving the block comments in place (line 
count was a parameter) because the block comments proved to be more useful 
than the in-line comments.

>Some people still seem to be living in the age of K&R C, with 6 or 7
>character variable names that demand some explanation. Maybe some day
>they will awake to the expressive power of long (and well chosen) names.

Actually, they are still living as though the KSR-33 and ASR-33 teletypes 
were the only input device.  :)

True story:  I was retained to solve a particular problem for a company 
over a one-year time period.  I wrote some rather nifty code to solve the 
problem, and was happily doing data extraction and conversion for that time 
period.  Then there was a management turnover at the client and the new guy 
decided to implement a cost-cutting measure:  cut out as many outsiders as 
possible.  He decided that I should give him the code I had developed over 
the year (that wasn't part of the contract, of course) so that he could 
have in-house people do it.  Not just executable programs, of course.  "We 
bought the development of that code, so we deserve the source."  The 
bastard backed up the demand with his lawyer.  Not wanting to spend the 
money on the threatened lawsuit, I gave him exactly what he asked for:  the 
source to the latest working version of the programs I wrote to do the job.

It took a while to prepare the source for this jerk.  Here is what I did to 
the source I gave the guy:

1)  Used the output of CPP, which stripped out all include files and strips 
all comments.  This had the interesting side effect of making the source 
compiler-dependent.
2)  Stripped all newlines, and converted strings of spaces and tabs not in 
quotes to a single space.  This made the source one line long...a VERY LONG 
line.
3)  Converted each reasonable variable name to a string of seven random 
characters from the set [A-Aa-z0-9_], with the first character restricted 
to [A-Za-z].  A list of #define statements equated the random name to the 
proper library name or symbol.  (Because the names included a number of 
internal variables in the compiler library, this was a HUGE list.)  The 
resulting symbol table was so large that I had to use disk to keep all the 
names.  Inadvertently I had also randomized lexical elements such as "for", 
"while" and so forth, but #define statements took care of that problem.
4)  Determined that the output of the compiler with the mangled source was 
exactly the same as the output of the compiler with the original source.

As you can guess, I discovered a few bugs with the compiler I was 
using.  The compiler writer (who was just down the road) was highly amused 
with this and asked if they could "borrow" my mangler "for test 
purposes."  (Just who do they think they were kiddin'?)

Satch

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
