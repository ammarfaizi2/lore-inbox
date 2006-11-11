Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947215AbWKKNPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947215AbWKKNPj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 08:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947218AbWKKNPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 08:15:39 -0500
Received: from rosi.naasa.net ([212.8.0.13]:8900 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S1947215AbWKKNPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 08:15:38 -0500
From: Joerg Platte <jplatte@naasa.net>
Reply-To: jplatte@naasa.net
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Userspace process may be able to DoS kernel
Date: Sat, 11 Nov 2006 14:15:31 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com> <200611111329.17206.lists@naasa.net> <1163248773.3293.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1163248773.3293.20.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611111415.32459.jplatte@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 11. November 2006 13:39 schrieb Arjan van de Ven:

> this isn't per se acpi related: This is reading the PM timer from your
> chipset. The PMTimer is a clock on your chipset that the kernel can use
> to read a stable incrementing clock to find out what time it is right
> now, usually as part of userspace asking the kernel what time it is via
> the gettimeofday() system call. ACPI is just the component that does the
> actual (slow) hardware access... eg the messenger.

OK.

> Normally systems have better/faster clocks than the pmtimer, but there
> are circumstances where those can't be used.
>
> 1) HPET. The HPET is a lot faster than pmtimer, and very reliable. Most
> of the systems sold in the last 3 years have an hpet, but unfortunately,
> many bioses turn this off by default. If your BOOS has a "Multimedia
> timer" setting, make sure it's set to "On".

My computer is 3,5 years old (one of the first centrino notebooks). Maybe it 
does not have a HPET timer. I can't find HPET somewhere in the kernel.log 
file and no option in the BIOS. But it is enabled in my kernel config.

> 2) TSC. This is a super fast method of finding how much time has passed,
> since it's inside the CPU. However there are many reasons why this
> method may be unreliable, for example certain powermanagement features
> on laptops cause this clock to stop when idle (not useful), or to vary
> in frequency (also not useful if you want to find out what time it is).
> Also on AMD Opteron SMP systems or extreme Intel big honking NUMA
> systems, this timer is not synchronized between the various processors
> and that breaks the current time keeping in Linux, and so Linux doesn't
> use it in that case.

I'm using frequency scaling. Maybe that's a reason for not using TSC in each 
case.

> So my advice is
> 1) Check the bios to see if you have the HPET enabled. If not, enable
> it.
> 2) Check the kernel config to see if you have HPET enabled there, if not
> enable it.
> 3) Check dmesg to see if there's a reason the kernel doesn't use TSC;
> there is probably nothing you can do but at least you know why :)

The kernel semm to use TSC. I can't find another message stating that TSC has 
been disabled.

localhost kernel: Time: tsc clocksource has been installed.

There seem to be some clock drift. Each time when starting skype everything 
works perfect for a couple of hours. Then, skype behaves strange by causing 
this high system load. 

regards,
Jörg
