Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTIQVtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbTIQVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:49:51 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:39091 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S262844AbTIQVts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:49:48 -0400
Date: Wed, 17 Sep 2003 23:49:44 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: Patch: Make iBook1 work again
In-Reply-To: <1063833817.585.220.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309172325160.8954-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Sep 2003, Benjamin Herrenschmidt wrote:

> On Wed, 2003-09-17 at 23:10, Daniël Mantione wrote:
> > On Wed, 17 Sep 2003, Benjamin Herrenschmidt wrote:
> >
> > > Unfortunately, the wallstreet doesn't work neither. I get something strange on the
> > > screen. It's somewhat sync'ed but divided in 4 vertical stripes, each one displaying
> > > the left side of the display (+/- offseted), along with some fuzziness (clock wrong).
> >
> > Actually, is the problem perhaps this:

> It looks like this indeed. What is the cause you are thining about ?

It is a misconfigured display fifo. Some of the Mach64 variants calculate
the parameters for the display fifo automatically, others require the
driver to do so. It's a very lowlevel kind of stuff and also gives you
grey hairs quickly.

When the CRT controller starts a scanline, it starts at the start of the
display fifo and treats it as ring buffer. Before the CRT controller
starts the buffer is filled with data from the framebuffer.

You have to program the interval after which the buffer has to be filled
with the next group of bytes from memory. If it is not calculated well,
you get these problems.

The original display fifo calculation caused problems on my Rage LT pro in
all 24 and 32 bpp modes. Later it became clear that Geert's VAIO had these
problems the common video modes like 640x480x8 and I started looking for fixes.
After a lot of experimenting with the original Atyfb code, ATi's ltmodset program
and the code in X, it became clear that the X code gave the best results,
it only failed in VGA text modes at non standard resolutions. I contacted
Marc Aurele la France about how he wrote them. Marc clearly did understood
the matter very well and showed me an ATi internal document that
described the situation a bit in more detail than the official documentation.
So I decided to use the same code that X uses.

So, to fix this we can look at the X driver, I must have made an error
somewhere.

Greetings,

Daniël Mantione

