Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbRETScU>; Sun, 20 May 2001 14:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbRETScK>; Sun, 20 May 2001 14:32:10 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:51440 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S261801AbRETScA>; Sun, 20 May 2001 14:32:00 -0400
Message-Id: <l03130301b72db986b2dc@[192.168.239.105]>
In-Reply-To: <20010520131457.A3769@thyrsus.com>
In-Reply-To: <16267.990374170@redhat.com>; from dwmw2@infradead.org on Sun,
 May 20, 2001 at 04:56:10PM +0100 <20010518105353.A13684@thyrsus.com>
 <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com>
 <20010518113726.A29617@devserv.devel.redhat.com>
 <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com>
 <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com>
 <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 20 May 2001 19:31:12 +0100
To: esr@thyrsus.com, David Woodhouse <dwmw2@infradead.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Background to the argument about CML2 design philosophy
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>1. The Mac derivations were half-right.  The MAC_SCC one is good but Macs
>can have either of two different SCSI controllers.  I fixed that with help
>from Ray Knight, who maintains the 68K Mac port.

If I understand the "philosophy" correctly, it is still possible to specify
additional cards for those Macs which have PCI slots.  If so, absolutely
fine - I can shove my Adaptec 19160 into my G4 and have it work just as
well as it currently does in my Athlon.

One caveat though - not all Macs have SCSI controllers, and not all that do
even have one of the two standard ones.  The "Blue and White G3", the iMac,
the PowerBook G3 "Firewire" and later models on these lines all lack a
built-in SCSI controller, but many could have one added via PCI or CardBus
slots.  The PowerBooks 5300 and 190 (and possibly others) use some
non-standard P.O.S. hanging off the NuBus, which even mkLinux doesn't know
how to drive.  However, in these situations, disabling the extra drivers is
usually not critical unless you're running low on space somewhere.  At that
point, you enable the "Are you insane?" module outlined below...

>3. The MVME derivations are correct *if* (and only if) you agree to ignore
>the possibility that somebody could want to ignore the onboard hardware,
>plug outboard disk or Ethernet cards into the VME-bus connector, and
>do something like running SCSI-over-ATAPI to the outboard device.
>(I missed these possibilities when I wrote the derivations.)

...and then someone else mentioned the possibility of f*x0r3d hardware.  In
this case, I would say this *isn't* a kernel-configuration issue but one of
being able to disable the drivers for the malfunctioning hardware.  If I
have a PCMCIA controller that reboots the machine as soon as the driver
tries to switch it on, I should be able to send a command-line parameter to
the kernel which tells it to switch it off *at run-time*.  And iff I'm
running with hardware which is so f*x0r3d that that isn't enough, I'd
either fix the hardware or hack the config files.  I don't see the problem.

I think the MVME derivations are *perfectly* sensible - if the reference
board and most (read: virtually all) derivatives have those features, turn
them on by all means.  To satisfy some others, you might want to say "Hey,
these guys might want to *explicitly turn off* some of this stuff" - so
provide an option under "Are you insane?" which presents all the "derived"
symbols and allows the hackers to manually turn stuff off.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


