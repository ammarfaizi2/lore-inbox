Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSFZXyo>; Wed, 26 Jun 2002 19:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSFZXyn>; Wed, 26 Jun 2002 19:54:43 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58784
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316739AbSFZXym>; Wed, 26 Jun 2002 19:54:42 -0400
Date: Wed, 26 Jun 2002 16:54:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brad Hards <bhards@bigpond.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC 2.4.19-rc1] Fix dependancies on keybdev.o
Message-ID: <20020626235429.GA26734@opus.bloom.county>
References: <20020625160644.GP3489@opus.bloom.county> <200206270658.04695.bhards@bigpond.net.au> <20020626212307.GU3489@opus.bloom.county> <200206270943.33654.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206270943.33654.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2002 at 09:43:33AM +1000, Brad Hards wrote:
> On Thu, 27 Jun 2002 07:23, Tom Rini wrote:
> > On Thu, Jun 27, 2002 at 06:58:04AM +1000, Brad Hards wrote:
> > > On Thu, 27 Jun 2002 00:46, Tom Rini wrote:
> > > > On Wed, Jun 26, 2002 at 12:36:24PM +1000, Brad Hards wrote:
> > > > > 2. Move keyboard handling code to input subsystem
> > > >
> > > > I think that will work out the best.  How's the attached look?  It
> > > > moves drivers/input/Config.in inside of drivers/char/Config.in and then
> > > > fixes arches which had both.  (Lightly tested from xconfig[1] for all
> > > > arches which got changed).
> > >
> > > I'm opposed to further junk going into drivers/char. It is already an
> > > incomprehensible mess of unrelated code.
> >
> > drivers/char/Config.in isn't too bad right now.  If you skip over the
> > horrific mess that is serial support, anyhow.  Perhaps moving some of
> > the arch-specific questions out to arch/$(ARCH)/config.in
> 
> I meant from a user viewpoint. It is just a mish-mash of essentially unrelated 
> questions. I'd prefer to see options moved into menus that describe them. 
> Ideally about a screen length of options (for variable screen resolutions and 
> xconfig vs menuconfig :-)

It could use some sort of re-org I suppose.  But not in 2.4 :)

> > > Actually, I've got another idea, based on some stuff that I've been
> > > working on for the ACPI "its not just power management" issue.
> > >
> > > If you need to set something in drivers/input (per your original patch)
> > > that depends on things that are set in drivers/char (or drivers/usb,
> > > anything that comes later), then split the Config.in into two sections.
> > > One section contains the normal Config.in user-selectable options, and a
> > > second drivers/input/Config-post.in, that is sourced in at the end of
> > > arch/foo/config.in and contains only automated Config.in dependancies (ie
> > > define_bool) but no user selectable options.
> > >
> > > Does this make sense? If not, I'll try for a patch that shows it later
> > > this morning.
> >
> > I don't think this makes sense for input however, unless we kill off
> > drivers/input/Config.in (and for sh/m68k/sparc64 just paste the lines
> > in) and merge it into drivers/char/Config.in (CONFIG_INPUT,
> > CONFIG_INPUT_{KEYB,MOUSE,EV}DEV) and drivers/char/joystick/Config.in
> > (CONFIG_INPUT_JOYSTICK).  I wouldn't be opposed to doing that...
>
> I think that I've explained it poorly. I'll patch.

I'm not sure. :)  It's a 6 question menu, keep in mind... (With 1 that
actually depends on something else, code-wise.  Which is why if we
really want to try and clean up the logic and compile issues,
drivers/input/Config.in should probably die... (Or never be called
directly on arches which do get drivers/char/Config.in)  And some of the
joystick stuff re-arranged..

> > And for USB (CONFIG_INPUT'ed) joysticks we aren't any worse off, and
> > perhaps we could even move those into a USB menu.
>
> That is where most of the input stuff came from :-)

heh.

> My main concern is that by 2.6, I don't want the current mess with Config 
> options. I want something that is logical and makes sense to people. Right 
> now, the only reliable way to get a build is to either check every menu (and 
> submenu, and subsubmenu), or to take a previously working config for that 
> machine, make oldconfig, and hope for the best. 

Hopefully with 2.6 the input stuff won't suck as much.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
