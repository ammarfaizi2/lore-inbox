Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVLBCWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVLBCWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVLBCWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:22:32 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10908 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964795AbVLBCWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:22:31 -0500
Subject: Re: [patch 00/43] ktimer reworked
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: johnstul@us.ibm.com, george@mvista.com, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org, ray-gmail@madrabbit.org,
       rmk+lkml@arm.linux.org.uk, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1133481739.10478.54.camel@tglx.tec.linutronix.de>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512010118200.1609@scrub.home>
	 <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
	 <Pine.LNX.4.61.0512011352590.1609@scrub.home>
	 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
	 <20051201165144.GC31551@flint.arm.linux.org.uk>
	 <20051201122455.4546d1da.akpm@osdl.org> <20051201211933.GA25142@elte.hu>
	 <20051201135139.3d1c10df.akpm@osdl.org>
	 <7D53372C-E138-4336-883F-A674BBBB09AA@mac.com>
	 <20051201221553.GA19135@infradead.org>
	 <1133481739.10478.54.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 21:21:09 -0500
Message-Id: <1133490069.32583.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 01:02 +0100, Thomas Gleixner wrote:
> On Thu, 2005-12-01 at 22:15 +0000, Christoph Hellwig wrote:
> > On Thu, Dec 01, 2005 at 05:13:17PM -0500, Kyle Moffett wrote:
> > > In this patch there are two ways of setting up code to run at some  
> > > point in the future: timers and timeouts.
> > > 
> > > A timeout (like waiting for somebody to answer the phone) is  
> > > optimized to never happen (they will hopefully pick up first).  If  
> > > everything works perfectly; it will be stopped before it has a chance  
> > > to go off.
> > > 
> > > A timer (like a kitchen timer telling you the cookies are done) is  
> > > optimized to be added and sit around until it expires.  You just  
> > > don't turn off the timer and take the cookies out before they are done.
> > 
> > Heh, in my dumb non-native speaker mind I'd expectit the other way around,
> > as in a timeout is expected to time out :)  and a timer is expect to happen,
> > as in say the timer the tells you your breakfast egg is ready.
> 
> Which is perfectly the point Kyle made. 
> 
> The timer tells you that the cookies or your breakfast eggs are well
> done. You put them out of the oven or the pot at exactly the time when
> the timer event happens. You won't turn off the timer before your
> cookies/eggs are done, because you want them well done.

As I mentioned before, this is where you expect an event to happen (I
want x to happen at some time).  The event being to take out the
cookies.

> 
> The timeout you set up is to remind you to switch off the oven before
> your kitchen starts to burn. This timeout is likely - not sure in your
> personal case :) - to be cancelled because you did think about switching
> off the oven in time. If you forgot it, it is not a big difference if
> you get the reminder 5 minutes earlier or later. 

And this is where a time out is done when some event doesn't happen (I
want to know if x didn't happen by some time).  The event here is to
turn off the oven and the time out is to let you know that you didn't
and the house will soon burn down if you don't turn it off.

> In case of the egg / cookie timer the distcintion of 1 to 5 minutes
> makes a big difference.


I started kernel programming with writing experimental network stacks.
So to me "timeout" is strongly engraved in my head as to let you know
when something didn't happen, and you need to do something to recover
for it.  If you send out a packet and you don't receive an ACK, you have
a timeout let you know that it probably didn't make it (or the ACK
didn't make it to you), and send another packet out.  But most likely,
(unless you are on a really unreliable network) you get your ACK and you
can remove the time out.

I know that timeouts are used tremendously in the networking code, so
separating them from precision timers would likely be a good thing.

-- Steve


