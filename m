Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUG3TN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUG3TN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267801AbUG3TN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:13:58 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:56962 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267799AbUG3TN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:13:27 -0400
Date: Fri, 30 Jul 2004 21:14:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Torrey Hoffman <thoffman@arnor.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730191448.GA2461@ucw.cz>
References: <1091207136.2762.181.camel@rohan.arnor.net> <20040730172433.2312.qmail@web14924.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730172433.2312.qmail@web14924.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 10:24:33AM -0700, Jon Smirl wrote:
> --- Torrey Hoffman <thoffman@arnor.net> wrote:
> > This sounds interesting, but I'm curious...  why?  That is, what
> > problem are you solving by making ROMs exposed?
> > 
> > Or is this just for fun?  (That's a legitimate reason IMO...)
> 
> Secondary video cards need to have code in their ROMs run to reset
> them. When an x86 PC boots it only reset the primary video device, the
> secondary ones won't work until their ROMs are run.
> 
> Another group needing this is laptop suspend/resume. Some cards won't
> come back from suspend until their ROM is run to reinitialize them.

Another trick laptops can do is that after a resume the card is in
uninitialized state _and_ the video ROM is not there, because the system
BIOS didn't copy it to the right location (when it's stored in a shared
flash). Then you definitely need your own copy from the real boot.

> A third group is undocumented video hotware where the only way to set
> the screen mode is by calling INT10 in the video ROMs. (Intel
> i810,830,915 for example).
> 
> Small apps are attached to the hotplug events. These apps then use vm86
> or emu86 to run the ROMs. emu86 is needed for ia64 or ppc when running
> x86 ROMs on them.

I'm starting to think that using emu86 always (independent on the
architecture) would be best. It's not like the execution speed is the
limit with video init, and it'll allow to find more bugs in emu86 when
it's used on i386 as well. It'll be needed for x86-64 (AMD64 and intel
EM64T) anyway.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
