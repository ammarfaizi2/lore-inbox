Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTFZWgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTFZWgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:36:48 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:28632 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264061AbTFZWf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:35:59 -0400
Date: Fri, 27 Jun 2003 00:50:02 +0200
From: Manuel Estrada Sainz <ranty-bulk@ranty.pantax.net>
To: Pavel Roskin <proski@gnu.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
       orinoco-devel@lists.sourceforge.net, jt@hpl.hp.com
Subject: Re: [Orinoco-devel] orinoco_usb Request For Comments
Message-ID: <20030626225002.GA4703@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030626205811.GA25783@ranty.pantax.net> <Pine.LNX.4.56.0306261734230.3732@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0306261734230.3732@marabou.research.att.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 06:03:23PM -0400, Pavel Roskin wrote:
> On Thu, 26 Jun 2003, Manuel Estrada Sainz wrote:
> 
> >  I now believe that it is stable enough for the kernel, and I would like
> >  to get it integrated in the official kernel tree.
> >
> >  At first I tried convincing David to accept the changes in the standard
> >  orinoco driver but he was (rightfully) skeptic. Then Jean Tourrilhes
> >  opened my eyes, the changes touch carefully crafted locking semantics
> >  and could give trouble (although it has been working well for quite a
> >  while), and suggested adding it as an independent (alternative) driver.
> 
> I think it's a reasonable request.  It's a pity that the future work on
> the Orinoco driver won't be integrated into your driver automatically.  In
> particular, scanning, monitor mode and switching to the separate wireless
> handlers may be useful for the USB driver as well.
> 
> But indeed, Orinoco USB is very different from other Orinoco cards.  There
> is a firmware that stands between the driver and the PCMCIA card, and that
> firmware is less transparent than, say, PLX bridges.
> 
> It's a tough call, and it's up to you to make.

 I am not going that drastic jet, I'll provide all functionality:

	hermes-exp.o       orinoco-exp_cs.o       orinoco-exp_plx.o
	orinoco-exp.o      orinoco-exp_pci.o      orinoco-exp_tmd.o
	orinoco-exp_usb.o

 And keep merging with David's code. If in the end David likes the code
 we merge the two and live happily for ever after, and if not the most
 similar the two variants are, the easier periodic merging will be.

 Well, over time I may get tired of the situation, drop all but usb and
 run apart, but not now.

> >  It has happened before with rtl8139/8139too and others, while the new
> >  driver probes it's merits stability conscious people can still use the
> >  standard driver.
> 
> I don't know what happened to rtl8139/8139too but I think the situation is
> different from your description.  Unless you are going to make more
> development on Orinoco USB than David Gibson does on Orinoco, the Orinoco
> USB is not going to be the development version.  Besides, the drivers
> support different hardware, so there is no choice for users.

 orinoco-exp will support (it already does, though it is not called
 orinoco-exp jet) all the hardware that standard orinoco supports plus
 ORiNOCO USB devices, maybe it could even be extended to support Prism2
 USB devices.

 Actually, orinoco-exp could be used as a test bed for monitor mode,
 scanning, hermesap, ... and merge it back to the standard orinoco as it
 probes to work right. For now it should be a test bed for USB support :)
 
> As far as I know, Orinoco USB devices are quite rare, so the pool of
> testers is going to be small compared to the standard Orinoco driver that
> supports Symbol and Intersil cards as well.

 Not so rare, take a look at the statistics in alioth:

	http://alioth.debian.org/project/showfiles.php?group_id=1245
	http://alioth.debian.org/project/stats/index.php?report=last_30&group_id=1245

 36 Downloads in 24hours, keep in mind that the W200 wireless module is
 the default networking add-on for Compaq Evo series.

 I have around 80 happy subscribers on the orinoco-usb-devel mailing
 list already. And it didn't even get into the kernel jet.

> >  Please comment, how much of that or what else needs to be done to get
> >  it in the kernel?
> 
> If you are going to create a separate driver, you should rename the
> module.  I wouldn't bother with separate modules.  Just link hermes,
> orinoco and orinoco_usb to one driver, say orinoco-usb.

 No, I want to stay as similar to standard orinoco as possible to make
 merging easier.

> You may also need to rename all files if you want the driver to live in
> drivers/net/wireless rather than in drivers/usb/net.
 
 Yes, that was my plan.
 
> That's of course assumes that you want to use separate versions of
> hermes.c and orinoco.c.  But maybe you want to share them with the Orinoco
> driver now or in the future?  Then I'd like to know about your plans.

 For now I plan to duplicate it all, so I can get my code in without
 bothering standard orinoco, but I would like to merge as much as
 possible in the future. I hope that having both versions side by side
 will increase the mind share in finding a good way to do the merge.

 And also get the testing of some adventurous PCI/PCMCIA users.
 
> >  Oh, and since I am at it, I wouldn't mind cleaning kcompat.h for
> >  inclusion in 2.4 kernels to make driver porting easier. I have also
> >  been working in porting lirc so I could put it all together (the
> >  kcompat.h stuff) for 2.4 inclusion.
> 
> That's a separate and very interesting topic.  It's good to encourage
> developers to write for the current development kernel, but on the other
> hand, if kcompat.h is shared between all drivers, changes in it (caused
> by further changes in 2.5.x API) would break drivers in the stable
> kernels.

 Didn't think of that. But 2.5 API should be pretty frozen by now,
 shouldn't it?

> Perhaps backported drivers should not share their compatibility code
> unless there is some kind of coordination between their maintainers.

 But then you duplicate the effort times the number of independent
 drivers. At least there could be a recommended kcompat.h header, even if
 not in the kernel proper, so driver developers can just go get it when
 they are ready to update their drivers, instead of having to updated it
 themselfs. Maybe placing it in the Documentation directory would make
 it clear that it should not be used directly but copied for each driver
 independently.

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
