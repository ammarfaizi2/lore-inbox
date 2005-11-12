Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVKLXjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVKLXjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVKLXjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:39:53 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:5269 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S964878AbVKLXjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:39:52 -0500
Date: Sun, 13 Nov 2005 00:41:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Why did oldconfig's behavior change in 2.6.15-rc1?
Message-ID: <20051112234120.GA29969@mars.ravnborg.org>
References: <200511121656.29445.rob@landley.net> <200511121731.25982.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511121731.25982.rob@landley.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 05:31:25PM -0600, Rob Landley wrote:
> On Saturday 12 November 2005 16:56, Rob Landley wrote:
> > Linus says if we're going to test something, test -rc1, so I did.
> >
> > It went boing.
> >
> > I'm still trying to get -skas0 working on x86-64, but this was a standard
> > x86 build...
> >
> > Rob
> 
> Very, very strange:
> 
> > make ARCH=um allnoconfig
> > cat >> .config << EOF
> CONFIG_MODE_SKAS=y
> CONFIG_BINFMT_ELF=y
> CONFIG_HOSTFS=y
> CONFIG_SYSCTL=y
> CONFIG_STDERR_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_UBD=y
> CONFIG_TMPFS=y
> CONFIG_SWAP=y
> CONFIG_LBD=y
> CONFIG_EXT2_FS=y
> CONFIG_PROC_FS=y
> EOF
> > make ARCH=um oldconfig
> > grep SKAS .config
> # CONFIG_MODE_SKAS is not set
> 
> Why did oldconfig switch off CONFIG_MODE_SKAS?  It didn't do that before.  
> Hmmm...  Rummage, rummage...  Darn it, it's position dependent.  _And_ 
> version dependent.
> 
> Ok, now I have to put the new entries at the _beginning_.  Appending them 
> doesn't work anymore, it now ignores any symbol it's already seen, so you 
> can't easily start with allnoconfig, switch on just what you want, and expect 
> oldconfig to do anything intelligent.
> 
> That kinda sucks.  Oh well, I can have sed rip out the old symbols before I 
> append the new ones.  Here's hoping it's not _that_ position dependent...

A much better way would be to put the values in a file named:
allno.config

With latest kconfig changes this will do the trick, and you will have a
valid config no matter what you put in.

	Sam
