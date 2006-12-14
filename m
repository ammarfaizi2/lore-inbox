Return-Path: <linux-kernel-owner+w=401wt.eu-S932694AbWLNM1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWLNM1t (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWLNM1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:27:48 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:1370 "EHLO
	anchor-post-32.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932694AbWLNM1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:27:48 -0500
X-Greylist: delayed 10392 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 07:27:47 EST
Message-ID: <45814340.301@superbug.co.uk>
Date: Thu, 14 Dec 2006 12:27:44 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Duncan Sands <duncan.sands@math.u-psud.fr>
CC: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
References: <20061213195226.GA6736@kroah.com> <20061213203113.GA9026@suse.de> <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org> <200612140949.43270.duncan.sands@math.u-psud.fr>
In-Reply-To: <200612140949.43270.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
>> I'm really not convinced about the user-mode thing unless somebody can 
>> show me a good reason for it. Not just some "wouldn't it be nice" kind of 
>> thing. A real, honest-to-goodness reason that we actually _want_ to see 
>> used.
> 
> Qemu?  It would be nice if emulators could directly drive hardware:
> useful for reverse engineering windows drivers for example.
> 
> Duncan.

I have reverse engineered many windows drivers, and what you suggest is 
not at all helpful. For reverse engineering, one wants to see what is 
happening. I.e. capture all the IO, MMIO and DMA accesses.
Your suggestion bypasses this possibility.
For reverse engineering windows drivers, one puts breakpoints in the 
HAL.DLL code or replaces the HAL.DLL code with a debugging version of it 
  while actually running windows.

Your approach runs into problems.
e.g
There is a register on the card that sets the DMA base address, but you 
don't know which register this is. If you let the driver inside QEMU 
write to this register, it will write values suitable for the Virtual 
machine instead of values suitable to for host OS. The DMA transaction 
will write all over the wrong memory location resulting in CRASH.

One might be able to get round some of these problem with a combination 
of QEMU and a hacked up HAL.DLL, but it will be complicated.

James

