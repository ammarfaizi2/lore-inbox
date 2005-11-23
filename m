Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVKWPD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVKWPD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKWPD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:03:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30216 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750839AbVKWPD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:03:56 -0500
Date: Wed, 23 Nov 2005 15:03:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123150349.GA15449@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:43:58AM -0500, Jon Smirl wrote:
> My system has:
> 2 serial
> 
> In /sys/bus/platform/devices I see this:
> serial8250
> shouldn't there be entries for all of the legacy devices?
> 
> In /dev
> ttyS0
> ttyS1
> ttyS2
> ttyS3

You're basically confused about serial ports.  The kernel serial devices
whether or not hardware is found, to allow programs such as setserial to
function.

If you disagree with that, there'll be an equal number of people who
have serial cards that need setserial who will in turn disagree with
you.

> Plus I have 64 tty devices. Couldn't the tty devices be created
> dynamically as they are consumed? Same for the loop and ram devices?

You do realise that the dynamic device creation for those 64 console
devices is done via the console device being _opened_ by userspace?

Hence, if the device doesn't exist in userspace, it can't be created
for userspace to open it to create the device via udev.  Have you
noticed a catch-22 with that statement?

Note that with tty devices, the tty layer has to be told the number
of devices you want to support when you first register your driver.
You're fixed to that maximum number from that point on, until you
unregister *all* your ports and driver.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
