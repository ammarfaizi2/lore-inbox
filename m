Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131174AbQLOU5Z>; Fri, 15 Dec 2000 15:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbQLOU5Q>; Fri, 15 Dec 2000 15:57:16 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:13576 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S131174AbQLOU5C>; Fri, 15 Dec 2000 15:57:02 -0500
Date: Fri, 15 Dec 2000 15:31:30 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215153130.B24830@munchkin.spectacle-pond.org>
In-Reply-To: <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com> <20001215175632.A17781@inspiron.random> <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com> <20001215184325.B17781@inspiron.random> <4.3.2.7.2.20001215185622.025f8740@mail.lauterbach.com> <20001215195433.G17781@inspiron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001215195433.G17781@inspiron.random>; from andrea@suse.de on Fri, Dec 15, 2000 at 07:54:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 07:54:33PM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 15, 2000 at 06:59:24PM +0100, Franz Sirl wrote:
> > It's required by ISO C, and since that's the standard now, gcc spits out a 
> > warning. Just adding a ; is enough and already done for most stuff in 
> > 2.4.0-test12.
> 
> I'm not complaining gcc folks, I just dislike the new behaviour in general,
> it's inconsistent.
> 
> This is wrong:
> 
> x()
> {
> 
> 	switch (1) {
> 	case 0:
> 	case 1:
> 	case 2:
> 	case 3:
> 	}
> }
> 
> and this is right:
> 
> x()
> {
> 
> 	switch (1) {
> 	case 0:
> 	case 1:
> 	case 2:
> 	case 3:
> 	;
> 	}
> }
> 
> Why am I required to put a `;' only in the last case and not in all
> the previous ones? Or maybe gcc-latest is forgetting to complain about
> the previous ones ;)

Because neither

	<label>:		(nor)
	case <expr>:		(nor)
	default:

are statements by themselves.  They are an optional start of a statement.  The
ebnf looks like:

	statement:
		  labeled-statement
		| expression-statem
		| compoundstatement
		| selection-statement
		| iteration-statement
		| jump-statement

	labeled-statement:
		  identifier ':' statement
		| 'case' constant-expression ':' statement
		| 'default' ':' statement

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
