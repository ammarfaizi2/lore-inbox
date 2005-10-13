Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbVJMIeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbVJMIeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 04:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbVJMIeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 04:34:03 -0400
Received: from tim.rpsys.net ([194.106.48.114]:30632 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751563AbVJMIeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 04:34:01 -0400
Subject: Re: spitz (zaurus sl-c3000) support
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051012233917.GA2890@elf.ucw.cz>
References: <20051012223036.GA3610@elf.ucw.cz>
	 <1129158864.8340.20.camel@localhost.localdomain>
	 <20051012233917.GA2890@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 09:33:38 +0100
Message-Id: <1129192418.8238.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 01:39 +0200, Pavel Machek wrote:
> Hi!
> 
> > > I got spitz machine today. I thought oz3.5.3 for spitz would be
> > > 2.6-based, but found out that I'm not _that_ fortunate.
> > 
> > oz 3.5.4 is due for release soon and will hopefully have a 2.6 option
> > for spitz.
> 
> Is there chance to get preview version somewhere? 2.6-capable userland
> would be very nice (and zImage would help, too, just for a demo :-).

I'm no sure offical preview images exist but here's something I built
myself recently:

http://www.rpsys.net/openzaurus/temp/spitz/

Rename the gpe or opie file "hdimage1.tgz" to flash depending on what
flavoured image you'd like. You need the other files including gnu-tar.
You don't need an initrd.bin file as under 2.6 we can boot directly from
the microdrive.

I'm hoping these work - I'm not sure I've tried one of them... :)

> I was thinking about "huh, is this machine tosa or spitz", but it is
> labeled SL-C3000, so it should be spitz.

Correct. Tosa is SL-C6000.

> Wildly offtopic... I got poweradapter with spitz (with funny design)
> that says 100V (and lot of japanese letters).. I guess it would be
> very bad idea to try it at 240V?

Trust me, its a very bad idea...

> > This file should give you an idea of which patches to apply in what
> > order:
> > http://www.rpsys.net/openzaurus/temp/linux-openzaurus_2.6.14-rc1.bb
> 
> Quite a long list; what is $RPSRC -- that is where are those patches
> really placed? 

Its declared in:
http://www.rpsys.net/openzaurus/temp/linux-openzaurus.inc

so $RPSRC = http://www.rpsys.net/openzaurus/patches

You probably don't need the ipaq hx2750 or tosa patches, they're just
part of my tree. The top 15 patches have been merged since -rc1 came out
(they were in the process of being merged at the time).

> Yes, asm/arch/ohci.h seems to be missing... But I should probably do
> update, I'm at rc2 with my zaurus hacks now.

That's still a problem although a patch queued for 2.6.15 will add that
file so I'm in two minds as to what to do with it. There's also an issue
with struct pxafb_device which I've agreed a solution to, just need to
write the patch and I think a reference to the battery device sneaked
into mainline when it shouldn't have done.

> Is there some way I can help you (besides obviously testing)?

I'm open to any help in getting the none ipaq/tosa things merged with
mainline. Have a look through them patch series and see if there's
anything you fancy taking on. Most of them are simple fixes although
some are nasty hacks we need to find some way of doing nicely.

The biggest thing is the battery/power management patch. I've just
agreed some changes to enable it to stand a chance of making mainline.
It probably needs more coding style cleanup.

There's also sound to get working although so code arrived yesterday
which should help with that. The usb client code exists in
handheld.org's kernel26 cvs tree. We need to extract it, fix any bugs
and talk to the usb developers about it.

Its a shame you don't have a C1000 as there's a nasty bit of coding
someone with such a device needs to do to complete mainline 2.6 support
(I2C driver for its IO Expander to enable access to its extra GPIOs).

Richard

