Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUA3U4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUA3U4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:56:49 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:25610 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264113AbUA3U4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:56:45 -0500
Date: Fri, 30 Jan 2004 22:09:15 +0100
To: Timothy Miller <miller@techsource.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Message-ID: <20040130210915.GA4147@hh.idb.hist.no>
References: <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk> <40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no> <401A8E0E.6090004@techsource.com> <Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl> <401A9716.3040607@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401A9716.3040607@techsource.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:40:38PM -0500, Timothy Miller wrote:
> 
> 
> Maciej W. Rozycki wrote:
> >On Fri, 30 Jan 2004, Timothy Miller wrote:
> >
> >
> >>>Another reason to drop VGA then - money.
> >>
> >>As soon as PC BIOS's don't require it, we can drop it.
> >
PC bioses don't need VGA and never did!
They use the int 0x10 handler provided by the graphichs card bios.
When you make the card - you get to write that bios. No problem!

I once used a dec rainbow - a pc with an ibm-incompatible screen.
The display memory was organized as a linked list of lines instead
of an array of characters.  It came with its own special version
of msdos 2.11.  Few ordinary dos programs would run on it,
beause most tried to access the "standard" 80x25 array instead
of using msdos for io.  Those who did the right thing worked, though.

(An odd machine in other ways too - it had a z80 controlling the
floppies and a 8088 controlling the screen and harddisk.
Early 80's asymmetric multiprocessor :-)


> >
> > No PC BIOS recognizes a VGA.  The PC/AT firmware uses int 0x10 to
> >communicate with the console and as long as there is a handler there,
> >console output works.  Most systems will actually run without a handler,
> >too, but they'll usually complain to the speaker.  The handler is provided
> >by the ROM firmware of the primary graphics adapter.
> >
> > Old PC/AT firmware actually did recognize a few display adapters, namely
> >the CGA and the MDA which had no own firmware.  These days support for
> >these option is often absent, even though the setup program may provide an
> >option to select between CGA40/CGA80/MDA/none (the latter being equivalent
> >to an option such as an EGA or a VGA, providing its own firmware).
> >
> 
> You're not entirely correct here.  I attempted to write a VGA BIOS for a 
> card which did not have hardware support for 80x25 text.
> 
> I first tried intercepting int 0x10.  I quickly discovered that most DOS 
> programs bypass int 0x10 and write directly to the display memory.  As a 
> result, very little of what should have displayed actually did.
> 
Sure, but we're not interested in "most dos programs", are we?
The pc bios bootup will work, it uses int 0x10.
lilo output will work.
linux kernel console output will work
X will work, either with the generic framebuffer driver, or with
a proper driver written for the open hardware.

> Next, I tried hanging off this timer interrupt.  I had two copies of the 
> text display, "now" and "what it was before".  I would compare the 
> characters and render any differences.  This worked quite well for DOS, 
> but the instant ANY OS switched to protected mode, they took over the 
> interrupt and all console messages stopped.  Actually, the same was true 
> for int 0x10.
> 
If you want DOS application compatibility or windows compatibility
then you might need VGA.  But you started out talking about
open hardware for linux - and then you really don't need vga at all.
Not even an initial 80x25 character array. A kernel without vga
support (but some other console like fbcon) works fine.

> Even just the DOS shell command-line tends to bypass int 0x10 and write 
> directly to display memory.
> 
Depends on what version of dos, but you can always get freedos for which
source code is available - if dos matters to you. It is something
I only ever use for flashing bios upgrades.

> Furthermore, 640x480x16 simply won't happen at all without direct 
> hardware support.  Some things rely on that (or mode X or whatever) for 
> initial splash screens.
>
Not in linux.  Of course you can reserve the legacy vga memory region
and just live with the loss of splash screens in dos.
 
> In the PC world, too many assumptions are made about the hardware for 
> any kind of software emulation to work.
>
Not in the pc world.  The pc is only hardware.  
The problem is the microsoft os world, but supporting that _isn't
necessary_ when you don't plan on high volumes.  I guess you
could get windows going - it uses proper display drivers these days
even if the installer doesn't. Install with vga card, swap driver,
shutdown, swap cards, power-on or some such.
 
> The suggestion that a general-purpose CPU on the graphics card could be 
> used to emulate it is correct, but the logic area of the general-purpose 
> CPU is greater than that of the dedicated VGA hardware.  Furthermore, 
> you can't just "stick a Z80 onto the board", because multi-chip 
> solutions up the board cost too much.

Thanks for the information, seems I don't know enough about board 
manufacturing.


Helge Hafting
