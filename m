Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271744AbTGXV4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 17:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271743AbTGXV4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 17:56:12 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:34197 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271745AbTGXV4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 17:56:10 -0400
Date: Fri, 25 Jul 2003 00:10:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: weissg@vienna.at, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] OHCI problems with suspend/resume
Message-ID: <20030724221059.GC348@elf.ucw.cz>
References: <20030723220805.GA278@elf.ucw.cz> <3F1F342F.70701@pacbell.net> <20030724102432.GB228@elf.ucw.cz> <3F2012F8.8030103@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2012F8.8030103@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Can you try echo 4 > /proc/acpi/sleep? echo 3 breaks it, too, but that
> >is little harder to set up.
> 
> I usually test with "apm -s" ... since I've yet to come up with
> an ACPI configuration that works properly.  IRQ misconfiguration
> for USB is still a blocking issue for many people (not just me).

Actually, you do not need acpi to test swsusp (echo 4 >
/proc/acpi/sleep is the easiest way, but there's syscall to do the
same).

> Going through ACPI would certainly explain some breakage; it's
> been sufficiently troublesome with USB that it's not gotten much
> testing at all.  I happened to notice this morning that ACPI's
> USB IRQ problems are one of the longest-standing open 2.6 bugs:
> http://bugme.osdl.org/show_bug.cgi?id=10 ... and it's now been
> migrated into the 2.4.22-pre series (sigh).

That's okay, ACPI in 2.4.22-pre just replaced older ACPI and
even-more-buggy ACPI in 2.4.21.

> Could you try reproducing this failure using just APM?  I could
> believe there's a generic PM issue (I've been expecting 2.6-test
> to eventually start shaking PM out); but given the amount of
> trouble ACPI has caused, we should first rule that factor out.

ACPI is not much involved. If you want, I can (attempt to) make swsusp
work on your machine....

> >Actually, as PCI interrupts are shared, I do not find that too
> >surprising. 
> 
> I do.  Sharing is irrelevant.  If it's been cleaned up, then
> the IRQ should no longer be bound to that device.

ohci_stop() does not seem to unregister IRQ...

> >That would be good. I definitely had another failure path, where it
> >did not tell me that hcd is no K.O...
> 
> I'll likely submit that to Greg in the next few days, cc you.

Okay, thanx.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
