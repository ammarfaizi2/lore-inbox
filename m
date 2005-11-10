Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVKJR71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVKJR71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVKJR71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:59:27 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:190 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1750877AbVKJR71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:59:27 -0500
Date: Thu, 10 Nov 2005 12:59:22 -0500
To: Chip Salzenberg <chip@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hostap interrupt problems, maintainers unresponsive - "wifi0: interrupt delivery does not seem to work"
Message-ID: <20051110175922.GB9632@delft.aura.cs.cmu.edu>
Mail-Followup-To: Chip Salzenberg <chip@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20051102174639.GB6816@tytlal.topaz.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102174639.GB6816@tytlal.topaz.cx>
User-Agent: Mutt/1.5.9i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 09:46:39AM -0800, Chip Salzenberg wrote:
> Hostap 0.4.4-kernel, included with kernel 2.6.14, does not work; nor
> do versions 0.3.9 nor 0.4.1 compiled separately against 2.6.14.  There
> seems to be a problem with interrupt delivery.  Soon after the module
> is installed, keystrokes and all other interrupt-driven activity pause
> periodically for a LONG time (on the order of five seconds).

I am seeing similar interrupt problems, but I don't have hostap (or even
a wireless network card) on my machine. For me a clear indication is the
serial port overrun errors even though that port only gets a handful of
interrupts per second from an attached GPS receiver. Under X, keyboard
and mouse are occasionally very jerky and unreponsive.

I just rebooted with 'acpi=noirq', and I'm not seeing the serial port
overrun errors anymore, it seems to have fixed, or at least mitigated
the problem a bit. But I'm logged into the machine remotely at the
moment, so I can't be sure if it really fixed the unresponsive
keyboard/mouse issues. There are a bunch of differences in the kernel
log, but one that was quite noticable was the estimated CPU speed and
that the IO-APIC seems to be intialized differently.

booting 2.6.14
--------------
Nov 10 09:49:23 thegate kernel: 247 MHz processor.

booting 2.6.14 with acpi=noirq
------------------------------
Nov 10 12:36:08 thegate kernel: Detected 2807.302 MHz processor.


It actually looks like there is a whole bunch of interesting information
from the early boot that got scrolled out of the printk buffer by the
time klog dumps everything to kern.log. I guess I should rebuild my
kernel with a larger ringbuffer.

Jan

