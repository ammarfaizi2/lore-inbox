Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbUJXPhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUJXPhv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUJXPhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:37:51 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:3457 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261500AbUJXPhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:37:21 -0400
Date: Sun, 24 Oct 2004 08:32:04 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: jonathan@jonmasters.org
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, karim@opersys.com
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041024153204.GA1262@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041023194721.GB1268@us.ibm.com> <1098562921.3306.182.camel@thomas> <20041023212421.GF1267@us.ibm.com> <35fb2e5904102315066c6892aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e5904102315066c6892aa@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 11:06:03PM +0100, Jon Masters wrote:
> On Sat, 23 Oct 2004 14:24:21 -0700, Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > On Sat, Oct 23, 2004 at 10:22:01PM +0200, Thomas Gleixner wrote:
> 
> > > On Sat, 2004-10-23 at 12:47 -0700, Paul E. McKenney wrote:
> 
> > > I haven't seen an embedded SMP system yet. Focussing this on SMP systems
> > > is ignoring the majority of possible applications.
> 
> > Seeing SMP support for ARM lead me to believe that this was not too far
> > over the edge.
> 
> They have an SMP reference implementation, however many folks don't
> actually want to go the dual core approach right now for embedded
> designs (apparently the increased design complexity isn't worth it).
> I've had protracted discussions about this very issue quite recently
> indeed. Others will disagree, I'm only basing my statement upon
> conversations with various engineers - I think your idea eventually
> becomes interesting, but now is not the right moment to be pushing it
> yet. People still don't want this now.

Thank you for the background!  It has been quite some time since I
did significant embedded work.  Let's just say that I am glad that
"embedded CPU" no longer means "8-bit CPU"!  ;-)

> Talk to smartphone manufacturers who currently have dual ARM core
> designs, one running Linux and the other running an RTOS for the GSM
> and phone stuff, and they'll say they actually want to reduce the
> design complexity down to a single core. Talking to people suggests
> that multicore designs are good in certain situations (such as in the
> case above), but in general people aren't yet going to respond to your
> way of doing realtime :-) Yes you do have only one OS in there, maybe
> that would change opinion, but we're not quite at the point where
> everything is multicore so you're not going to convince the masses.

Good points.  Suppose there was a way to get the hard realtime benefits
using a slight elaboration of this approach that worked on single-core,
single-threaded CPUs?  Would that be of interest?

> Having said all that, for a different perspective, I hack on ppc
> (Xilinx Virtex II Pro) kernel and userspace stuff for some folks that
> make high resolution imaging equipment, involving extremely precise
> control over a pulsed signal and data acquisition (we're talking
> nanosecond/microsecond precision). Since Linux obviously isn't capable
> of this level of deterministic response right now we end up farming
> out work to a separate core - it's unlikely your approach would
> convince the hardware folks, but I guess it might be tempting at some
> point in the future. Who knows.

Agreed, if you are going for the ultimate in response time, you have
no choice but to run hand-coded assembly language on bare metal (though
optimizing compilers are improving, so maybe it will soon be hand-coded
C on bare metal).  If you are using your computer to digitally modulate
and synthesize a USA FM radio signal (around 100MHz carrier frequency),
you certainly are not going to have anything resembling an OS involved.
You will have nothing but a tight loop running flat out, assuming that
even today's general-purpose CPUs are fast enough to accomplish this.

So, I guess the question is whether 100-microsecond restricted hard
realtime support in Linux is worth the effort.  From what you are saying,
it sounds like the answer is currently "no" if it requires multithreaded
CPUs or multicore dies.

So, again, if there was a way to make this approach work on
single-threaded single core CPUs, would that be of interest?

					Thanx, Paul
