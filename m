Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268169AbTBSA5A>; Tue, 18 Feb 2003 19:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268171AbTBSA5A>; Tue, 18 Feb 2003 19:57:00 -0500
Received: from tomts15.bellnexxia.net ([209.226.175.3]:38800 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268169AbTBSA4y>; Tue, 18 Feb 2003 19:56:54 -0500
Date: Tue, 18 Feb 2003 20:04:07 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
In-Reply-To: <3E52B4CE.7040009@verizon.net>
Message-ID: <Pine.LNX.4.44.0302181955260.24383-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Stephen Wille Padnos wrote:

> [snip]
> 
> >  as i see it, this can only get worse.  the current
> >erratic and disorganized structure of the config menus
> >is proof of that.
> >
> >  comments?
> >
> 
> I think the problem with the "Multimedia" menu is that it's misnamed.  
> It should actually be the "tuners" menu - it's there for audio, digital 
> video, and video tuners.  The same could be said of the networking menu, 
> and presumably others.
> 
> You can actually reorganize things simply by changing the structure of 
> the top-level Kconfig file.  With the following patches, I reorganized 
> the multimedia options into the form that you are probably looking for.  
> (hopefully they won't be mangled by my mailer)
> 
> With not too much rewriting (many small changes, I think), the menus can 
> be organized much better.
> 
> Essentially, each subdirectory has a Kconfig file that does _not_ 
> declare itself a standalone menu.  This allows a parent to decide 
> whether or not to include it in another menu.  The menu should only have 
> options that pertain to things in its' directory.  ie, the Kconfig file 
> in drivers/net should not include "Networking" as an option - that is a 
> higher level decision (ie, it decides whether or not to include the 
> drivers/net config file).
> 
> Then, the Kconfig files from various subdirectories can be ordered in 
> whatever way makes sense from a user's point of view
> 
> --- drivers/media/Kconfig.orig        2003-02-18 17:15:46.000000000 -0500
> +++ drivers/media/Kconfig.new 2003-02-18 17:25:27.000000000 -0500
> @@ -2,8 +2,6 @@
>  # Multimedia device configuration
>  #
> 
> -menu "Multimedia devices"
> -
>  config VIDEO_DEV
>         tristate "Video For Linux"
>         ---help---
> @@ -32,5 +30,4 @@
> 
>  source "drivers/media/dvb/Kconfig"
> 
> -endmenu

... some patch snipped here ...

  oh, i'm aware that (for example) the multimedia menu stuff
can be fixed if you go into the directory and change the Kconfig
file.  but that's exactly the kind of thing i'm trying to 
*avoid*.  philosophically, it would be ideal to let each 
directory be a self-contained bundle of related modules
and the Kconfig menu file that goes with them.

  what has to be avoided is for any of these directories to
give itself a menu label that implies that it's fairly high
up in the food chain, and subsequently leave no way to 
incorporate submenus beneath it.  (see, eg., "Multimedia")

  rearranging the top-level options by having to make changes
to any of the individual subdirectory Kconfig files is just not
an appealing option.

  i realize that all of this sounds like much ado about
nothing, but as more options are added to the kernel, this
is just going to get more unmanageable, but i have no idea
if anyone else thinks this is something worth addressing.

  if not, i'm willing to drop it.

rday

