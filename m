Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbQLPIZP>; Sat, 16 Dec 2000 03:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131516AbQLPIZF>; Sat, 16 Dec 2000 03:25:05 -0500
Received: from queen.bee.lk ([203.143.12.182]:13572 "EHLO bee.lk")
	by vger.kernel.org with ESMTP id <S130026AbQLPIYw>;
	Sat, 16 Dec 2000 03:24:52 -0500
Date: Sat, 16 Dec 2000 13:53:50 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ulrich Drepper <drepper@cygnus.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
In-Reply-To: <20001215205721.I17781@inspiron.random>
Message-ID: <Pine.LNX.4.21.0012161337220.1433-100000@bee.lk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Dec 2000, Andrea Arcangeli wrote:

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
> I don't understand what you're talking about. Who ever talked about
> "more than one label"?

In simple terms all four `case'es form a single entity and therefore a
statement is necessary AFTER them and not in the MIDDLE. That is why gcc
doesn't complain about the `previous' ones.
 
> The only issue here is having 1 random label at the end of a compound
> statement. Nothing else.

That is NOT the issue. It has nothing to do with the compound statement.
There should be a statement after ONE OR MORE "case"s, but here

case 0: case 1: case 2: case 3:

is NOT followed by a statement.

> And yes I can see that the whole point of the change is that they want
> to also forbids this:
> 
> x()
> {
> 	goto out;
> out:
> }

Again this is a similar case. But if you write

x()
{
  goto out1;
  goto out2;

out1:
out2:
}

GCC will complain the absence of a statement after `out1:out2:`, but not
two complains for `out1' and `out2', because they form a single entity.


Anuradha




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
