Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVACFKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVACFKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 00:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVACFKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 00:10:52 -0500
Received: from orb.pobox.com ([207.8.226.5]:33983 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261384AbVACFK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 00:10:29 -0500
Date: Sun, 2 Jan 2005 21:10:18 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: lindqvist@netstar.se, pavel@ucw.cz, edi@gmx.de, john@hjsoft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1104696556.2478.12.camel@pefyra>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 09:09:16PM +0100, Håkan Lindqvist wrote:
> On sön, 2005-01-02 at 13:42 -0500, John M Flinchbaugh wrote:
> > pci=routeirq worked for me to get my e100 working again after resume.
> 
> For the record: It works around my problems with e100 and snd-intel8x0,
> too.

I previously mentioned that "pci=routeirq" works to fix my 8139too
problems. However, I just figured out that if I use "acpi=noirq" or
"pci=noacpi" instead of "pci=routeirq", that works too. (This is with
2.6.10-bk4.)

[snip]
> The Documentation/kernel-parameters.txt says this about pci=routeirq:
> "Do IRQ routing for all PCI devices. This is normally done in
> pci_enable_device(), so this option is a temporary workaround for broken
> drivers that don't call it."
> 
> Ie, it doesn't sound too bad to use it until the problem is solved.
> And I don't know if this particular issue is a case of broken drivers,
> but that was what the parameter was added to work around.

I don't think this is a case of broken drivers. So far in this thread, it's
been seen with e100, 8139too, snd-intel8x0, and probably one of the USB
drivers too. And the problem happens even if the module is unloaded and
reloaded -- unless I'm seriously missing something, this probably means
pci_enable_device() is unable to do its job properly for some reason --
but only after a swsusp resume.

It would also be informative to examine the kernel command line options
that are making the problem go away:

pci=routeirq
acpi=off
acpi=noirq
pci=noacpi

What do they all have in common? ACPI. (AFAICT from my reading of the
source code, on i386 pci=routeirq only has an effect if ACPI is being
used for IRQ routing.)

So, I think this bug probably lies in ACPI or swsusp. I highly *highly*
doubt it's driver bugs. Hopefully I'll have time later tonight or
tomorrow morning to see if I can figure anything else out...

-Barry K. Nathan <barryn@pobox.com>

