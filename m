Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272379AbVBEPzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272379AbVBEPzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 10:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVBEPzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 10:55:43 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:38823 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S272591AbVBEPz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 10:55:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ojONxIfw7m78G6mEacQ2gDYN8R/WP3o8YTldV7+Khrx2KecLKK8zWbRLgghdefi5NW5o+IqcASjY7yB1Hz9+TPac1Zgse5Q0mbW+KLNPOMhi/mAi0JZUiPd0x4OL/XovKCLGTEyMjRoyza8jyKVzTGYuAiNHH/CQfDrTGAyUeHQ=
Message-ID: <9e47339105020507552d93bd79@mail.gmail.com>
Date: Sat, 5 Feb 2005 10:55:29 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1107591336.8575.51.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <1107569089.8575.35.camel@tyrosine>
	 <9e4733910502041809738017a7@mail.gmail.com>
	 <1107569842.8575.44.camel@tyrosine>
	 <9e47339105020418306a4c2c93@mail.gmail.com>
	 <1107591336.8575.51.camel@tyrosine>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2005 08:15:35 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Fri, 2005-02-04 at 21:30 -0500, Jon Smirl wrote:
> 
> > I suspect the problem in that case is a compressed VBIOS. Some laptops
> > compress the VBIOS and the system BIOS into a single ROM and then
> > expand them at power on. Sounds like this is not happening on resume.
> > To get around the problem copy the image from C000:0 before suspend to
> > a place in preserved RAM where wakeup.S can find it and then copy it
> > back to C000:0 on resume. To test for this checksum C000:0 before
> > suspend and after and see if it has changed.
> 
> No, that's not what's happening. If you disassemble the code at
> c000:blah in a laptop, you'll often find that it jumps off to a
> completely different section of address space. During POST, that
> contains video BIOS. After POST, it may be something like USB boot
> support. Without reading it directly out of flash, it's not possible to
> recover that code.

If the copy left at C000:0 is jumping off to F000:xx (system BIOS)
that is a valid thing to do and the reset program may need more
emulation hooks. If it is jumping off somewhere else then I would
consider that a broken VBIOS since jumping to C000:3 for reset is part
of how VGA is supposed to work. If this is happening on an ATI or
Nvidia chip you're probably never going to get video resume working.

-- 
Jon Smirl
jonsmirl@gmail.com
