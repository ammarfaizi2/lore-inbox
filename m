Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSC1IWd>; Thu, 28 Mar 2002 03:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313104AbSC1IWY>; Thu, 28 Mar 2002 03:22:24 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:42758
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292588AbSC1IWP>; Thu, 28 Mar 2002 03:22:15 -0500
Date: Thu, 28 Mar 2002 00:21:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andersen@codepoet.org,
        Jos Hulzink <josh@stack.nl>, jw schultz <jw@pegasys.ws>,
        linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <3CA2CDA1.7090505@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203280012130.6661-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Open collector ~= a Tri-State or a float.

It does exist for the "DATA" lines, and those are not setup to float until
there is a referrence ground to set the buffer on the ATA drive.
ATAPI (best known by me is HP-Colorado 8GB tape) will suck power off the
ribbon if there is no line voltage applied to the Molex connector.

I hate to say of you are core developing on a laptop, you are not playing
w/ native hardware.  Laptops to special things, period.

ATA does not goe the distance because they did not put line drivers of any
strength, the the $5.00 difference in the controllor on the bottom of the
drive.  Also I have cables which are 3 feet and run in mode 5 or Ultra100,
but you can be sure that it is a special HOST to provide the push and
power to make the distance.  It has 80c headers on the HOST side but 40c
IDC's on the device side.

There is majic and it gets released if you do it wrong and form bricks.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 28 Mar 2002, Martin Dalecki wrote:

> OK set's sheed a light on the issue:
> 
> Contrary to popular beleve the SCSI termination stuff wasn't
> introduced for the pain of system administrators but just
> to meet the simple rule of physics that an stripe of copper
> with a dangling end can act as a nice antenna of Bluetooth like
> radio networking called signal transfer by changing current in it ;-).
> 
> ATA is using a much much cheaper and simpler aproach to the
> same problem: it's called pathetically "distributed termination".
> In reality this means that the master drive contains half
> of a proper passive termination resistor bridge and the
> slave the other half. Additionally they just specified that
> the cable can't become too long to make the whole thing non
> functional if there is only one drive on the cable - which
> means half the therminating resistance at the end. As an added
> bonus they didn't care becouse they never expected too high
> transfer rates (read signal frequencies) for this interface.
> 
> Did  you ever wonder why ATA cables can't be as long as SCSI?
> This is the reason wy.
> 
> Now with the higher transfer rates the host chips simple started
> to adjust they output drivers to the presence of one or two
> devices on the cable (bus). Did you ever wonder why the CMD640
> was sporadically corrupting data - well they did get this
> adjustment barely right on the primary channel and
> seriously wrong on the secondary. It's not cheap to
> implement diode cascades in CMOS for on chip resistors with
> adequate accuracy and CMD tryed to get away the cheap way...
> and it was all about bus termination.
> 
> If you now suddenly remove one
> device the termination will be improper and you will not
> be able anylonger to provide acceptable transfer rates and you can
> get some voltage spikes which can destroy the output drivers
> of the involved controllers. However this is *very unlikely*,
> becouse they can usually sustain quite reasonable currents -
> but it's still possible. The simplest guard against this
> kind of disaster is a zener diode around the output lines drivers -
> this is a *very* common practice on electronics those days now,
> so still the chances of a phyical desaster on recent hardware
> are *very low*. Reconnecting is more interresting becouse
> the gorund level differences between the devices can be
> arbitrary and due to electrostatics there can be voltage
> spikes which can indeed destroy you hardware...
> 
> Then there is this talking around about the "tristate of some" device.
> I'm really a bit sick of it. Becouse there is no such a state
> like a tri-state. We have just bus drivers on both ends.
> They are implemented usually as Schmidt triggers. They have three
> possible states on output: low voltage, high voltage, high resistance.
> 
> If you put the disk's and  the host chip's output drivers
> into the *high resistance state* or in other words if
> you de-select them (not an ominous "tristate")
> and then there is only a single one disk on the channel,
> then it *is* electrically just safe to disconnect it thereafter.
> Many modern disks support this in esp. for example PCMCIA
> card adapter based pseudo disks.
> 
> If there is a simple gate chip (74HC255 or similar comes to mind)
> between the host chip and the external connector - which is possible
> controlled by some spare controll line on the south brigde
> - it can all be easly handled by the BIOS. However to support
> OS which don't have special interacting drivers you will
> most likely make this small gate chip pass-through as default...
> This is what all the whole "docking station" stuff is about.
> 
> (Ehmmm.... let's possible just see whatever there is actually any current
> on the external ATA interface of my notebook even when the CD-ROM
> is disconnected...)
> 
> But there is not really any special magic involved!
> 

