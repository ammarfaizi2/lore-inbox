Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWH1FwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWH1FwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 01:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWH1FwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 01:52:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751371AbWH1FwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 01:52:24 -0400
Date: Sun, 27 Aug 2006 22:52:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Perkel <marc@perkel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: Linux v2.6.18-rc5
In-Reply-To: <44F27C6C.30709@perkel.com>
Message-ID: <Pine.LNX.4.64.0608272246350.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <44F27C6C.30709@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Aug 2006, Marc Perkel wrote:
>
> You might want to look at this bug.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6975
> 
> The current kernel doesn't run on Asus Motherboards that use the new AM2 CPUs.
> Should this be addressed before 2.6.18 is finished?

Hmm. Can you verify that the system boots fine if you get rid of 
acpi_skip_timer_override as per the hint from Prakash Punnoor?

That is, in the file arch/x86_64/kernel/io_apic.c, find the place where it 
does something like

	...
	if (nvidia_hpet_detected == 0) {
		acpi_skip_timer_override = 1;
		printk(KERN_INFO "Nvidia board "
			"detected. Ignoring ACPI "
			"timer override.\n");
	}
	...

and just comment that whole thing out (or at least the assignment that 
sets the "acpi_skip_timer_override" variable to 1).

Andi? You were talking about how the 64-bit machines don't have some of 
the cruft that the old PC's have.. It looks like they are accumulating 
_more_ cruft than regular x86 ever had...

		Linus
