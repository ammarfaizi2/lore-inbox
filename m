Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTJJMYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTJJMYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:24:41 -0400
Received: from lucidpixels.com ([66.45.37.187]:35490 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261670AbTJJMYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:24:40 -0400
Date: Fri, 10 Oct 2003 08:24:38 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: ABIT IC7-G Linux Kernel Power Off Issue
Message-ID: <Pine.LNX.4.58.0310100822430.27952@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to let everyone know I finally got a response with this issue:

-> Question, will this be fixed in 2.4?

Thanks to Andrew:

Subject:      Re: ABIT IC7-G Power Off Issue
From:         Andrew Schulman <andrex@deadspam.com>
Newsgroups:   alt.comp.periphs.mainboard.abit
Date:         Thu, 09 Oct 2003 19:59:16 -0400

> After executing: shutdown -i 0 -g 0 -y
> Gets to:
> Flushing hda hdb hdc, etc, then
> Power Down.
>
> But then it stays here, everything stays on, the video, the box, etc.

I used to have this exact problem.  I solved it by forcing the ospm_system
module to load at boot time, by mentioning it in /etc/modules.
ospm_system
is part of ACPI; on your system it might be a different module, e.g. if
you
use APM.

What seems to happen is that at power down, the last thing the kernel
wants
to do is to call ospm_system to turn the power off.  But the kernel module
loader has already been shut down, so if the module hasn't already been
loaded, it can't load and the kernel hangs.

I had this problem with the 2.4 kernels, but I believe it's been solved in
2.6.  I'm running 2.6.0-test4, and now that I look back I find that I
don't
even have an ospm_system module any more.  But the system still powers
down
correctly.  The last message I see on the screen now is "calling
acpi_power_off".  This isn't a module; it seems to be a function that's
built into the kernel when ACPI support is enabled.

Good luck,
Andrew.

-- 
To reply by email, change "deadspam.com" to "alumni.utexas.net"

