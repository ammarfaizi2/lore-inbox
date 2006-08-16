Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWHPObt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWHPObt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWHPObt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:31:49 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:54423 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751176AbWHPObs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:31:48 -0400
Date: Wed, 16 Aug 2006 10:31:47 -0400
To: Raphael Hertzog <hertzog@debian.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060816143147.GC13641@csclub.uwaterloo.ca>
References: <20060816104559.GF4325@ouaza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816104559.GF4325@ouaza.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 12:45:59PM +0200, Raphael Hertzog wrote:
> While using Linux on low-end (semi-embedded) hardware (386 SX 40Mhz, 8Mb
> RAM), I discovered that Linux on that machine would suffer from serial
> port buffer overruns quite easily if I use a baudrate high enough (I start
> loosing bytes at >19200 bauds and I would like to make it reliable up to 
> 115 kbauds). I check if overruns are happening with
> /proc/tty/driver/serial ("oe" field).
> 
> Back when I was using the 2.4 kernel, I reduced dramatically the frequency
> of overruns by using the "low latency" and "preemptible kernel" patch [1]. But
> it still happened sometimes at 115 kbauds if the system was a bit loaded
> (with disk I/O for example).

In my experience, the way to avoid overruns on a serial port was to use
a buffered serial port UART (such as a 16550A for example).  I remember
my 486 wasn't reliable about 19200 or 38400 (depending on how busy the
cpu was) when using an 8250.  Using a 16550A based card and I could do
115200 without any issues since the UART had a 16 byte buffer to help
out the system.  Unless your 386 has an add in card for the serial port,
it almost certainly has a very crappy UART and it would be very hard to
make it work reliably at higher speeds.

--
Len Sorensen
