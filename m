Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290745AbSAYUjs>; Fri, 25 Jan 2002 15:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290805AbSAYUjg>; Fri, 25 Jan 2002 15:39:36 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:43652 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S290745AbSAYUj3>;
	Fri, 25 Jan 2002 15:39:29 -0500
Date: Fri, 25 Jan 2002 15:39:28 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
Cc: Timothy Covell <timothy.covell@ashavan.org>, Robert Love <rml@tech9.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <20020125045206.A2313@ragnar-hojland.com>
Message-ID: <Pine.LNX.4.30.0201251521560.17384-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Ragnar Hojland Espinosa wrote:

> On Fri, Jan 25, 2002 at 04:44:38PM -0600, Timothy Covell wrote:
> > On Thursday 24 January 2002 16:38, Robert Love wrote:
> > > On Fri, 2002-01-25 at 17:30, Timothy Covell wrote:
> > > > On Thursday 24 January 2002 16:19, Robert Love wrote:
> > > > > how is "if (x)" any less legit if x is an integer ?
> > > >
> > > > What about
> > > >
> > > > {
> > > >     char x;
> > > >
> > > >     if ( x )
> > > >     {
> > > >         printf ("\n We got here\n");
> > > >     }
> > > >     else
> > > >     {
> > > >         // We never get here
> > > >         printf ("\n We never got here\n");
> > > >     }
> > > > }
> > > >
> > > >
> > > > That's not what I want.   It just seems too open to bugs
> > > > and messy IHMO.
> > >
> > > When would you ever use the above code?  Your reasoning is "you may
> > > accidentally check a char for a boolean value."  In other words, not
> > > realize it was a char.  What is to say its a boolean?  Or not?  This
> > > isn't an argument.  How does having a boolean type solve this?  Just use
> > > an int.
> > >
> > > 	Robert Love
> >
> > It would fix this because then the compiler would refuse to compile
> > "if (x)"  when x is not a bool.    That's what I would call type safety.
> > But I guess that you all are arguing that C wasn't built that way and
> > that you don't want it.
>
> It would actually break this.  if is supposed (and expected) to evaluate
> an expression, whatever it will be.  Maybe a gentle warning could be in
> place, but refusing to compile is a plain broken C compiler.
>

I think it is being suggested by whomever the proponent of the bool type
is (I lost track of who wanted it) that maybe keywords that depend on
boolean evaluations (if, while, for, etc.) should only take boolean
expressions as 'parameters', rather than what C does, which is take just
about any expression (everything except automatically allocated structs
being more or less reducible to an int).  This would certainly eliminate
some common typos (typos that any experienced C programmer knows ot look
out for) and make some other code a little more verbose (read: redundant).

So in the strlen example:

int strlen (const char *str)
{
	const char *cur;

	for (cur = str; *cur; cur++);
	return cur - str;
}

It would not be sufficient to check on *cur being true in the for loop,
but you would need an actual boolean expression or boolean type (*cur == 0
or somesuch).

This is a definite change to the C language and while I can see the
benefits of it, I am not sure if it's worth the trouble to alter a
compiler to enforce this type of thing, etc.  :)

-Calin

