Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWHYLEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWHYLEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWHYLEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:04:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65457 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750771AbWHYLEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:04:51 -0400
Date: Fri, 25 Aug 2006 13:04:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-pm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060825110441.GB8538@elf.ucw.cz>
References: <20060822103731.GC13782@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822103731.GC13782@mellanox.co.il>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm running Linus' git tree on my thinkpad T60.
> It generally seems to work fine after suspend to disk.
> However, the system does not come out of suspend to ram,
> with screen staying blank. I'm looking for hints for debugging this.
> 
> If I set suspend/resume event tracing, I see this in dmesg
> after reboot:
> 
> dmesg -s 1000000 | grep 'hash matches'
>   hash matches drivers/base/power/resume.c:42
>   hash matches device serio2
> 
> serio2 seems to be the psmouse device:
> ls /sys/bus/serio/drivers/psmouse/
> bind bind_mode description serio0 serio2 unbind
> 
> Does this mean the mouse driver blocks the resume?
> 
> I've rebuilt psmouse as a module, unloaded it before suspend, and now
> I see the same behaviour but after reboot:
> dmesg -s 1000000 | grep 'hash matches'
>   hash matches drivers/base/power/resume.c:42
>   hash matches device i2c-9191
> 
> Which is somewhat weird because
> ls /sys/bus/i2c/devices
> does not list any i2c devices
> 
> I could continue disabling stuff - but I am looking in the
> correct place even? How do you debug resume issues?

Yes, disabling stuff is way to go. Just disable everything, and binary
search from there :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
