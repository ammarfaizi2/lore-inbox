Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbREUKzn>; Mon, 21 May 2001 06:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262466AbREUKzd>; Mon, 21 May 2001 06:55:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7553 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262465AbREUKzT>;
	Mon, 21 May 2001 06:55:19 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.62483.731973.549006@pizda.ninka.net>
Date: Mon, 21 May 2001 03:55:15 -0700 (PDT)
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521124225.A3417@gruyere.muc.suse.de>
In-Reply-To: <20010521034726.G30738@athlon.random>
	<15112.48708.639090.348990@pizda.ninka.net>
	<20010521105944.H30738@athlon.random>
	<15112.55709.565823.676709@pizda.ninka.net>
	<20010521112357.A1718@gruyere.muc.suse.de>
	<15112.57377.723591.710628@pizda.ninka.net>
	<20010521114216.A1968@gruyere.muc.suse.de>
	<15112.59192.613218.796909@pizda.ninka.net>
	<20010521122753.A2507@gruyere.muc.suse.de>
	<15112.61258.251051.960811@pizda.ninka.net>
	<20010521124225.A3417@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > On Mon, May 21, 2001 at 03:34:50AM -0700, David S. Miller wrote:
 > > egrep illegal_highdma net/core/dev.c
 > 
 > There is just no portable way for the driver to figure out if it should
 > set this flag or not. e.g. acenic.c gets it wrong: it is unconditionally
 > set even on IA32. Currently it requires an architecture ifdef to set properly.

Well, certainly, this could perhaps be a bug in the Acenic driver.
It should check if DAC cycles can be used on the platform, for example.

But please, let's get back to the original problem though.

The original claim is that the situation was not handled at all.  All
I'm trying to say is simply that the net stack does check via
illegal_highdma() the condition you stated was not being checked at
all.  To me it sounded like you were claiming that HIGHMEM pages went
totally unchecked through device transmit, and that is totally untrue.

If you were trying to point out the problem with what the Acenic
driver is doind, just state that next time ok? :-)

There is no question that what Acenic is doing with ifdefs needs a
clean portable solution.  This will be part of the 64-bit DAC API
interfaces (whenever those become really necessary, I simply don't
see the need right now).

Plainly, I'm going to be highly reluctant to make changes to the PCI
dma API in 2.4.x  It is already hard enough to get all the PCI drivers
in line and using it.  Suggesting this kind of change is similar to
saying "let's change the arguments to request_irq()".  We would do it
to fix a true "people actually hit this" kind of bug, of course.  Yet
we would avoid it at all possible costs due to the disruption this
would cause.

I'm not trying to be a big bad guy about this.  What I'm trying to do
is make sure at least one person (me :-) is thinking about the
ramifications any such change has on all current drivers which use
these interfaces already.  And also, to port maintainers...

Later,
David S. Miller
davem@redhat.com


