Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWEDF3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWEDF3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 01:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWEDF3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 01:29:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51856 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751398AbWEDF33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 01:29:29 -0400
Date: Wed, 3 May 2006 22:27:51 -0700
From: Greg KH <greg@kroah.com>
To: Nathan Becker <nathanbecker@gmail.com>, ak@suse.de,
       David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Message-ID: <20060504052751.GA23054@kroah.com>
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com> <2151339d0605032152g64ec77bfhe90dc08180463c31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2151339d0605032152g64ec77bfhe90dc08180463c31@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 09:52:11PM -0700, Nathan Becker wrote:
> Hi,
> 
> I recently added two more memory modules to my Gigabyte K8NXP-SLI
> motherboard, bringing the total up to 4GB.  I had 2GB previously and
> things were running well with kernel 2.6.16.9 x86_64. The CPU is an
> AMD 4800+ X2.
> 
> After the upgrade, USB 2.0 stopped working. After connecting a pen
> drive the following dmesg comes up
> 
> ehci_hcd 0000:00:02.1: GetStatus port 3 status 001803 POWER sig=j CSC 
> CONNECT
> hub 1-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
> hub 1-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
> ehci_hcd 0000:00:02.1: port 3 high speed
> ehci_hcd 0000:00:02.1: GetStatus port 3 status 001005 POWER sig=se0 PE 
> CONNECT
> usb 1-3: new high speed USB device using ehci_hcd and address 4
> usb 1-3: khubd timed out on ep0in len=0/64
> usb 1-3: khubd timed out on ep0in len=0/64
> usb 1-3: khubd timed out on ep0in len=0/64
> 
> and then it repeats attempting different addresses.  If I rmmod
> ehci_hcd, then I can get the device to work, of course it's just
> running at USB  1.1.
> 
> There appear to be varying reports of this problem in bugzilla and on
> message boards:
> bugzilla #5835
> bugzilla #6201
> 
> I am not sure which of these, if any, are the same as the problem I'm
> having.  Any advice on where to go with this problem would be much
> appreciated.  I suspect that a significant clue to this is that it
> only occurs with large amounts of RAM. It also only seems to occur in
> 64-bit mode.  I booted a 32-bit kernel from the Slax live CD  5.1.0
> and USB 2.0 worked fine with all my RAM intact (well only 3.4 GB, but
> that's a different story). I'm happy to post more details and or try
> patches out.  I just retested with kernel  2.6.16.13 and the problem
> persists.
> 
> I've already tried various combinations of  settings in the BIOS, but
> they have no effect.  There is an option to remap for 4GB.  If that is
> turned off then the kernel only sees  3.4 GB of RAM instead of 4GB,
> but it seems to have no effect on this problem.  I also tried changing
> the USB memory option between shadow and lowmem.  That also had no
> effect on this problem.  I do use the NVIDIA binary graphics driver,
> but I retested for this problem without it loaded and the problem
> persists.

Can you try 2.6.17-rc3?

Also, when booting, are there any messages about EHCI BIOS handoffs?
I've seen some reports of this in the past, but it seems to be fixed
with updated bioses.

Andi, you remember what fixed this the last time?

David, any thoughts?

thanks,

greg k-h
