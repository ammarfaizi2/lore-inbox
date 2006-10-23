Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWJWQxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWJWQxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWJWQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:53:13 -0400
Received: from witte.sonytel.be ([80.88.33.193]:25257 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932182AbWJWQxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:53:12 -0400
Date: Mon, 23 Oct 2006 18:52:39 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andi Kleen <ak@suse.de>, Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <Pine.LNX.4.64.0610230928430.3962@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0610231848240.1841@pademelon.sonytel.be>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <20061020091302.a2a85fb1.rdunlap@xenotime.net>
 <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be> <200610230059.23806.ak@suse.de>
 <Pine.LNX.4.62.0610231027130.1272@pademelon.sonytel.be>
 <Pine.LNX.4.64.0610230908570.3962@g5.osdl.org>
 <Pine.LNX.4.62.0610231812290.1841@pademelon.sonytel.be>
 <Pine.LNX.4.64.0610230928430.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006, Linus Torvalds wrote:
> On Mon, 23 Oct 2006, Geert Uytterhoeven wrote:
> > > We have tons of issues that depend on config variables and architecture 
> > > details. 
> > 
> > Indeed, so the config variables and architecture details should be handled in
> > the include files, not in the (multiple) users of those include files.
> 
> The point is - _verifying_ that is actually hard.
> 
> If some inline function depends on a particular header, you'll have a hard 
> time checking for that if there's an #ifdef around it. Which is not 
> uncommon, we have things like:
> 
> 	#ifdef CONFIG_PROCFS
> 	.. number of inline functions ..
> 	#else
> 	#define function1(a,b,c) do { } while (0)
> 	...
> 	#endif
> 
> so I'm just saying that "just compile it" is _not_ a way of verifying that 
> the header file is complete - because it may well be complete for the 
> particular config you're testing, but not for some other.
> 
> So this is a hard problem. If it was easy, we'd not _have_ the problem in 
> the first place.

I agree _verifying_ this for all config and arch combinations is hard.
But my point is that right now we're `solving' this at the user (of the
include) level, which is an order of magnitude more work.
If the includes were (sufficiently) self-contained, the driver writers would
have to care less about config/arch dependencies.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
