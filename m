Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWHXKMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWHXKMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWHXKMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:12:33 -0400
Received: from tim.rpsys.net ([194.106.48.114]:41605 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751019AbWHXKMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:12:32 -0400
Subject: Re: Re : [HELP] Power management for embedded system
From: Richard Purdie <rpurdie@rpsys.net>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com>
References: <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 11:12:05 +0100
Message-Id: <1156414325.5555.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 09:37 +0000, moreau francis wrote:
> Is there something specific to ARM in this implementation ? I don't think
> so and it's surely the reason why MIPS did copy it with almost no changes.
> I understand that ARM implementation has been the first one but maybe now
> why not making it the common power management for embedded system that
> could be used by all arches which need it ?
> 
> BTW, why has apm_cpu_idle() logic been removed from ARM implementation ?
> 
> > The power management really comes from the Linux drivers themselves,
> > which are written to peripherals off when they're not in use.  The other
> > power saving comes from things like cpufreq - again, nothing to do with
> > the magical "APM" or "ACPI" terms.
> 
> BTW why is it still called "APM" on ARM ?

It provides an apm_bios device which behaves the same way as a "real"
APM bios on x86. The same apmd used on x86 can be used on ARM.

Its main purpose is to be to run suspend/resume events past userspace
before acting on them (and allow suspend/resume events to be triggered
from userspace). It also allows exporting of battery status information
to userspace in a rather broken way. 

It would be nice to move that to some arch independent generic
implementation of these things and to leave the APM emulation behind.
The battery information should be a sysfs class (see the backlight/led
classes as examples of sysfs classes). The suspend/resume event handling
would be something new as far as I know and ideally should support
suspending/resuming individual sections of device hardware as well as
the whole system. The linux-pm mailing list might have more of an idea
of whether these things are being worked on and their current status.

Regards,

Richard

