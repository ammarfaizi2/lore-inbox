Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317425AbSFCRPE>; Mon, 3 Jun 2002 13:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317426AbSFCRPD>; Mon, 3 Jun 2002 13:15:03 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:63212 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317425AbSFCRPD>;
	Mon, 3 Jun 2002 13:15:03 -0400
Date: Mon, 3 Jun 2002 10:14:47 -0700
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Dan Aloni <da-x@gmx.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Link order madness :-(
Message-ID: <20020603101447.A6067@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020601065520.GA11951@callisto.yi.org> <Pine.LNX.4.44.0206010235340.21152-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 02:43:14AM -0500, Kai Germaschewski wrote:
> On Sat, 1 Jun 2002, Dan Aloni wrote:
> 
> > > 	So, I was trying to fix that, and I found a problem with
> > > kernel link order.
> > 
> > It is possible that recent kbuild changes caused that.
> 
> I don't think so, I took extra care to leave it all the same. (Well, 
> except for sound/, which is outside drivers/) It'd however surely be a 
> good idea to go through it and document which dependencies there are.

	Obviously Dan didn't bother to read my e-mail. The problem is
definitely not with kbuild. The problem is with the
__define_initcall() levels.

> W.r.t to the original problem I have to say I didn't really look into yet, 
> but I think it makes e.g. a lot of sense to initialize networking earlier 
> (subsys_initcall). We have initcall levels, using them right will help a 
> lot. (The block subsystem is only __initcall a.k.a. driver_initcall as 
> well, that's asking for problems at some point)

	The problem is *not* the networking initialisation (I wish
people were *reading* my e-mails). The basic networking is initialised
early enough. The various networking stacks could be initialised
earlier, but I don't depend on them. Note that there might be a reason
to initialise networking after the file system, so to do that we might
need to insert a level between fs_initcall() and device_initcall().

	The problem is with the initialisation of the random
generator. It needs to be done earlier.

> --Kai

	Regards,

	Jean
