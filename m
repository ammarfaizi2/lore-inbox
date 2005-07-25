Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVGYPu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVGYPu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVGYPu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:50:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11792 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261165AbVGYPu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:50:27 -0400
Date: Mon, 25 Jul 2005 16:50:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: dtor_core@ameritech.net
Cc: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050725165014.B7629@flint.arm.linux.org.uk>
Mail-Followup-To: dtor_core@ameritech.net, Pavel Machek <pavel@suse.cz>,
	rpurdie@rpsys.net, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz> <d120d500050725081664cd73fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <d120d500050725081664cd73fe@mail.gmail.com>; from dmitry.torokhov@gmail.com on Mon, Jul 25, 2005 at 10:16:05AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 10:16:05AM -0500, Dmitry Torokhov wrote:
> If the problem is that you have a single piece of hardware you need to
> bind several drivers to - I guess you will have to create a new
> sub-device bus for that. Or just register sub-devices on the same bus
> the parent device is registered on - I am not sure what is best in
> this particular case - I am not familiar with the arch.

That is exactly the problem - these kinds of devices do _not_ fit
well into the device model.  A struct device for every different
possible sub-unit is completely overkill.

For instance, you may logically use one ADC and some GPIO lines
on the device for X and something else for Y and they logically
end up in different drivers.

The problem is that the parent doesn't actually know how many
devices to create nor what to call them, and they're logically
indistinguishable from each other so there's no logical naming
system.

> Can we change this to "while (!kthread_should_stop())" to make me
> completely happy?

I still ask, and I'll keep repeating this.  What is the difference
between this and the reference implementation which is known to
work on other hardware.

Let's not go all out on one implementation for one set of hardware,
but try to work out what we need to do to the generic reference
implementation to make it work on this hardware.

IOW, you're working on the wrong version.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
