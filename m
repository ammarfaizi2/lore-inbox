Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132493AbRDQBPF>; Mon, 16 Apr 2001 21:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDQBOz>; Mon, 16 Apr 2001 21:14:55 -0400
Received: from relay1.pair.com ([209.68.1.20]:22286 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S132493AbRDQBOh>;
	Mon, 16 Apr 2001 21:14:37 -0400
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010417011320.7149.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446D9FF@berkeley.gci.com>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: Leif Sawyer's message of "Mon, 16 Apr 2001 14:35:32 -0800"
Organization: rows-n-columns
Date: 17 Apr 2001 11:13:19 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer <lsawyer@gci.com> writes:

> Manfred Bartz responded to
> > Russell King <rmk@arm.linux.org.uk> who writes:
> > 
> > > On Mon, Apr 16, 2001 at 12:07:31PM +1000, Manfred Bartz wrote:
> > > > There is another issue with logging in general:
> > > > 
> > > >                 *COUNTERS MUST NOT BE RESETABLE!!!*
> > > 
> > > Umm, no.  Counters can be resetable - you just specify that 
> > > accounting programs should not reset them, ever.
> > > 
> > > The ability to reset counters is extremely useful if you're a human
> > > looking at the output of iptables -L -v.  (I thus far know of no one
> > > who can memorise the counter values for around 40 rules).
> > 
> > You just illustrated my point.  While there is a reset capability
> > people will use it and accounting/logging programs will get wrong
> > data.  Resetable counters might be a minor convenience when debugging
> > but the price is unreliable programs and the loss of the ability of
> > several programs to use the same counters.
> 
> You of course, are commenting from the fact that your applications are
> stupid, written poorly, and cannot handle 'wrapped' data.  

Well, apps written by me *can handle* wrapped data; it is actually far
easier that resetting at each read.

> Take MRTG as one example of a good application, for it can handle
> counters that have been cleared between reads.

Regardless of how well a logging application is written, there is no
way that it does not loose data when someone or something resets its
counter.  F.e. if an app reads a counter every 10 minutes and a
counter reset occurs from elsewhere, then anywhere between 0 and 10
minutes worth of data is lost.

I had a brief look at MRTG.  It seems to be a well written app and
while it can handle counter reset (with potential loss of an unknown 
amount of data), it does not actively reset counters.  It also doesn't
use iptables.

> Applications need to get smarter.  

Agreed.

> Don't place arbitrary rules where they don't belong.

Agreed too.  Counters should not arbitrarily be equipped with a reset
capability, there is hardly any benefit in that and it causes nothing
but problems.

As far as I can see, the counters in /proc/net/snmp don't have a
reset, same with /proc/net/dev and possibly other counters elsewhere.

Ideally iptables would fall in line with that.  Rules can still be
unloaded and reloaded, also causing counter reset and loss of data,
but since that is a lot more involved, application authors would have
an incentive to handle counters properly.

-- 
Manfred Bartz

