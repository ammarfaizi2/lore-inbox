Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVKHM4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVKHM4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVKHM4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:56:33 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:51848 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965087AbVKHM4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:56:32 -0500
Date: Tue, 8 Nov 2005 13:56:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: tglx@linutronix.de, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: CLOCK_REALTIME_RES and nanosecond resolution
In-Reply-To: <1131443137.4652.101.camel@gaston>
Message-ID: <Pine.LNX.4.61.0511081332080.1387@scrub.home>
References: <1131418511.4652.88.camel@gaston>  <1131442459.18108.75.camel@tglx.tec.linutronix.de>
 <1131443137.4652.101.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Nov 2005, Benjamin Herrenschmidt wrote:

> > This is the resolution which you can expect for timers (nanosleep and
> > interval timers) as the timers depend on the jiffy tick.
> > 
> > The resolution of the readout functions is not affected by this.
> 
> Ok, thanks, POSIX spec wasn't very clear about that 

Actually the spec is a bit more clear than that:

"This volume of IEEE Std 1003.1-2001 defines functions that allow an 
application to determine the implementation-supported resolution for the 
clocks and requires an implementation to document the resolution supported 
for timers and nanosleep() if they differ from the supported clock 
resolution."

Historically the clock and timer resolution was equal and e.g. 
clock_gettime() returned a msec value. To get usec resolution one had to 
enable the MICRO_TIME, but this didn't change the clock_getres() value, as 
at that time higher clock_gettime() resolution was interpolated from a 
second time source and the actual clock tick remained unchanged. 
Subsequent UNIX generations have preserved this behaviour.

Thomas' expectation is not generally true, non-UNIX implementations return 
different values here and his expectation is not required by POSIX, it's 
more a traditional UNIX behaviour.

bye, Roman
