Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTJJJLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbTJJJLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:11:04 -0400
Received: from gprs148-28.eurotel.cz ([160.218.148.28]:25472 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262731AbTJJJK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:10:59 -0400
Date: Fri, 10 Oct 2003 11:10:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -test7: /sys/power/disk not reading right data?
Message-ID: <20031010091031.GA5018@elf.ucw.cz>
References: <20031010081728.GA218@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010081728.GA218@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm seeing this on -test7 (tainted:pavel, but I did not touch this
> area).

Reproduced on -test7-bk, vanilla.

I really do not think that 2 separate files (disk, state) are good
idea. It bitten me, again. I did echo -n platform > disk, echo -n disk
> state. Unfortunately kernel somehow decided that platform suspend is
not supported, but honoured second request. Result is crash, of
course. This error would be avoided if I said echo -n swsusp > state
(or similar), because unrecognized/unsupported request would be simply
not done.

What advantages does disk/ state separation have? I believe that echo
swsusp > state (or echo s4bios > state or echo disk-firmware > state)
is the right interface, and that we want to do echo "s4bios" >
on_battery_low or similar interface. (echo "mem" > on_battery_low
makes sense, too, toshiba notebooks do that for example).

> root@amd:~# echo -n platform > /sys/power/disk
> root@amd:~# dmesg | tail -1
> PM: suspend-to-disk mode set to 'platform'
> root@amd:~# cat /sys/power/disk
> firmware
> root@amd:~#

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
