Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264687AbUEEVm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbUEEVm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 17:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264690AbUEEVm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 17:42:58 -0400
Received: from hell.org.pl ([212.244.218.42]:64006 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264687AbUEEVm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 17:42:56 -0400
Date: Wed, 5 May 2004 23:43:01 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, swsusp-devel@lists.sourceforge.net
Subject: Re: swsusp documentation updates
Message-ID: <20040505214301.GA27339@hell.org.pl>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	acpi-devel@lists.sourceforge.net,
	swsusp-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux-kernel@vger.kernel.org>, acpi, swsusp
Bcc: 
Subject: Re: swsusp documentation updates
Reply-To: 
In-Reply-To: <1Srcw-5NU-25@gated-at.bofh.it>

Thus wrote Pavel Machek:
> +Q: Does linux support ACPI S4?
> +
> +A: No.

I believe pmdisk uses proper S4 by default.

> +That means that machine does not enter S4 on suspend-to-disk, but
> +simply enters S5. That has few advantages, you can for example boot
> +windows on next boot, and return to your Linux session later. You
> +could even have few different Linuxes on your box (not sharing any
> +partitions), and switch between them.

That's bogus. Entering S4 does not prevent booting multiple systems, or at
least the ACPI spec does not contradict this possibility. S4 and S5 are
nearly identical in that matter (see section 9.1.4).

> +It also has disadvantages. On HP nx5000, if you unplug power cord
> +while machine is suspended-to-disk, Linux will fail to notice that.

Hmm, people were reporting that on the swsusp mailing list. The
aforementioned section contains some notes about hardware state changes
over suspend, but I don't really know if Linux makes use of that.

Apart from that, there seem to differences in handling PMEs -- the RTC
alarm event works fine for me if the box enters S4 and does not if it's at
S5. Wake-On-LAN may suffer the same problems, depending on the machine.

If I may suggest something, it would be stupid to turn down S4 completely,
especially that infrastructure to chose S4 over pm_power_off() already
exists (/sys/power/).

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
