Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132370AbRDPWgK>; Mon, 16 Apr 2001 18:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbRDPWgA>; Mon, 16 Apr 2001 18:36:00 -0400
Received: from mail.gci.com ([205.140.80.57]:42500 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S132370AbRDPWfr>;
	Mon, 16 Apr 2001 18:35:47 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446D9FF@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Manfred Bartz <md-linux-kernel@logi.cc>, linux-kernel@vger.kernel.org
Subject: RE: IP Acounting Idea for 2.5
Date: Mon, 16 Apr 2001 14:35:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Bartz responded to
> Russell King <rmk@arm.linux.org.uk> who writes:
> 
> > On Mon, Apr 16, 2001 at 12:07:31PM +1000, Manfred Bartz wrote:
> > > There is another issue with logging in general:
> > > 
> > >                 *COUNTERS MUST NOT BE RESETABLE!!!*
> > 
> > Umm, no.  Counters can be resetable - you just specify that 
> > accounting programs should not reset them, ever.
> > 
> > The ability to reset counters is extremely useful if you're a human
> > looking at the output of iptables -L -v.  (I thus far know of no one
> > who can memorise the counter values for around 40 rules).
> 
> You just illustrated my point.  While there is a reset capability
> people will use it and accounting/logging programs will get wrong
> data.  Resetable counters might be a minor convenience when debugging
> but the price is unreliable programs and the loss of the ability of
> several programs to use the same counters.

You of course, are commenting from the fact that your applications are
stupid, written poorly, and cannot handle 'wrapped' data.  Take MRTG
as one example of a good application, for it can handle counters that
have been cleared between reads.
 
> Also, do you always reset the date and time everytime you make time 
> measurements?

No, but i realize that if my time has incremented, and my date has not
changed, then it's later.  If my time has _decremented_ and my date has not,
then I've time-warped.  If my time has decremented and my date has
incremented,
then it's simply the next-date-increment.

Similarly, if my InPackets are at 102345 at one read, and 2345 the next
read,
and I know that my counter is 32 bits, then I know i've wrapped and can do
my
own math.

Applications need to get smarter.  Don't place arbitrary rules where they
don't
belong.
