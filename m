Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSFZXqe>; Wed, 26 Jun 2002 19:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSFZXqd>; Wed, 26 Jun 2002 19:46:33 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:49394 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316678AbSFZXqc>; Wed, 26 Jun 2002 19:46:32 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH/RFC 2.4.19-rc1] Fix dependancies on keybdev.o
Date: Thu, 27 Jun 2002 09:43:33 +1000
User-Agent: KMail/1.4.5
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20020625160644.GP3489@opus.bloom.county> <200206270658.04695.bhards@bigpond.net.au> <20020626212307.GU3489@opus.bloom.county>
In-Reply-To: <20020626212307.GU3489@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206270943.33654.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2002 07:23, Tom Rini wrote:
> On Thu, Jun 27, 2002 at 06:58:04AM +1000, Brad Hards wrote:
> > On Thu, 27 Jun 2002 00:46, Tom Rini wrote:
> > > On Wed, Jun 26, 2002 at 12:36:24PM +1000, Brad Hards wrote:
> > > > 2. Move keyboard handling code to input subsystem
> > >
> > > I think that will work out the best.  How's the attached look?  It
> > > moves drivers/input/Config.in inside of drivers/char/Config.in and then
> > > fixes arches which had both.  (Lightly tested from xconfig[1] for all
> > > arches which got changed).
> >
> > I'm opposed to further junk going into drivers/char. It is already an
> > incomprehensible mess of unrelated code.
>
> drivers/char/Config.in isn't too bad right now.  If you skip over the
> horrific mess that is serial support, anyhow.  Perhaps moving some of
> the arch-specific questions out to arch/$(ARCH)/config.in

I meant from a user viewpoint. It is just a mish-mash of essentially unrelated 
questions. I'd prefer to see options moved into menus that describe them. 
Ideally about a screen length of options (for variable screen resolutions and 
xconfig vs menuconfig :-)

So mice and joysticks are kind-of input things, so they belong with other 
input config options.

Similarly, DRM and AGP are video options, so they belong together in a video 
section (certainly not in a character device options section). Maybe with 
other console options (although the concept of console is a bit strange in 
the era of desktop unix) like framebuffer and VT.

Serial can bugger off by itself.

ftape is a mass storage thing, and belongs with other mass storage options 
like block devices, ide and scsi.

i2c and watchdog cards are basically for system monitoring. 

> > Actually, I've got another idea, based on some stuff that I've been
> > working on for the ACPI "its not just power management" issue.
> >
> > If you need to set something in drivers/input (per your original patch)
> > that depends on things that are set in drivers/char (or drivers/usb,
> > anything that comes later), then split the Config.in into two sections.
> > One section contains the normal Config.in user-selectable options, and a
> > second drivers/input/Config-post.in, that is sourced in at the end of
> > arch/foo/config.in and contains only automated Config.in dependancies (ie
> > define_bool) but no user selectable options.
> >
> > Does this make sense? If not, I'll try for a patch that shows it later
> > this morning.
>
> I don't think this makes sense for input however, unless we kill off
> drivers/input/Config.in (and for sh/m68k/sparc64 just paste the lines
> in) and merge it into drivers/char/Config.in (CONFIG_INPUT,
> CONFIG_INPUT_{KEYB,MOUSE,EV}DEV) and drivers/char/joystick/Config.in
> (CONFIG_INPUT_JOYSTICK).  I wouldn't be opposed to doing that...
I think that I've explained it poorly. I'll patch.

> And for USB (CONFIG_INPUT'ed) joysticks we aren't any worse off, and
> perhaps we could even move those into a USB menu.
That is where most of the input stuff came from :-)

My main concern is that by 2.6, I don't want the current mess with Config 
options. I want something that is logical and makes sense to people. Right 
now, the only reliable way to get a build is to either check every menu (and 
submenu, and subsubmenu), or to take a previously working config for that 
machine, make oldconfig, and hope for the best. 

That sucks.

We go to all this effort to write clean, beautiful code. Then we make it nigh 
on impossible for non-gurus to get the most out of it.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
