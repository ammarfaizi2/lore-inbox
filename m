Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSKYRZt>; Mon, 25 Nov 2002 12:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSKYRZt>; Mon, 25 Nov 2002 12:25:49 -0500
Received: from mail.wincom.net ([209.216.129.3]:17939 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S262089AbSKYRZr>;
	Mon, 25 Nov 2002 12:25:47 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Nov 2002 12:33:18 -0500
Subject: A Kernel Configuration Tale of Woe
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3de26215.842.0@wincom.net>
X-User-Info: 129.9.27.145
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gentlemen,

I have a tale to tell you. It is, I'm afraid, a little long, but it contains
within it a couple of messages that I really think need to be communicated from
us troops in the trenches up to you Generals of Kernel Hacking. I hope you'll
indulge me for a few minutes.

This past week, it was decided that the family P1-233 based Linux box (a RH5
box that had been upgraded through RH7.2) was no longer suitable for use as
a desktop workstation, and a replacement was in order. To that end, the following
system was specced out, ordered, and assembled:

- Asus A7V8X motherboard (10/100 onboard LAN, ATA 133, onboard sound, no RAID,
no Serial ATA)
- 512 Mb of 333MHz RAM
- Athlon 2100+
- Maxtor ATA133, 7200 RPM, 30 Gb hard drive
- some generic ATA CD-ROM capable of UDMA2

Into this box was brought over (from the previous machine) 
- PCI-based GeForce MX 400
- DC10+ video capture card

RH8 was installed on this system (a brilliant distro BTW, my compliments to
the RH crew) and it booted and installed just fine. So far, so good.

Next it came to getting all the various devices working, and here's where the
tale of woe starts in earnest.

Let me first state that I am a UNIX professional. I am not at all intimidated
by having to configure and compile a kernel. While I don't have the internal
design of the kernal internalized like many of you do, I have enough of a clue
to be able to do troubleshooting and I can (and do) RTFM. In a pinch, I can
even open up a kernel source file and not be totally lost.

I also understand that the hardware I have is a little on the "bleeding edge"
end of the spectrum - perhaps not so much in terms of the technology, but rather
on the age of the underlying chipsets. So it doesn't bother me that (for example)
the onboard Ethernet chip didn't have a driver in the vanilla 2.4.19 source
that I downloaded. Those that wish to have the latest and greatest must be prepared
to accept that not everything they need is necessarily ready for them _right
now_.

But after this past weekend's horror movie, I wish to make 3 points and impassioned
pleas to all y'all.

1) The current kernel configuration process is overly complex for initial configuration
of new hardware. There needs to be some sort of higher-level configuration level
that addresses kernel subsystems on a "hardware component" level rather than
an individual chip driver level.

What I want is some sort of configuration interface that lets me enter or select
my hardware components on an "item" level by manufacturer and model number rather
than what the thing is actually made of.

This could be a GUI, but doesn't need to be.

For example, I want to be able to pick my motherboard model out of a list. I
then want to be presented with a list of components that are options on that
model on an ITEM basis (ie "gigabit ethernet controller" not "Broadcom FOOBAR73541")
and then select the options that I have. Then do the same thing for the hard
drives, PCI cards, etc. For some items (hard drives in particular) it may make
sense to generalize a little bit rather than specify exact model numbers, but
I'm thinking on terms of OPERATIONAL characteristics "ATA133, 80 pin cable"


And then the process beetles off and configures as much of the kernel as it
can according to these selections.

That probably would not be entirely sufficient to _fully_ configure the kernel,
and so it would still probably be necessary to do a usual "make xconfig" (or
whatever fooconfig) on top of that (to handle filesystem drivers, etc) but at
least I'd know that the hardware had been configured correctly.

I'm not asking that the current granularity be removed. I want another layer
on top of that current layer to abstract away a lot of the little niggling details
that turn out to be so bloody important in actually getting stuff to work.

2) The driver load messages that are retrieved via dmesg often lack proper indication
of state - and it makes troubleshooting a SERIOUS PITA. The offender that sticks
most in my craw at the moment is ATA  - the motherboard supports ATA133. The
drive supports ATA133. I want the damned thing to function in an "ATA133" mode
but I cannot tell if it is doing that or not. All I know is that the drive is
reported as an ATA drive, and that 'hdparm -Tt /dev/hda' reports 7.5 Mb/sec
- which I think is low, but I don't know for sure.

What I want is the message that reports the drive and the interface to say things
like 

"ATA133-capable interface ide0 detected
ide0 running in ATA33 mode (use ide0=ataxxx to change)
Drive hda is a FooBar 123abc (ATA33, ATA66, ATA100, ATA133)
hda is in ATA33 mode
Drive cable not autodetected - need 80 pin cable for ATA100+
Assuming 40 pin cable (use ide0_cable=80 to change)"

The actual verbage is subject for discussion, but if item FOO has more than
one possible state, then please please PLEASE specify what state it is in, and
if there is a way to change that state via a command line parameter or whatever,
state that too.

As it sits right now, it seems I can flip switches 'till doomsday and never
realize where the problem lies - if, indeed there even IS a problem.

3) There really needs to be some sort of centralized hardware database with
a web-based query mechanism that can point people to what drivers are availible
for which hardware, and if they are included in a given kernel version (or not)
and if not, where they can be found. If this already exists, it needs to be
made a hell of a lot more visible and crosslinked from more places, because
I sure never found it - and Google is my friend. I found the Broadcom-supplied
driver for the onboard LAN by pure stupid dumb luck, and I never did find a
sound driver (I had to go to opensound and download their binary drivers to
get sound working - ick!)

Thanks for reading this far on my little rant. I really do appreciate all the
work y'all do, and the quality and performance has come a long way since I first
dipped my toes into Linux back in '97. But damn, three days of my life are gone,
and I still don't have everything working and in many cases I don't know why.
(I'll cover individual issues in separate threads later on.)

Thanks again for reading,

DG 

