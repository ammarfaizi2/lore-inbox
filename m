Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269171AbUJFPiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269171AbUJFPiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269299AbUJFPiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:38:16 -0400
Received: from witte.sonytel.be ([80.88.33.193]:950 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269171AbUJFPgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:36:47 -0400
Date: Wed, 6 Oct 2004 17:36:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
 availlable
In-Reply-To: <20041006152848.GA10153@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.61.0410061731480.20160@waterleaf.sonytel.be>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
 <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be>
 <20041006121534.GA8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be>
 <20041006133310.GD8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061548390.20160@waterleaf.sonytel.be>
 <20041006141231.GA6394@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061619460.20160@waterleaf.sonytel.be>
 <20041006152848.GA10153@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-2110444415-1097076977=:20160"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-2110444415-1097076977=:20160
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 6 Oct 2004, [iso-8859-1] Jörn Engel wrote:
> On Wed, 6 October 2004 16:23:27 +0200, Geert Uytterhoeven wrote:
> > Ehrm, what do you mean with `default' console?
> > 
> > If you mean `console as defined under nr.2',
> correct
> > yes, you want the console that
> > does do input.
> 
> *I* don't always do.  Remember how this thread got started? ;)

OK, so you want /dev/console to fall back to /dev/null, right?

> > > Taking the last one registered is basically random.  If people care
> > > enough, they should explicitly state things on the command line.
> > 
> > No, it's not. It's explicitly mentioned in the docs: if you use multiple
> > `console=', all of them get output, but input comes from the last one.
> 
> Ah, true.  I was barking up the "the was no 'console=' option, take
> the default" tree.  Just started looking at the console code a few
> days ago.

Well, you're right that if the user specifies _no_ console= option at all, the
`first one in the linked list' will be used, which is the last one registered.
Usually (read: if enabled) tty0 registers automatically, and it's the only one.

Saying e.g. `console=ttyS0' causes the serial console to register itself (at
the head of the list).
Saying e.g. `console=tty0' afterwards causes the VT console to move back to the
head of the list.

So _if_ there are multiple struct consoles activated, order (read: policy) does
matter. But usually there's only one, and all others are explicitly to be
enabled with console=.

Anyway, I should cook up a patch so the /dev/console demux walks the list if
the one at the head of the list doesn't do input (read: it has no associated
tty struct).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---559023410-2110444415-1097076977=:20160--
