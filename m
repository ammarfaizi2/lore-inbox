Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316988AbSFAG4b>; Sat, 1 Jun 2002 02:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSFAG4a>; Sat, 1 Jun 2002 02:56:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:16071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316988AbSFAG4a>;
	Sat, 1 Jun 2002 02:56:30 -0400
Date: Sat, 1 Jun 2002 09:55:20 +0300
From: Dan Aloni <da-x@gmx.net>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Link order madness :-(
Message-ID: <20020601065520.GA11951@callisto.yi.org>
In-Reply-To: <20020531172122.A27675@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 05:21:22PM -0700, Jean Tourrilhes wrote:
> 	I was trying to make the IrDA stack work when compiled in the
> kernel in 2.5.X (as opposed to modular). In 2.4.X, it sort of work,
> but whoever made changes to the IrDA init in 2.5.X obviously didn't
> bother to check what he was doing and check his changes.
> 	So, I was trying to fix that, and I found a problem with
> kernel link order.

It is possible that recent kbuild changes caused that.

[snip]
> 	As both the random driver and the irda drivers are at the same
> init level, there is no way to enforce those dependancies. Currently,
> the IrDA drivers are loaded before the IrDA stack (== kaboom).
> 	Personally, I found it a bit strange the the random driver is
> initialised so late in the game when the whole networking code (at
> leasxt) depends on it.
> 
> 	Please advise...

I remember something like this happened awhile back with the IDE driver, 
trying to call a function in the cdrom driver before it was initialized.

There is a dirty workaround for this problem: Use a local static variable 
to condition the modules' initialization, and make each module call
its init function inside every of its exported function, so this 
'init-on-demand' will make sure the init code runs before the other 
module's code.

BTW, does the new driver model addresses this problem? 

-- 
Dan Aloni
da-x@gmx.net
