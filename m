Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269266AbUJFOYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbUJFOYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUJFOYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:24:03 -0400
Received: from witte.sonytel.be ([80.88.33.193]:53398 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269259AbUJFOXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:23:46 -0400
Date: Wed, 6 Oct 2004 16:23:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
 availlable
In-Reply-To: <20041006141231.GA6394@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.61.0410061619460.20160@waterleaf.sonytel.be>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
 <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be>
 <20041006121534.GA8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be>
 <20041006133310.GD8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061548390.20160@waterleaf.sonytel.be>
 <20041006141231.GA6394@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1423418003-1097072607=:20160"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1423418003-1097072607=:20160
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 6 Oct 2004, [iso-8859-1] Jörn Engel wrote:
> On Wed, 6 October 2004 15:55:52 +0200, Geert Uytterhoeven wrote:
> > > Having a non-working console, esp. for debug, is a rather odd design.
> > > My approach would be to either explicitly tell the kernel to use the
> > > other as default console via "console=/dev/ttyS0" or not have the
> > > debug thing in the kernel in the first place.  Either way, no patch is
> > > needed.
> > 
> > It was not `designed' to be that way. But due to how `the console' (nr. 2 from
> > above) works, registration order matters. If people make the mistake (or just
> > forget) to say `console=ttyS0', a debug console registered later causes
> > problems.
> > 
> > And the reason the debug consoles (read: capturers) use register_console() is
> > to avoid code duplication.
> 
> Which is fair.  So we end up with two devices claiming to be a valid
> console, but one of them makes people unhappy.  Are you certain that
> *everone* wants to have 'ttyS0' as default console and not 'debug'?

Ehrm, what do you mean with `default' console?

If you mean `console as defined under nr.2', yes, you want the console that
does do input.

> Taking the last one registered is basically random.  If people care
> enough, they should explicitly state things on the command line.

No, it's not. It's explicitly mentioned in the docs: if you use multiple
`console=', all of them get output, but input comes from the last one.

> Taking the last with input support (or the last, if none support
> input) adds some policy.  If people disagree with the kernel policy,
> they should explicitly state things...

Calling it `policy' may be a bit too strict...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---559023410-1423418003-1097072607=:20160--
