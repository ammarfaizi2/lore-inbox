Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275983AbRI1I4K>; Fri, 28 Sep 2001 04:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275984AbRI1I4C>; Fri, 28 Sep 2001 04:56:02 -0400
Received: from pc-62-30-107-95-az.blueyonder.co.uk ([62.30.107.95]:28654 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S275983AbRI1Izw>; Fri, 28 Sep 2001 04:55:52 -0400
Date: Fri, 28 Sep 2001 09:55:09 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: CPU frequency shifting "problems"
Message-ID: <20010928095509.A11996@kushida.degree2.com>
In-Reply-To: <3BB319ED.5020406@antefacto.com> <Pine.LNX.4.33.0109271619250.25667-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109271619250.25667-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Sep 27, 2001 at 04:23:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> With a CPU that does makes TSC appear constant-frequency, the fact that
> the CPU itself can go faster/slower doesn't matter - from a kernel
> perspective that's pretty much equivalent to the different speeds you get
> from cache miss behaviour etc.

On a Transmeta chip, does the TSC clock advance _exactly_ uniformly, or
is there a cumulative error due to speed changes?

I'll clarify.  I imagine that the internal clocks are driven by PLLs,
DLLs or something similar.  Unless multiple oscillators are used, this
means that speed switching is gradual, over several hundred or many more
clock cycles.

You said that Crusoe does a floating point op to scale the TSC value.
Now suppose I have a 600MHz Crusoe.  I calibrate the clock and it comes
out as 600.01MHz.

I can now use `rdtsc' to measure time in userspace, rather more
accurately than gettimeofday().  (In fact I have worked with programs
that do this, for network traffic injection.).  I can do this over a
period of minutes, expecting the clock to match "wall clock" time
reasonably accurately.

Suppose the CPU clock speed changes.  Can I be confident that
600.01*10^6 (+/- small tolerance) cycles will still be counted per
second, or is there a cumulative error due to the gradual clock speed
change and the floating-point scale factor not integrating the gradual
change precisely?

(One hardware implementation that doesn't have this problem is to run a
small counter, say 3 or 4 bits, at the nominal clock speed all the time,
and have the slower core sample that.  But it may use a little more
power, and your note about FP scaling tells me you don't do that).

thanks,
-- Jamie
