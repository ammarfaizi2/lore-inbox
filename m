Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130193AbRABJpl>; Tue, 2 Jan 2001 04:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRABJpb>; Tue, 2 Jan 2001 04:45:31 -0500
Received: from smtp5.mail.yahoo.com ([128.11.69.102]:8205 "HELO
	smtp5.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130193AbRABJpO>; Tue, 2 Jan 2001 04:45:14 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A519B63.56BE023@yahoo.com>
Date: Tue, 02 Jan 2001 04:12:04 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Les Schaffer <schaffer@optonline.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ne2000 (ISA) & test11+
In-Reply-To: <14929.13173.272621.321333@optonline.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Les Schaffer wrote:

> > Second: I'm having problems loading my ne2000 (ISA) card as a module
> 
> ditto for myself since i started using new SMP machine sometime around
> 2.4.0-test8 or so.
> 
> the modprobe works the second time (and subsequently) when i run it by
> hand after boot scripts finish.
>
> boot log:
> 
> Jan  1 08:03:18 localhost kernel: isapnp: Scanning for Pnp cards...
> Jan  1 08:03:18 localhost kernel: isapnp: Card 'NDC Plug & Play Ethernet Card'
> Jan  1 08:03:18 localhost kernel: isapnp: 1 Plug & Play card detected total
> Jan  1 08:03:18 localhost kernel: ne.c: No NE*000 card found at i/o = 0x220

> then modprobe by hand:
> 
> Jan  1 08:03:59 localhost kernel: ne.c: ISAPnP reports Generic PNP at i/o 0x220, irq 5.
> Jan  1 08:03:59 localhost kernel: ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
> Jan  1 08:03:59 localhost kernel: Last modified Nov 1, 2000 by Paul Gortmaker
> Jan  1 08:03:59 localhost kernel: NE*000 ethercard probe at 0x220: 00 80 c6 f5 19 08
> Jan  1 08:03:59 localhost kernel: eth1: NE2000 found at 0x220, using IRQ 5.

Note in the failed case you have no line that says "ne.c: ISAPnP reports..."
which is the clue here.  If you supply an i/o address, such as....

> from etc/modules.conf:
> 
> alias eth1 ne
> options ne irq=5 io=0x220

then no PnP is involved in the probing at all.  If you are relying on the
PnP part of the probe to activate your card, but it isn't being used....
OTOH, if you *don't* supply an I/O address, then the PnP part of the probe
will be used; you will see the "ne.c: ISAPnP reports..." message, and all
should be well.  So try deleting your options line (for 2.4.x kernels).

There is also a possibility of an i/o conflict - as the other person
had at 0x360 now that check_region is gone - in your case maybe with 
the i/o regions isapnp itself reserves, since your ne2k is way down
low at 0x220. In fact isapnp assumes that NE2000 cards will start
between 0x280 and 0x360 - and avoids this region because of that.

Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
