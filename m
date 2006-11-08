Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754402AbWKHHU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbWKHHU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 02:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754404AbWKHHU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 02:20:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754402AbWKHHU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 02:20:26 -0500
Date: Tue, 7 Nov 2006 23:19:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, teunis <teunis@wintersgift.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       john stultz <johnstul@us.ibm.com>, Len Brown <lenb@kernel.org>
Subject: Re: various laptop nagles - any suggestions?   (note:
 2.6.19-rc2-mm1 but applies to multiple kernels)
Message-Id: <20061107231903.99156678.akpm@osdl.org>
In-Reply-To: <1161552160.22373.17.camel@localhost.localdomain>
References: <4537A25D.6070205@wintersgift.com>
	<20061019194157.1ed094b9.akpm@osdl.org>
	<4538F9AD.8000806@wintersgift.com>
	<20061020110746.0db17489.akpm@osdl.org>
	<1161368034.5274.278.camel@localhost.localdomain>
	<20061020112627.04a4035a.akpm@osdl.org>
	<1161370015.5274.282.camel@localhost.localdomain>
	<20061020121537.dea13469.akpm@osdl.org>
	<20061020203731.GA22407@elte.hu>
	<20061020135450.6794a2bb.akpm@osdl.org>
	<20061020205651.GA26801@elte.hu>
	<20061020182527.a07666a4.akpm@osdl.org>
	<1161424147.5274.400.camel@localhost.localdomain>
	<1161552160.22373.17.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006 23:22:39 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> This LAPIC business is weird.

So I tested your latest set of patches on the Vaio.  Still not very good. 
It all _seems_ to work for a while.  But after a suspend-to-disk/resume
cycle (which may not be relevant) and five-odd minutes uptime the machine
shat itself.

See http://userweb.kernel.org/~akpm/1.txt for the whole log and
http://userweb.kernel.org/~akpm/config-sony.txt for the config.

It's presently sitting in an xterm echoing keyboard input and permitting
the mouse cursor to move, but it doesn't do anything else.



I have a bad feeling about the hrtimer+dynticks patches, frankly.  We had a
lot of discussion and review of the original patchset and it almost all
seemed OK apart from this tsc-goes-silly problem.  But then this lot:

highres-timer-core-fix-status-check.patch
highres-timer-core-fix-commandline-setup.patch
clockevents-smp-on-up-features.patch
highres-depend-on-clockevents.patch
i386-apic-cleanup.patch
pm-timer-allow-early-access.patch
i386-lapic-timer-calibration.patch
clockevents-add-broadcast-support.patch
clockevents-add-broadcast-support-fix.patch
acpi-include-apic-h.patch
acpi-include-apic-h-fix.patch
acpi-keep-track-of-timer-broadcast.patch
i386-apic-timer-use-clockevents-broadcast.patch
acpi-verify-lapic-timer.patch
acpi-verify-lapic-timer-exports.patch
acpi-verify-lapic-timer-fix.patch

got merged and I haven't looked at any of that and I don't know that anyone
else has and I don't even know if anyone knows what's in there.

But I do know that it fiddles with APICs, and they are quick to anger.  I
have little confidence in merging all of that material.

I'll retain it all for a while so that we can continue to try to fix this
APIC problem but if/when we get that done I think it's time to drop all of
it and start again, because APIC changes really do need a lot of careful
review and thought.

<cycles the power>

No, it's no good at all.  This time it just went back to its old ways of
taking a month to get through initscripts.
