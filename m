Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265297AbVBEIQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbVBEIQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 03:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265389AbVBEIQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 03:16:33 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:8626 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S265297AbVBEIQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 03:16:22 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105020418306a4c2c93@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <1107569089.8575.35.camel@tyrosine>
	 <9e4733910502041809738017a7@mail.gmail.com>
	 <1107569842.8575.44.camel@tyrosine>
	 <9e47339105020418306a4c2c93@mail.gmail.com>
Date: Sat, 05 Feb 2005 08:15:35 +0000
Message-Id: <1107591336.8575.51.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [RFC] Reliable video POSTing on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 21:30 -0500, Jon Smirl wrote:

> I suspect the problem in that case is a compressed VBIOS. Some laptops
> compress the VBIOS and the system BIOS into a single ROM and then
> expand them at power on. Sounds like this is not happening on resume.
> To get around the problem copy the image from C000:0 before suspend to
> a place in preserved RAM where wakeup.S can find it and then copy it
> back to C000:0 on resume. To test for this checksum C000:0 before
> suspend and after and see if it has changed.

No, that's not what's happening. If you disassemble the code at
c000:blah in a laptop, you'll often find that it jumps off to a
completely different section of address space. During POST, that
contains video BIOS. After POST, it may be something like USB boot
support. Without reading it directly out of flash, it's not possible to
recover that code.

> You can always do a simple test. If a program like vbios.vm86 or
> vbetool can reset the card, then there is no reason wakeup.S shouldn't
> be able to do it too if the environment is set up correctly.

These tools can cause machines to hang, even if run immediately after
boot (and without X running). On other machines, things are less bad -
they just switch the backlight off instead. On some machines (Thinkpads
are quite good in this respect), they'll work nicely.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

