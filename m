Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUCMNFj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 08:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUCMNFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 08:05:39 -0500
Received: from odin.lnet.lut.fi ([157.24.104.174]:19073 "EHLO odin.lnet.lut.fi")
	by vger.kernel.org with ESMTP id S263089AbUCMNFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 08:05:36 -0500
Date: Sat, 13 Mar 2004 15:05:35 +0200
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another case of lockup using combination of devices (sound+net)
Message-ID: <20040313130535.GA1270@odin.lnet.lut.fi>
Reply-To: Mika =?iso-8859-15?Q?Bostr=F6m?= <bostik@lut.fi>
References: <20040224172310.GA6083@odin.lnet.lut.fi> <Pine.LNX.4.58L.0402251052210.21511@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58L.0402251052210.21511@logos.cnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: bostik@lut.fi (Mika  =?ISO-8859-1?Q?=20Bostr=F6m?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 11:01:17AM -0300, Marcelo Tosatti wrote:
> 
> 
> On Tue, 24 Feb 2004, Mika   Boström wrote:
> 
> >   I hope this bug report has all the required bits in it, I haven't done
> > this before. I tried to follow the instructions and included some
> > additional information usually seen here (.config, dmesg). On with the
> > bug report...
> >
> >
> > [1.] Complete hang when using sound and network simultaneously (2.6.x)
> >
> > [2.] I noticed that another person has had similar problems:
> > http://marc.theaimsgroup.com/?t=107699689400003&r=1&w=2
> > While listening to music (xmms, ALSA output) I have had complete
> > lockups. There is no indication of a problem, and nothing ever gets
> > written to logs. When the system locks up, even keyboard goes
> > unresponsive: capslock, numlock, scroll-lock don't flash lights, magic
> > key does not register. Before the posting above I couldn't find any
> > reason, but my latest lockup happened while listening to music pulling
> > data in at a rate of about 6.5 MB/s. The transfer had lasted for perhaps
> > 10 seconds before system hung.
> >
> > This has occurred with all the 2.6 kernels I have tried: 2.6.0-test8,
> > 2.6.1, and now 2.6.3. Looking at the thread above I took notice that I
> > had previously had an enormous amount of interrupt errors (~120k/day).
> > Disabling IO-APIC from kernel configuration apparently solved that, now
> > they occur approximately 1 error/day. No difference there, the lockup
> > still takes place. ACPI has never been enabled. Sound card is C-Media
> > 8738 based Trust, NIC is a 3com 905B. ATI's proprietary kernel module
> > has not been loaded at any of these instances. (It broke all kinds of
> > things on its own.)
> 
> Radeon and the 3com are sharing interrupt 11.

  Original bug report:
  http://marc.theaimsgroup.com/?l=linux-kernel&m=107764506828290&w=2

  It took me a lot of time to test these things out, but I just had
another complete system hang. *Nothing* in logs. Listened to music
(xmms) and tried to load a webpage => kaputt.

  Last time two cards were indeed sharing IRQ 11: Radeon and C-Media.
Changing physical slots solved that one, and now the sound card is at
IRQ 3. (3com never shared IRQ 11, as it has been always in IRQ 10.)

  Relevant parts from now changed lspci -v:
00:0b.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 3
        I/O ports at b800 [size=256]

00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b400 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV280 [Radeon 9200] (rev 01) (prog-if 00 [VGA])
        Subsystem: Unknown device 17ee:2801
        Flags: bus master, 66Mhz, medium devsel, latency 255, IRQ 11
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]

  Nothing else has changed in my system setup.

> That can cause problems. Try changing the interrupt of one of the cards.

  As can be seen, this did not help. Ideas of how to debug this
nastiness from here would be nice, and I'll do what I can to help.
Something is not right but I can't figure out why these hangs should
only happen when sound is used. 


-- 
 Mika Boström      +358-40-525-7347  \-/  "The Hell is empty,
 Bostik@lut.fi    www.lut.fi/~bostik  X    and all the devils
 Security freak, and proud of it.    /-\   are here." -W.S.
