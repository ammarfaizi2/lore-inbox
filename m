Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280387AbRKSRhy>; Mon, 19 Nov 2001 12:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280426AbRKSRho>; Mon, 19 Nov 2001 12:37:44 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:10766 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S280387AbRKSRhf>; Mon, 19 Nov 2001 12:37:35 -0500
Date: Mon, 19 Nov 2001 13:39:41 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Russell King <rmk@arm.linux.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pci_write_config_byte question..
In-Reply-To: <20011119172300.B16263@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0111191331410.237-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Russell King wrote:

> On Mon, Nov 19, 2001 at 12:48:24PM -0500, John Clemens wrote:
> > I've been hacking some PCI code to get USB working on my laptop.  I need
> > to change PCI config space to use IRQ 11 for the device instead of IRQ 9.
>
> Changing interrupts is non-trivial, especially on x86.

nod.  But it can be done in this case.. its just i have to call 'setpci'
from user space to change the interrupt line manually before i modeprobe
usb-ohci.  I thought pci_write_config_byte should take care of that.

for a complete rundown of what i'm doing, please see my earlier post which
garnered no responses whatsoever:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.2/0005.html

> The kernel caches a copy of the IRQ number register.  The IRQ number
> register (PCI_INTERRUPT_LINE) is just like RAM - you can read it, you
> can write it.  However, it has no hardware side effects however. It's
> sole purpose in life is to communicate the IRQ number from the POST
> (which knows how the interrupts are arranged) to the driver.

so is there a kernel call I can use to actually twiddle the bits?

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


