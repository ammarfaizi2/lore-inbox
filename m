Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTJMRb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTJMRb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 13:31:58 -0400
Received: from gprs144-35.eurotel.cz ([160.218.144.35]:34947 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261580AbTJMRbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 13:31:55 -0400
Date: Mon, 13 Oct 2003 19:30:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -test7: /sys/power/disk not reading right data?
Message-ID: <20031013173058.GI15441@elf.ucw.cz>
References: <20031010091031.GA5018@elf.ucw.cz> <Pine.LNX.4.44.0310130946150.17450-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310130946150.17450-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What advantages does disk/ state separation have? I believe that echo
> > swsusp > state (or echo s4bios > state or echo disk-firmware > state)
> > is the right interface, and that we want to do echo "s4bios" >
> > on_battery_low or similar interface. (echo "mem" > on_battery_low
> > makes sense, too, toshiba notebooks do that for example).
> 
> The string 's4bios' only makes sense on systems that support it, while 
> 'disk' is concise and obvious, regardless on how your platform implements 
> it. I don't want to have options that are only relevant on a subset of the 
> systems out there. 

So call it disk-firmware.

The two-files interface is accident waiting for happen. (And accident
that already happened, it crashed my machine at least twice).

Assume your user has 'echo platform > /sys/power/disk', and has
suspend partition configured for BIOS.

He's used to suspending by echo disk > /sys/power/state. One day, for
whatever reason (new kernel does not recognize s4bios?) platform
suspend is unavailable. echo > /sys/power/disk is going to fail, but
user is very unlikely to notice that. He is also very unlikely to cat
/sys/power/disk before doing suspend. He does 'echo disk >
/sys/power/disk', machine does swsusp (ouch). He can still save his
data by adding resume=... parameter on next boot, but I guess it is
unlikely to happen.

This looks very much like "trap for user" to me, and that trap already
got me twice (s4bios does not really work here now, and I was trying
to test pmdisk. It took me two fsck-s before I found out whats
happening).

If you want to have concise and obvious interface, do echo
'disk-platform' vs. 'disk-firmware', or whatever, but please do not
use two files.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
