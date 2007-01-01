Return-Path: <linux-kernel-owner+w=401wt.eu-S1754725AbXAAXR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbXAAXR3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbXAAXR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:17:29 -0500
Received: from sitemail2.everyone.net ([216.200.145.36]:51251 "EHLO
	omta14.mta.everyone.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754739AbXAAXR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:17:29 -0500
X-Eon-Dm: dm21
X-Eon-Sig: AQHOS7NFmZaIQcq+7QIAAAAC,3f4da53e59e604967b1be2df4c8e210a
Date: Mon, 1 Jan 2007 18:17:25 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.20-rc1 0/6] arch-neutral GPIO calls
Message-ID: <20070101231725.GA29858@double.lan>
References: <20061231191137.GA5290@double.lan> <200701011206.20132.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701011206.20132.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Mon, Jan 01, 2007 at 12:06:19PM -0800, David Brownell wrote:
> > The concern I have with your current implementation is that I don't
> > see a way to flexibly add in support for additional gpio pins on a
> > machine by machine basis.  The code does do a good job of abstracting
> > gpios based on the primary architecture (eg, PXA vs OMAP), but not on
> > a chip basis (eg, PXA vs ASIC3).
> 
> You used the key word:  implementation.  The interface allows it,
> but such board-specific extensions haven't yet been needed; so
> they've not yet been implemented.
> 
> See the appended for a patch roughly along the lines of what has
> previously been discussed here.  No interface change, just updated
> implementation code.  And the additional implementation logic won't
> kick on boards that don't need it.

Thanks for enlightening me on previous discussions.  The interface in
the "gpiolib" patch is along the lines of what I'm looking for.

However, I still feel this approach is backwards.  Going from a
'struct gpio' to an 'int gpio' is easy.  Attempting to go from an 'int
gpio' to a 'struct gpio' is hard, as the code you provide
demonstrates.

Can you help explain what the gain to using an integer over a 'struct
gpio' is?  I can't help but feel that fundamentally gpios are not
integers and that it is a mistake to code an API around that concept.

> Note that the current implementations are a win even without yet
> being able to handle the board-specific external GPIO controllers.
> The API is clearer than chip-specific register access, and since
> it's arch-neutral it already solves integration problems (like
> having one SPI controller driver work on both AT91 and AVR).

I agree that the code you provide is a big step up from the existing
code.  We also both seem to agree that more than just an arch
abstraction is necessary (the cansleep stuff seems to be an
acknowledgment of this).

However, I don't understand the downside to making the API sane from
the start and avoiding the artificial integer namespace problems.

> Note that I see that kind of update as happening after the first round
> of patches go upstream:  accept the interface first, then update boards
> to support it ... including later the cansleep calls, on some boards.

Once many of the problems are fixed, I fear fixing the remaining will
be a harder sell.  Due to the difficulty of implementing kernel wide
APIs, I suspect some maintainers will just stick to cramming features
in the arch directory (as your patch encourages) which can lead to
duplicated code and fragmented implementations.

Thanks for working on this.
-Kevin
