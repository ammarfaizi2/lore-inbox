Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265555AbUAWLXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 06:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbUAWLXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 06:23:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3088 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265555AbUAWLXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 06:23:33 -0500
Date: Fri, 23 Jan 2004 11:23:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tomas Kouba <tomas@jikos.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Siemens MC45 PCMCIA gprs modem
Message-ID: <20040123112329.A12867@flint.arm.linux.org.uk>
Mail-Followup-To: Tomas Kouba <tomas@jikos.cz>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401230922110.20053@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401230922110.20053@twin.jikos.cz>; from tomas@jikos.cz on Fri, Jan 23, 2004 at 09:32:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 09:32:41AM +0100, Tomas Kouba wrote:
> /var/log/messages when I insert the card:
> Jan 23 09:20:25 dhcp23 kernel: PCMCIA: socket c62dc82c: unable to apply 
> power.

This is first thing to wonder about - this indicates that the PCMCIA
bridge did not report that it had turned on the power to the socket
after the time allowed.

Could you give some info on the PCMCIA hardware in this machine please?

> Jan 23 09:20:26 dhcp23 cardmgr[782]: + insmod /lib/modules/2.6.1/kernel/drivers/serial/serial_cs.ko
> Jan 23 09:20:26 dhcp23 kernel: ttyS0 at I/O 0x3f8 (irq = 3) is a 8250
> Jan 23 09:20:26 dhcp23 kernel: ttyS4 at I/O 0x400 (irq = 3) is a 16C950/954
> Jan 23 09:20:26 dhcp23 cardmgr[782]: executing: './serial start ttyS0'
> Jan 23 09:20:26 dhcp23 kernel: serial8250: too much work for irq3
> Jan 23 09:20:27 dhcp23 last message repeated 5 times
> Jan 23 09:20:27 dhcp23 cardmgr[782]: executing: './serial start ttyS4'

Hmm, it seems that we found two ports on this card, one at 0x3f8 and one
at 0x400.  It also seems that there's something odd going on with IRQ3
here, which could be the cause of your problem.

> When I start minicom for ttyS4 it shows it is online but the modem doesn't 
> reply to any AT command.

Could you monitor /proc/tty/driver/serial and /proc/interrupts while
you're trying to talk to the card ?

> I attach a log from windows where it works fine.

This log seems unreadable - it seems to claim to be a text/plain
ISO8859-1 file, yet it's actually encoded using UTF-16.  I do not
appear to have anything which will convert UTF-16 to standard ASCII.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
