Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132864AbRAVSaU>; Mon, 22 Jan 2001 13:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132966AbRAVSaA>; Mon, 22 Jan 2001 13:30:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132864AbRAVS3q>; Mon, 22 Jan 2001 13:29:46 -0500
Date: Mon, 22 Jan 2001 13:29:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Larry McVoy <lm@bitmover.com>
cc: Jonathan Earle <jearle@nortelnetworks.com>,
        "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
In-Reply-To: <20010122082254.D9530@work.bitmover.com>
Message-ID: <Pine.LNX.3.95.1010122132454.2390A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Larry McVoy wrote:

> On Mon, Jan 22, 2001 at 11:04:50AM -0500, Jonathan Earle wrote:
> > > -----Original Message-----
> > > From: profmakx.fmp [mailto:profmakx.fmp@gmx.de]
> > > 
> > > So, every good programmer
> > > should know where to put comments. And it is unnecessary to 
> > > put comments to
> > > explain what code does. One should see this as stated in the 
> > > CodingStyle doc.
> > > Ok, there are points where a comment is good, but for example 
> > > at university
> > > we are to comment on every single line of code ...
> > 
> > WRONG!!!
> > 
> > Not documenting your code is not a sign of good coding, but rather shows
> > arrogance, laziness and contempt for "those who would dare tamper with your
> > code after you've written it".  Document and comment your code thoroughly.
> > Do it as you go along.  I was also taught to comment nearly every line - as
> > part of the coding style used by a large, international company I worked for
> > several years ago.  It brings the logic of the programmer into focus and
> > makes code maintenance a whole lot easier.  It also helps one to remember
> > the logic of your own code when you revisit it a year or more hence.
> 
> Please don't listen to this.  The only place you really want comments is
> 
>     a) at the top of files, describing the point of the file;
>     b) at the top of functions, if the purpose of the function is not obvious;
>     c) in line, when the code is not obvious.
> 
> If you are writing code that requires a comment for every line, you are 
> writing bad, obscure, unobvious code and no amount of commenting will fix
> it.
> 
> The real reason to sparing in your comments is that code and comments are
> not semantically bound to each other: the program doesn't stop working when
> the comment becomes incorrect.  It's incredibly frustrating to read a comment,
> believe you understand what is going on, only to find out that the comment
> and the code no longer match.   
> -- 
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 


Okay, I'll byte (sic)...

If you are a good programmer, your code should work well and
you will be writing code for new projects long before the product
enters the in-production maintenance phase. This phase exists in
real products during their lifetime. At this time, rather junior
programmers will be required to add new capability or even fix
bugs.

Even excellent programmers generate bugs that are not discovered
for a long time (perhaps ever). This occurs because not every code
path gets tested so these bugs are not always found. For instance,
the return value from a function that encounters hardware errors may
not be correct because, during the entire development phase, the
hardware never generated that specific error.

When maintaining code, the programmer may have never seen the
code before. If it takes several weeks to find the function that
is returning the wrong value, and if it takes several hours to
correct the problem after the function is located, then the
original writer did not complete his or her job correctly.

Comments should assume that the reader is expert in the language
being used. No other assumptions produce useful documentation.

There are many ways to document code. Not all of these ways involve
comments. Examples are:

(1)	MACROS:

Lots of programmers don't use MACROS for documentation. However they
are very useful. Suppose we have a complicated single-bit sequence
necessary to communicate with a SEEPROM. If the main-line code does:

	WRITE_SEEPROM(parameter);
	READ_SEEPROM(parameter);

... then the code is very clear. The MACRO can be very complicated.
When it is isolated in this manner, the code both for the MACRO and
the functions that expand this MACRO are better documented than
just laying code. 

(2)	Descriptive names:

I don't like these myself. Often programmers get too cute. You
can look at the BusLogic code and see what I am talking about.
Practically every variable and function name begins with "BusLogic".

However, descriptive variable and function names do help document code.
This, even though many get carried away with extremes.

Most everybody will recognize:

	for (i=0; i< LIMIT; i++)
              ;

We don't really need:

	for(SimpleIntegerCount=0; SimpleIntegerCount < OneLessThanTheArraySize;
	    SimpleIntegerCount++)
               ;

But, when you are writing complicated code, it is often useful to use
descriptive names that uniquely define several otherwise similar routines.
For instance:

	Write_error_log(data);
	Append_error_log(data);

Again, some carry this to the extreme, they take a good idea and corrupt
it, MicroSoftSyle, into:

	WriteErrorLog(data);
	AppendErrorLog(data);

(3)	Comments:

Comments are very useful if they convey useful information. Many comments
are not useful because they seem to exist only because somebody made a
rule that said; "You have to comment your code...".

	An example:

	fprintf(stderr,"Memory allocation error\n");  /* No memory available */

Generally, comments should tell what is being done. The code tells how it's
being done.

For instance:
        value = 0;
	write_csr(value)      /* Need to synchronize */
	value |= SYNC;        /* This is really a 'start' bit */
        write_csr(value);
 

(4)	Constants:

Many constants are put into a header file or, worse, just scattered
throughout the code. These constants may represent hardware bits or
register contents that require some kind of explanation. Code that
does "magic", because of some number, is not well documented.

For instance:

	if(status & 0x80)
            do_something();

This should read:

	if(status & DATA_AVAILABLE)
            do_something();

In the second case, somebody took the time to figure out all the
status bits and define them somewhere. Now you don't have to do this.

Summing up, comments are only a small part of the total documentation
story. It is probably possible to write documented code without a
single comment. However, most of us are not quite that smart and
require a few comments here and there. Also, comments help you get
through Design Reviews, required if you write code that could impact
public safety.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
