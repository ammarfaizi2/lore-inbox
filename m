Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbRFRUqe>; Mon, 18 Jun 2001 16:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbRFRUqY>; Mon, 18 Jun 2001 16:46:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15864 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S263031AbRFRUqE>; Mon, 18 Jun 2001 16:46:04 -0400
Message-ID: <3B2E686E.C1BCAA69@mvista.com>
Date: Mon, 18 Jun 2001 13:45:34 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@sch.bme.hu>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: very strange (semi-)lockups in 2.4.5
In-Reply-To: <Pine.GSO.4.30.0106182118260.20838-100000@balu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:
> 
> First I thought this was an X-issue, but now I'm 100% sure that it isn't,
> as I met the desscribed hangup while working on the console too.
> 
> The NMI card would be interesting, if anyone tells me how to make one, and
> how to patch the kernel to show useable information i'm looking forward to
> do it, and send reports.
> 
Given that your system still handles interrupts:
a.) It would probably not trigger an NMI timer (the interrupts would
keep resetting it)
b.) Using KGDB will, most likely, be all you need anyway.

KGDB (find it a sourceforge) requires a second computer which is hooked
to the "subject" over a rs232 serial line.  The "host" computer needs to
have the vmlinux file as well as the sources for the kernel.  Once the
"subject" becomes ill, a control-C (from the "host") on the serial line
will interrupt it and start a dialog with gdb running on the "host"
computer.  If you have the second computer, this is the easiest way to
get to where you need to be.

If you have a complete freeze, then the NMI is useful, but even here, it
is best to let KGDB handle the NMI.  Much easier to see what's what than
looking thru an OOPS.

George


> regards
> Balazs Pozsar.
> 
> On Mon, 18 Jun 2001, Albert D. Cahalan wrote:
> 
> > Pozsar Balazs writes:
> >
> > > I'm having ~2 lockups a day. The following happens:
> > >  If I was under X, i only can use the magic-key, but no other keyboard (eg
> > > numlock) or mouse response, the screen freezes, processes stop.
> > >  If i was using textmode:
> > >   numlock still works
> > >   cursor blinks
> > >   processess stop (eg, gpm doesn't work, outputs freeze)
> > >   i can still switch vt's.
> > >   BUT, i can only type into a few vt's, last time into 3,5,6,7,8, but not
> > > into 1,2 or 4!
> > >
> > > I cannot give you any traces, as i dont have any.
> > >
> > > Also note that magic-key works, and it says that it umounts filesystems if
> > > i press magic-u, but next time at mount i see that reiserfs is replaying
> > > transactions.
> > >
> > >
> > > Any ideas?
> > >
> > > The machine is a P3-750, 512M ram, abit vp6 mb. No overclocking, and it
> > > passes memtest86.
> >
> > I think I'm getting the same thing, but I don't have the magic-key
> > compiled in. I'm going to hook up a VT510 to the serial port, in case
> > this is just XFree86 crashing. For anyone collecting statistics:
> >
> > kernels 2.4.4-pre6 (?) and now 2.4.6-pre3
> > plain Pentium MMX @ 200 MHz
> > Intel motherboard -- see below
> > stable since 1996, on a UPS, dust-free, and the fan works
> > one lockup per day with desktop usage
> >
> > In case the serial console doesn't work, could someone post plans
> > for a safe NMI board? (both ISA and PCI) The best I found:
> > http://www.sandelman.ottawa.on.ca/linux-ipsec/html/2000/02/msg00425.html
> > http://www.sandelman.ottawa.on.ca/linux-ipsec/html/2000/02/msg00391.html
> > (for PCI you're supposed to assert SERR# on the clock -- how?)
> >
> > 00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
> > 00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
> > 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> > 00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> > 00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
> > 00:11.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (rev 23)
> > 00:13.0 Ethernet controller: Lite-On Communications Inc LNE100TX Fast Ethernet Adapter (rev 25)
> > 00:14.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev 5c)
> >
> 
> --
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
