Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293306AbSC0XR3>; Wed, 27 Mar 2002 18:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSC0XRU>; Wed, 27 Mar 2002 18:17:20 -0500
Received: from vaak.stack.nl ([131.155.140.140]:54544 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S293306AbSC0XRL>;
	Wed, 27 Mar 2002 18:17:11 -0500
Date: Thu, 28 Mar 2002 00:17:06 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <20020327143427.N6223@pegasys.ws>
Message-ID: <20020327235029.P78593-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, jw schultz wrote:

> On Tue, Mar 26, 2002 at 07:01:18PM +0000, Pavel Machek wrote:
> > > IDE isn't really meant to allow hot swap but it can be done.
> > >
> > > As Jeremy says, electrically it is difficult to do it with a
> > > master+slave on one cable because you really must power down
> > > the interface (cable) and that would mean downing both devices.
> >
> > But that's not a problem most times, right? Downing device on same
> > channel for 10 second it takes to plug it in should not be a problem.
> > 								Pavel
>
> Sure, just be sure you POWER down the device(s) and the
> interface.  IDE is no more designed to be hot-swap than the
> ISA buss.  It was originally a buss level emulation of a
> specific Western Digital controller for ST506 drives.  Talk
> to an EE familiar with the spec and implementations and make
> sure that your card can either power down or go buffered
> tristate.  Smoking can be hazardous to your computer's
> health.

Hi, here your EE :)

IDE indeed never was ment to be hot pluggable. With SCSI, you can tell a
hard disk to shut down and disconnect from the bus. With IDE, your
controller has to shut down completely. You can tell your disk to
spin down, but in any case, your disk will remain powered. In shutdown
mode, your disk will not consume much power anymore, but the electronics
are NOT in a "feel free to disconnect now" state. The disk is still
listening to the bus.

This means that unplugging one device can have undetermined results for
both that device and the complementary device on the bus. As an EE, I must
admit the chances are VERY, VERY odd that it will actually affect data,
but personally, I'm one of those guys who say: In theory, it's possible,
so this is a "don't".

There are controllers who say they can shut down completely, but I have
never seen an IDE disk which can do it. The fact you can bring any disk
back alive after a sleep command (part of the latest ATA standards), means
the disk isn't suitable for hot-swapping.

If you really want to build in IDE hot swap support, I demand it comes
with a warning: Enabling this option will probably destroy your harddisks
and your chipset. Feel free to continue, but don't blame us.

> Disclaimer: I am not an Electronics Engineer, nor an expert
> on IDE/ATA/ATAPI yadda, yadda, yadda.  I wrote because this
> thread, while useful for the future  was on a tangent that
> wasn't telling John Summerfield how he might actually do
> what he wants, today.

Disclaimer: I am an EE, well known with IDE/ATA. I wrote this because my
opinion is Linus should block any attempts of hot pluggable IDE devices,
for Linux will be the only OS that supports it and destroys your harddisks
thanks to the fact it supports it (If other OSes support it, please let
me know, I'll guarantee you there are lots of warnings involved). Hot
plugging might work, when you are lucky. Luck is not something that should
be the base of a decent OS. If hot IDE plugging makes its way in, don't
blame me...

Jos

