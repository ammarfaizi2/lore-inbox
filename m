Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLEPpi>; Tue, 5 Dec 2000 10:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLEPp2>; Tue, 5 Dec 2000 10:45:28 -0500
Received: from [193.120.224.170] ([193.120.224.170]:46730 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129228AbQLEPpN>;
	Tue, 5 Dec 2000 10:45:13 -0500
Date: Tue, 5 Dec 2000 15:14:44 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Steve Hill <steve@navaho.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Serial Console
In-Reply-To: <Pine.LNX.4.21.0012051456070.2836-100000@sorbus.navaho>
Message-ID: <Pine.LNX.4.30.0012051506030.31704-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Steve Hill wrote:

> On Tue, 5 Dec 2000, PaulJakma wrote:
>
> > how? symlink to /dev/ttyS0, or with console=ttyS0 boot option?
>
> console=ttyS0
>
> Nope, /dev/console *does* block.

very weird.. the reason i replied to you, even though i have no direct
experience of serial console, was that last night i read a mail on the
linux-mips on almost exactly the same subject (serial console being
quite common on linux-mips), and IIRC Ralf Baechle explained how there
was a fundamental difference between tty and console precisely because
/dev/console might not be going anywhere.

Quoting from Ralf's email:

"/dev/console (as chardev 5/1) differs from another device in some important
ways:

- When opened by a process without controlling tty it will not become
  a CTTY even if the NOCTTY flag is not set.

- It will never block but rather loose data.  This may sound like a
  disadvantage but it's actually very important for proper operation.
  For example, if /dev/console'd block due to a serial console with
  hardware handshaking enabled (DON'T) syslogd writing to it may also
  block for an unbounded time and thus as soon as /dev/log is full all
  services trying to log via syslog(3) will also freeze.

 Syslogd actually tries to be clever about avoiding this from
 happening but fails to handle one case correctly, so this is a real
 world scenario.

- It uses different routines to access the console device than normal
  write access to i.e. ttyS0."

perhaps linux-mips is just different? or i386 serial-console is
incorrect?

> ATM I've found a quick workaround - I
> use "stty -F /dev/console clocal -crtscts" to turn off the serial flow
> control at the stawrt of /etc/rc.d/rc.sysinit - this seems to work quite
> well... of course it doesn't stop some program turning flow control back
> on and ballsing it all up again :)

yukkk...

/dev/console having non-blocking semantics sounds much cleaner.

regards,

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
