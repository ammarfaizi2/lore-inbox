Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTIQUmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbTIQUmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:42:32 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:4531 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S262765AbTIQUmX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:42:23 -0400
Date: Wed, 17 Sep 2003 22:42:19 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: Patch: Make iBook1 work again
In-Reply-To: <1063829278.600.184.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309172218210.25790-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Sep 2003, Benjamin Herrenschmidt wrote:

> Unfortunately, the wallstreet doesn't work neither. I get something strange on the
> screen. It's somewhat sync'ed but divided in 4 vertical stripes, each one displaying
> the left side of the display (+/- offseted), along with some fuzziness (clock wrong).
>
> XFree86 "ati" driver works fine (and manages somewhat to probe the panel type
> and clocks properly ...)
>
> It's an LT-G (0x4c47 rev 0x80), 14.31818 XTAL, 230Mhz PLL, 63Mhz MCLK & XCLK
> (so far it sounds good), mode properly detected (1024x768-60 from the mac
> sense values read in nvram) but the display isn't correct.
>
> I can do register dumps to compare, though I may not have time until next week.

Ok, this is the first serious problem, this was not were I expected the
problems. The Rage LT should not be treated differently than before, no
changes made here.

The first thing to do is to check is if the clock programming code is the
problem. Try to modprobe with "default_mclk=-1 default_xclk=-1" or use
equivalent kernel command line options.

If clock programming code should be blamed, the next step is to enable the
debug define and check which clock registers are modified. You can
try to revert my changes at mach64_ct.c line 375 and 433 to see if that
changes something.

If X corrects the display after starting, the problem might be due to the
mode setting code. In that case the display should corrupt again when
switching back to the console.

Greetings,

Daniël Mantione

