Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUIDK72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUIDK72 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269876AbUIDK71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:59:27 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:61630 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267659AbUIDK7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:59:14 -0400
Date: Sat, 4 Sep 2004 11:59:12 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Patrick McFarland <diablod3@gmail.com>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [BUG] r200 dri driver deadlocks
In-Reply-To: <d577e569040904021631344d2e@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409041158300.25475@skynet>
References: <d577e569040904021631344d2e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you insmod the radeon drm module with drm_opts=debug do the test and
send on the trace, it may be getting wedged somewhere unexpected...

Dave.

>
> All of this was tested with a virgin 2.6.8.1 (with debug info and
> frame pointers enabled) and Debian's XFree86 4.3.0.1, using DarkPlaces
> and Twilight (both popular quakeGL engine forks) as test apps, unless
> otherwise noted.
>
> Thanks to wli (who I owe at least one beer for this, may be an entire
> case), we've been able to figure exactly whats going on. The driver is
> turning off interrupts, then deadlocking. (No sysrq, no sshing in,
> capslock's light doesn't work.)
>
> Turning the NMI watchdog on, it 'fixes' the deadlock (and thanks to
> the watchdog, ssh and sysrq now work, but capslock's light still
> doesn't work), but the app and X are still dead, but now I can ssh in
> and kill -9 them both,  however, and quite obviously, I can't start
> another X, but I can reboot cleanly.
>
> Things already tested that don't effect bug:
> Turning SMP on or off
> Turning 4k stacks on or off
> Using new radeon fbcon, using old radeon fbcon, using no fbcon
> Turning Local APIC for uniproc and/or IO-APIC for uniproc on or off
> Turning preempt on or off
> Using mem=nopentium
> Waving a dead chicken over the box
>
> Things already tested for:
> Kernels as far back as 2.6.0 have this bug, haven't tested any earlier
>
> Thanks to netconsole (who I recommend to anyone that can't setup
> serial console stuff), I was able to capture the entire kernel output,
> including sysrq-t output right after my test app crashes.
>
> I'm including both the netconsole output and the .config. vmlinux and
> radeon.ko (and anything else you need) are available upon request.
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

