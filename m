Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269494AbRHGWVp>; Tue, 7 Aug 2001 18:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269503AbRHGWVe>; Tue, 7 Aug 2001 18:21:34 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:55776 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269494AbRHGWVR>;
	Tue, 7 Aug 2001 18:21:17 -0400
Message-ID: <3B7069ED.E4F77B68@candelatech.com>
Date: Tue, 07 Aug 2001 15:21:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
Subject: Re: [eepro100] Problem with Linux 2.4.7 and builtin eepro on Intel'sEEA2 
 motherboard.
In-Reply-To: <Pine.LNX.4.10.10108071740170.976-100000@vaio.greennet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> 
> On Tue, 7 Aug 2001, Ben Greear wrote:
> 
> > Subject: [eepro100] Problem with Linux 2.4.7 and builtin eepro on Intel's
>     EEA2 motherboard.
> >
> > The driver seems to lock up for a while and then recover...
> 
> Presumably this is the driver in the 2.4.7 kernel, not the Scyld driver.

Yes, I'm under the impression that the Scyld driver for 2.4.7 is not prime-time
yet.  I wouldn't mind being wrong!

Intel's driver only supports up to 2.4.4 according to their page.  So, that leaves
me with the kernel eepro100 driver (which due to the convienience of not having
to patch any files, is what I would prefer to work!)...

> 
> > Aug  7 11:56:07 lanf1 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Aug  7 11:56:07 lanf1 kernel: eth0: Transmit timed out: status 0050  0cf0 at 900/928 command 000c0000.
> > Aug  7 11:58:53 lanf1 kernel: eepro100: wait_for_cmd_done timeout!
> 
> Hmmm, the chip didn't reset.
> 
> > [root@lanf1 bin]# eepro100-diag eth0 -aa -ee -mm -f
> > eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
> >  http://www.scyld.com/diag/index.html
> > Index #1: Found a Intel i82562 EEPro100 adapter at 0xdf00.
> > i82557 chip registers at 0xdf00:
> >   0c000090 0f1123e0 00000000 00080002 18250021 00000600
> >   No interrupt sources are pending.
> >    The transmit unit state is 'Active'.
> 
> ..and the transmit unit is still trying to do something (transmit?).
> 
> >    The receive unit state is 'Ready'.
> >   This status is unusual for an activated interface.
> >  The Command register has an unprocessed command 0c00(?!).
> 
> This is a little misleading.  The driver you are using is trying to mask
> the early receive interrupt, but the proper approach is to configure the
> chip to not generate the event, rather than mask the interrupt.
> 
> ...
> >  MII PHY #1 transceiver registers:
> >   3100 782d 02a8 0330 05e1 0021 0000 0000
> >   0000 0000 0000 0000 0000 0000 0000 0000
> >   2404 0000 0000 0000 0000 0000 0000 0000
> >   0000 0000 0000 0000 0010 0000 0000 0000.
> >   Baseline value of MII status register is 782d.
> >
> > NOTE:  The eepro100-diag program hangs here, and will not
> > continue after at least 2 minutes.  Ctrl-c does stop it
> > though...
> 
> It hasn't hung.  It's doing what it's documented to do -- polling the
> MII register for state transititions.  Pull the network cable and you'll
> see timestamped events as the link is lost and autonegotiation occurs.

Oh, I don't remember seeing this result before...  It does indeed do
that on the working Intel NIC too, though, so I guess you're right..

> 
> > Interestingly enough, a minute after I did this, the whole
> > machine locked up hard :(
> 
> That shouldn't happen -- polling the MII register should be safe.  This
> might be due to the underlying problem that cause the eepro100 driver to
> stop working.

I've seen other related posts about locking up their machine, so I assume that
I hit that same bug..maybe I aggravated it by using the eepro100-diag program,
or maybe it was a coincidence...


By the way, the NICs were attached to a 10bt netgear 4-port hub.

THanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
