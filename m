Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbUJ1JC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUJ1JC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbUJ1JC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:02:29 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:23562 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262842AbUJ1JBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:01:13 -0400
Date: Thu, 28 Oct 2004 11:07:07 +0200
To: Timothy Miller <miller@techsource.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041028090707.GA13523@hh.idb.hist.no>
References: <4176E08B.2050706@techsource.com> <9e4733910410201808c0796c8@mail.gmail.com> <Pine.GSO.4.61.0410222209410.11567@waterleaf.sonytel.be> <417984A9.2070305@techsource.com> <20041024104520.GB12665@hh.idb.hist.no> <417D2027.5000306@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417D2027.5000306@techsource.com>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 11:47:51AM -0400, Timothy Miller wrote:
> 
> >I can't see how it is "vital", or even makes a difference at all.
> >Other than upping the price a bit.  The pc doesn't need VGA compatibility
> >to boot - because you supply a video bios.  The mainboard bios
> >uses the video bios. (There have been pc's with ibm-incompatible
> >displays before)
> >Linux d(and other open os'es) doesn�'t need VGA at all, because 
> >you supply docs.  You probably won't even have to write the driver
> >yourself.
> >Windows doesn't need VGA - if you supply a windows driver.  That
> >shouldn�'t be hard to do.  
> 
> 
> We have a number of cards which do not support VGA, and a few years ago, 
> I experimented with the idea of writing a VGA BIOS which emulated the 
> VGA text screen in software.
> 
> What I discovered was that absolutely everything, including the DOS 
> shell, expects there to be REAL VGA (or CGA or whatever) hardware there, 

Remember who you're talking to. :-)
VGA, (or at least CGA) may indeed be necessary to run dos.
(Well, dos 2.11 ran fine on the incomptaible DEC rainbow...)
So if you need dos compatibility - sure.  

But this is the linux kernel list - you asked what the
open source community want.  We _really_ don't care about dos.
And I believe this is true for many others too - dos _is_ dead.
Even the microsoft fans use windows exclusively.
So don't worry about dos - it is such a niche os today.

> so hooking int 10 just did not do the job... it practically never got 
> called.  What I ended up doing was hooking the timer interrupt and 
> comparing the text screen against a shadow copy.  That worked very well 
> for most DOS applications... except for those which tried to do anything 
> in protected mode.  The instant an OS switched to protected mode, the 
> interrupt handler got blown away and the display froze.

Sure - but who's running dos these days?  Is there any market share
in _dos_?  And there is freedos, for which the source code is
available and free.  So if you really need dos for something,
(such as flashing mainboard bioses?) then add the necessary support
to freedos. 
 
> Then we though we'd put a proper driver into the OS, but the problem is 
> that in Windows and Solaris, the console driver doesn't kick in until 
> WAY late in the boot process, so you end up with a useless console for 
> THE MAJORITY of the boot process.
> 
> For Windows, there is a requirement for 640x480x4 and some 320x480x?? 
> mode to be supported by the hardware using the standard VGA IO space 
> registers.  That is, IF you want a console.  Yes, you can boot without 
> VGA, but your screen is blank until the driver kicks in, so if there's a 
> PROBLEM, you're hosed.

Sure - that could be a problem.  This depends on how much you want to
sell to windows users.  We linux users, and other open source users,
don't worry that much about windows console deficiencies.  
Particularly considering how the common windows user doesn't use his
console anyway - ms hides everything behind a pretty "Please wait,
windows is starting" screen. And they reinstall if something goes wrong :-/

You are sure that an "early boot" console driver for windows is impossible?
Ms provides no clue about replacing this thing?  Rendering text onto vga
must be done somewhere, possibly in a library that could be replaced.

> 
> VGA is so "expected" that pretty much everything just assumes it's there 
> and bangs on the hardware directly.

So it is a question of what you want to support, and how numerous
these VGA users are.  Perhaps you won't have to implement _all_
of VGA though - that might save space in your FPGA.  Full VGA have some
rarely used oddball modes and features - and backwards compatibility
cruft.  Who needs the EGA modes or ability to load textmode
fonts for example - when all the user need is to see some
boot messages before the real driver takes over.

If you go for VGA, then I hope the VGA bits will be
somewhat optional or possible to disable, so the VGA bits
doesn�'t get in the way when trying to use several cards
simultaneously.  You may make cards that cooperate nicely with
each other - but there may be other card(s) in the machine
too that also mess with VGA registers at strange times.

If VGA is implemented entirely in the FPGA then perhaps there
will be alternate FPGA firmwares for different purposes. (Surely
cheaper than making different boards).  One variant could
be VGA-less, the space may then be used for other purposes. An 
extra 3D-unit of some sort perhaps. :-)

Helge Hafting

