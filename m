Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbUBXCiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 21:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbUBXCiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 21:38:09 -0500
Received: from guug.galileo.edu ([168.234.203.30]:134 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S262105AbUBXCiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 21:38:00 -0500
Date: Mon, 23 Feb 2004 20:37:59 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
Message-ID: <20040224023759.GA16499@guug.org>
References: <1077497593.5960.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077497593.5960.28.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 11:53:14AM +1100, Benjamin Herrenschmidt wrote:
> Hi !
> 
> Here's a list of pending issues with fbdev (either upstream or in the
> fbdev bk treee), I figured posting it here may help getting more people
> on those issues as my time is sparse and I suppose James too.
> 
>  - First one, I will deal with, just writing it for completeness: When
> switching from KD_GRAPHICS to KD_TEXT (either same console changing mode
> or switching to a different console), we need a callback so the fbdev
> has a chance to restore the accel engine setting (or even the whole
> mode, to be safe).
> 
>  - Memory corruption problems. There is still at least one identified
> when using stty. Just use crazy values, like flipping rows & cols (like
> stty rows 132 cols 30) and usually, you'll see the box blow up very soon
> with heavy memory corruption.
> 
>  - mach64 lockups on LT-G (I'll try on an LT-Pro soon) plus other
> mach64 bugs in the new version in the bk fbdev, I'll have a patch for
> some of the problems, but I didn't find a good explanation for the
> accel lockups yet
> 
>  - Logo problems. When booting with a logo, then going to getty, the
> logo doesn't get erased until we actually switch to another console (or
> reset the console). At this point, using things like vi & scrolling up
> doesn't work properly. Actually, last time I tried, I had to switch
> back & forth twice before my console that had the logo got fully working
> with vi.
> 
>  - Back buffer problem: maybe related to the logo ? After boot, doing
> shift-pageup to go back to the boot message, usually you get crap
> displayed at various places.
> 
>  - On x86, various junk displayed when the fbdev takes over. Reported
> by radeonfb users, I couldn't test myself, I don't have an x86 with
> radeon at hand for the moment. Apparently, the takeover from vgacon
> doesn't properly "convert" the previous VGA text buffer content
> 
>  - stty & mode picking. Currently, fbcon_resize() (called when stty is
> used to resize the console) will hack a "var" strcture by just putting
> new width/height in it and pass that to set_var. The way the various
> drivers react to that mostly broken "var" structure is rather random.
> We need to explicitely differenciate between a mode that is "complete"
> (like what fbset or X passes down the fbdev) or a mode that is just
> width/height and eventually a hint of frequency, like what fbcon passes
> in this case. I added FB_ACTIVATE_FIND for that purpose, but that needs
> better driver support to "pick" up a proper mode. The algorithm for
> that isn't trivial. Could be moved to common code.
> 
>  - fbset doesn't resize the console. I consider that a regression from
> 2.4. I have some code based on the notification mecanism to address
> that, but it tends to trigger the same memory corruption problem as
> reported with stty & bogus coordinates. There is something hairy going
> on with console resizes. That code is a bit foreign to me though.
> 
> Ok, that's all that comes to my mind right now, help is welcome :)

- bus_id for each fbdev, so from userland became posible to identify
  to which card we are controlling.  I know it should be exported via
  sysfs but an ioctl should be really handy as when you program for
  fbdev anyway you have to use ioctl's, just to get the bus_is will
  be a pain use sysfs.

-otto
  
