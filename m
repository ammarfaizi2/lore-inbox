Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161354AbWKUVTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161354AbWKUVTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWKUVTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:19:37 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:12732 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161369AbWKUVTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:19:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=zUVcApfKnhi4me0gbfGmnUuYi34s/29POUCWYtOyCwJ8rQG32YgOAA/AjpGx+wvhesqoWlj3M3DdbaYac19zsDItJ5zkckO1Oypi4RRD5MzsXEkTfB8HynKXD+BNsKGLXWdrkrH5KtUrD/NsqNKPEtMPHDj+blZRjRF2uNFzK0Q=  ;
X-YMail-OSG: wlSPsFkVM1kwZM6zrArTQz66OZvr6FkKXmHKyI7hkZ.liefpG73ReaTv3gMh64shlEikp5Xk7egA7Gqoj77LVaZeKlQTJhYn3rNjo6jcmQytlqVvftUwavBZd8Kvpsh3_B6gfbWKpx4hKWJiTGUM6WRaJugzT0aVeHo-
From: David Brownell <david-b@pacbell.net>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Tue, 21 Nov 2006 10:13:17 -0800
User-Agent: KMail/1.7.1
Cc: Bill Gatliff <bgat@billgatliff.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611202135.39970.david-b@pacbell.net> <20061121060918.GA2033@linux-sh.org>
In-Reply-To: <20061121060918.GA2033@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611211013.19127.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 10:09 pm, Paul Mundt wrote:
> On Mon, Nov 20, 2006 at 09:35:38PM -0800, David Brownell wrote:
> > On Monday 20 November 2006 9:09 pm, Bill Gatliff wrote:
> > > 	It seems like the point 
> > > here is to help a driver find and assert their GPIO _pin_ so that the 
> > > driver can can talk to the attached external hardware.
> > 
> > Updating the GPIO controller is always (all architectures!) done in terms
> > of a number mapping to some controller and a bit number, not a pin.  The
> > drivers never care about pins.
> > 
> > The only thing that cares about pins is board setup code -- briefly.
> > 
> That's rather simplifying things.

Not much.  The only counterexample I know about just now is wanting
to use a UART.RX pin as a wakeup GPIO, even when the baud rate clock
is turned off during sleep ... only on development platforms.


> There is a need to layer a pin mux API underneath the GPIO API to deal
> with these sorts of things, but that's obviously up to the platform to
> take care of, and I think your API is a fairly good staging ground for
> building up the layering in the platform parts.

Not entirely "mine" ... except in the writeup of the abstraction that's
already in wide use (with different syntax).

If we can agree on syntax, and factoring pin mux separately (however it
gets implemented) I think the immediate goal is satisfied.


> Claiming that we set the pins once in the board setup code and then
> forget about it is not realistic. I can't imagine anyone with many
> different pin functions under mux (OMAP2 does too) seriously taking that
> position.

It's realistic in a couple dozen different systems I've seen, including
ones using OMAP2.  Isn't that serious enough?  :)


> So given that, I would argue that drivers _do_ care about the pins, just
> not through the GPIO API.

I'm not quite sure what you're getting at with that any more, but so long
as you agree that it makes sense to have a GPIO API with more or less the
syntax I collected, distinct from pin mux/setup/reconfig, we're in close
enough agreement to move forward to whatever.

I know some folk say they "need" to remux after boot in non-exceptional cases,
but the ability to do that (or not) really seems like a separate discussion.

- Dave

