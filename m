Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269217AbUJFOMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269217AbUJFOMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUJFOMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:12:39 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:33678 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269217AbUJFOMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:12:33 -0400
Date: Wed, 6 Oct 2004 16:12:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-ID: <20041006141231.GA6394@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua> <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be> <20041006121534.GA8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be> <20041006133310.GD8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061548390.20160@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410061548390.20160@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: geert@linux-m68k.org, willy@w.ods.org, vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 15:55:52 +0200, Geert Uytterhoeven wrote:
> 
> One problem is that `console' means multiple things:
>   1. The output device for printk() (multiple consoles are allowed, cfr.
>      multiple console= kernel parameters and debug-only consoles)
>   2. The tty (both input and output) for /sbin/init (only one instance, cfr.
>      the last console= kernel parameter)

Correct.  It may be nice have a seperate logic for 1.  'console' is a
good name for 2., so I would keep that.  But then again, I don't care
enough to write a patch.

> I suggested to change the logic for 2 not to use the last console= kernel
> parameter if it turns out not to support input (cfr. the return value of struct
> console.device()), but try the other registered struct consoles.
> 
> [...]
>
> > Having a non-working console, esp. for debug, is a rather odd design.
> > My approach would be to either explicitly tell the kernel to use the
> > other as default console via "console=/dev/ttyS0" or not have the
> > debug thing in the kernel in the first place.  Either way, no patch is
> > needed.
> 
> It was not `designed' to be that way. But due to how `the console' (nr. 2 from
> above) works, registration order matters. If people make the mistake (or just
> forget) to say `console=ttyS0', a debug console registered later causes
> problems.
> 
> And the reason the debug consoles (read: capturers) use register_console() is
> to avoid code duplication.

Which is fair.  So we end up with two devices claiming to be a valid
console, but one of them makes people unhappy.  Are you certain that
*everone* wants to have 'ttyS0' as default console and not 'debug'?

Taking the last one registered is basically random.  If people care
enough, they should explicitly state things on the command line.

Taking the last with input support (or the last, if none support
input) adds some policy.  If people disagree with the kernel policy,
they should explicitly state things...

Policy inside the kernel sounds like a bad idea.  People can already
get what they want, if they...  Policy will help some people with
similar taste, but people with different taste can "argue" against it
and someone has to play judge - not my cup of tea.

Jörn

-- 
Premature optimization is the root of all evil.
-- Donald Knuth
