Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283613AbRK3MO7>; Fri, 30 Nov 2001 07:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283634AbRK3MOu>; Fri, 30 Nov 2001 07:14:50 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:27827 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S283613AbRK3MOb>; Fri, 30 Nov 2001 07:14:31 -0500
Date: Fri, 30 Nov 2001 13:11:15 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Russell King <rmk@arm.linux.org.uk>
cc: randall@uph.com, Balbir Singh <balbir_soni@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
In-Reply-To: <20011130105633.A18992@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.3.96.1011130130031.15249E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Russell King wrote:

> Have you audited all the tty drivers in 2.4 to make sure that they clean
> up safely?

 No, of course not -- if I had got a response like "this looks mostly OK,
but please check other drivers", then I would have certainly done.  I
think drivers/tc/zs.c is OK, too, but this was more than a year ago, so I
can't recall now, sorry. 

> I don't believe the serial code will clean up safely as it stands for
> starters if block_til_ready in serial.c fails, leaving an interrupt
> in use.  Further attempts to open the serial device will probably fail.
> 
> Try this as any user with your patch applied:
> 
> $ stty -clocal -F /dev/ttyS0
> $ cat /proc/interrupts
> $ cat /dev/ttyS0
> ^c
> $ cat /proc/interrupts
> 
> I think you'll find your serial port interrupt is still claimed, despite
> the module being marked as not in use.

 Indeed -- maybe something was changed past 2.4.5, after all.  I'll check
how things look like these days.  I nowhere use serial.c as a module
anymore, as all systems I maintain are now configured for the serial
console, so I might have missed something. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

