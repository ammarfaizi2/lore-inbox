Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTL1LGy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 06:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTL1LGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 06:06:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51720 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265079AbTL1LGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 06:06:50 -0500
Date: Sun, 28 Dec 2003 11:06:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 modules, hotplug, PCMCIA
Message-ID: <20031228110646.A8072@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <173b01c3cceb$05ade850$43ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <173b01c3cceb$05ade850$43ee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Sun, Dec 28, 2003 at 11:33:04AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 11:33:04AM +0900, Norman Diamond wrote:
> 4.  SuSE 8.2 defaults to using the kernel PCMCIA package rather than the
> external PCMCIA package.  This is fine with me so kernel 2.6.0 also uses its
> own compiled PCMCIA drivers instead of trying to make an external PCMCIA
> package work with two kernels.  It seems to me that it should be OK to
> compile PCMCIA as modules instead of built-in, but there were boot-time
> errors, so I had to change PCMCIA and Yenta to built-in.

What were these errors?

> (This is the
> opposite of the change that I had to make to mice, described in a separate
> e-mail message.)  Now with PCMCIA compiled built-in, the low-level drivers
> get loaded, but cardmgr still doesn't run automatically.  I can do "su" and
> "cardmgr &" and then PCMCIA starts working enough to do modprobes when cards
> are inserted.

It sounds like the SuSE init scripts are being clever and probably only
know about how their 2.4 situation works.  What we need is a SuSE person
to comment on this behaviour; I don't have access to any SuSE based
systems to investigate their quirks.

> 5.  However, file /etc/pcmcia/serial.opts is still getting ignored under
> 2.6.0.

"still" ?  This is news to me (as the guy who seems to be handling both
PCMCIA and serial.)

> The modem is detected as containing a TI 16750 UART, and whatever
> the serial driver does then, it causes the modem to hang up.  The serial
> driver in 2.4.20 defaults to the same thing but 2.4.20 reads file
> /etc/pcmcia/serial.opts, obeys the line SERIAL_OPTS="uart 16550A", and lets
> the modem operate at 33% of its rated speed instead of hanging up.

"hang up"?  Do you mean "on-hook" or do you mean "stop working"?  Is
there anything in /var/log/messages about this?

On my RH systems, cardmgr logs a fair amount to the system messages log,
which includes details of any commands run and any failures.  It would
be really useful to see this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
