Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUAEWrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUAEWqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:46:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:34948 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265983AbUAEWdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:33:25 -0500
Subject: Re: [2.6.0-mm2] PM timer still has problems
From: john stultz <johnstul@us.ibm.com>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040105221758.GA13727@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl>
	 <1073340716.15645.96.camel@cog.beaverton.ibm.com>
	 <20040105221758.GA13727@hell.org.pl>
Content-Type: text/plain
Message-Id: <1073341969.15645.106.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 05 Jan 2004 14:32:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 14:17, Karol Kozimor wrote:
> Thus wrote john stultz:
> > If the override boot option failed, its most likely your system doesn't
> > have an ACPI PM time source.  Instead it seems your system is having
> 
> Well, I don't have the slightest idea on how to determine this, though I
> read somewhere that all ACPI-compliant systems have those.

More debug output is probably needed. 

> > trouble using the PIT as a time source (which seems not all that
> > uncommon unfortunately). 
> 
> Perhaps, though bear in mind it behaves so only if clock=pmtmr has been
> appended and works fine with clock=pit.

Ah, I must have missed that point. Indeed that is very odd. When booting
without the clock= what time source is used? Does booting w/
"clock=crazy" also show the problem?

> > I guess we can just re-call select_timer() without an override if the
> > override fails, that way you'll fall back to the default time source on
> > your system. Try the (compile tested) patch below and see if that helps.
> 
> That would be PIT again, as TSC is unusable due to CPUFreq.
> I'll try it ASAP -- should I test with Dmitry's patch applied?

No, my patch is just against 2.6.1-rc1 (really I should have checked if
it applies onto mm2, but I didn't). Due to the misunderstanding above,
I'm actually more interested in the questions I just asked then if the
last patch worked (but if you're feeling bored, don't let me stop you
from testing it :)

thanks
-john


