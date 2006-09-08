Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWIHSGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWIHSGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWIHSGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:06:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:34320 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751111AbWIHSGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:06:31 -0400
Date: Fri, 8 Sep 2006 14:06:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <200609081929.33027.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0609081401270.7953-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Oliver Neukum wrote:

> Am Freitag, 8. September 2006 17:55 schrieb Alan Stern:
> > >     CPU 0                   CPU 1
> > >     -----                   -----
> > >     while (y==0) relax();   y = -1;
> > >     a = 1;                  b = 1;
> > >     mb();                   mb();
> > >     y = b;                  x = a;
> > >                             while (y < 0) relax();
> > >                             assert(x==1 || y==1);   //???
> 
> 					y =  -1
> 	a = 1
> 	y =b (== 0)
> 					b = 1
> 					x = a (==1)

So in this case the assertion is satisfied because x == 1.  My question
was whether the assertion could ever fail.  Paul said that it could, but I
didn't find his reason convincing.

> > Disagree: CPU 0 executes mb() between reading y and b.  You have assumed
> > that CPU 1 executed its write to b and its mb() before CPU 0 got started, 
> > so why wouldn't CPU 0's mb() guarantee that it sees the new value of b?  
> > That's really the key point.
> 
> That code has an ordinary race condition.
> For it to work it needs to be:
> 
> b = 1;
> mb(); //could be wmb()
> y = -1;

I'm not sure what you mean.  The code wasn't intended to "work" in any 
sense; it was just to make a point.  My question still stands: Is it 
possible, in the code as I originally wrote it, for the assertion to fail?

Alan Stern

