Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280307AbRKSRYE>; Mon, 19 Nov 2001 12:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280320AbRKSRXz>; Mon, 19 Nov 2001 12:23:55 -0500
Received: from [212.18.232.186] ([212.18.232.186]:52997 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S280328AbRKSRXj>; Mon, 19 Nov 2001 12:23:39 -0500
Date: Mon, 19 Nov 2001 17:23:00 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_write_config_byte question..
Message-ID: <20011119172300.B16263@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0111191243570.237-100000@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111191243570.237-100000@pianoman.cluster.toy>; from john@deater.net on Mon, Nov 19, 2001 at 12:48:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 12:48:24PM -0500, John Clemens wrote:
> I've been hacking some PCI code to get USB working on my laptop.  I need
> to change PCI config space to use IRQ 11 for the device instead of IRQ 9.

Changing interrupts is non-trivial, especially on x86.

> So i call pci_write_config_byte(...), but that only appears to change the
> "system" view of PCI space.. if you boot the kernel and do an lspci, it
> shows up as IRQ11, but if you do a lspci -b (for "Bus" view), it still
> shows up as IRQ 9.

The kernel caches a copy of the IRQ number register.  The IRQ number
register (PCI_INTERRUPT_LINE) is just like RAM - you can read it, you
can write it.  However, it has no hardware side effects however. It's
sole purpose in life is to communicate the IRQ number from the POST
(which knows how the interrupts are arranged) to the driver.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

