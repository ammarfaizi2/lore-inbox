Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130468AbQLOW1p>; Fri, 15 Dec 2000 17:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130582AbQLOW1f>; Fri, 15 Dec 2000 17:27:35 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:62069 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130468AbQLOW1Y>; Fri, 15 Dec 2000 17:27:24 -0500
Date: Fri, 15 Dec 2000 15:56:52 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200012152156.PAA137696@tomcat.admin.navo.hpc.mil>
To: andrea@suse.de, Ulrich Drepper <drepper@cygnus.com>
Subject: Re: 2.2.18 signal.h
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> From: Andrea Arcangeli <andrea@suse.de>
> On Fri, Dec 15, 2000 at 11:18:35AM -0800, Ulrich Drepper wrote:
> > Andrea Arcangeli <andrea@suse.de> writes:
> > 
> > > x()
> > > {
> > > 
> > > 	switch (1) {
> > > 	case 0:
> > > 	case 1:
> > > 	case 2:
> > > 	case 3:
> > > 	;
> > > 	}
> > > }
> > > 
> > > Why am I required to put a `;' only in the last case and not in all
> > > the previous ones? Or maybe gcc-latest is forgetting to complain about
> > > the previous ones ;)
> > 
> > Your C language knowledge seems to have holes.  It must be possible to
> > have more than one label for a statement.  Look through the kernel
> > sources, there are definitely cases where this is needed.
> 
> I don't understand what you're talking about. Who ever talked about "more than
> one label"?
> 
> The only issue here is having 1 random label at the end of a compound
> statement. Nothing else.

The label must be on an expression. Until the ";" is present to indicate
a null expression it is syntacticly incorrect to have

switch (x) {
1:
2: something;
3:
}

The "3:" needs an expression to satisfy the syntax of "switch".

> And yes I can see that the whole point of the change is that they want
> to also forbids this:
> 
> x()
> {
> 	goto out;
> out:
> }
> 
> and I dislike not being allowed to do the above as well infact ;).

I think this has the same requirement. A null expression, specified with
the ";" is a small price to pay for simplifying the error detection.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
