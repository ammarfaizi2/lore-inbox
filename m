Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265160AbVBECbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbVBECbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 21:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbVBECa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 21:30:59 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:24969 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265160AbVBECal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:30:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aYZrKB+Mic+p2hUIQMABD+r7b3e5lRu/xI1gujBCiMu4WeIRPMiK6WX40D4/RXuVti6oyY4ZOPJYM8GsUI0fJ0PupusnyyQhWsI/953q5NhLeLoQeHIJ8dSalwGYR0irjv+v1RUqm2+7GnfZ95uvnrk56lPX2ccxb7BQFJnXmKI=
Message-ID: <9e47339105020418306a4c2c93@mail.gmail.com>
Date: Fri, 4 Feb 2005 21:30:36 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1107569842.8575.44.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com>
	 <420367CF.7060206@gmx.net> <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <1107569089.8575.35.camel@tyrosine>
	 <9e4733910502041809738017a7@mail.gmail.com>
	 <1107569842.8575.44.camel@tyrosine>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2005 02:17:22 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On laptops, it's frequently the case that c000:0003 will jump to a
> section of code that is no longer mapped into the address space.
> Instead, it's entirely possible that some other section of BIOS will be
> mapped there. The resulting behaviour is undefined, and can cause the
> hardware to hang.

I suspect the problem in that case is a compressed VBIOS. Some laptops
compress the VBIOS and the system BIOS into a single ROM and then
expand them at power on. Sounds like this is not happening on resume.
To get around the problem copy the image from C000:0 before suspend to
a place in preserved RAM where wakeup.S can find it and then copy it
back to C000:0 on resume. To test for this checksum C000:0 before
suspend and after and see if it has changed.

You can always do a simple test. If a program like vbios.vm86 or
vbetool can reset the card, then there is no reason wakeup.S shouldn't
be able to do it too if the environment is set up correctly.

-- 
Jon Smirl
jonsmirl@gmail.com
