Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTFZVtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTFZVtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:49:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:39649 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262930AbTFZVtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:49:14 -0400
Date: Thu, 26 Jun 2003 18:03:23 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Manuel Estrada Sainz <ranty@debian.org>
cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
       orinoco-devel@lists.sourceforge.net, jt@hpl.hp.com
Subject: Re: [Orinoco-devel] orinoco_usb Request For Comments
In-Reply-To: <20030626205811.GA25783@ranty.pantax.net>
Message-ID: <Pine.LNX.4.56.0306261734230.3732@marabou.research.att.com>
References: <20030626205811.GA25783@ranty.pantax.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003, Manuel Estrada Sainz wrote:

>  I now believe that it is stable enough for the kernel, and I would like
>  to get it integrated in the official kernel tree.
>
>  At first I tried convincing David to accept the changes in the standard
>  orinoco driver but he was (rightfully) skeptic. Then Jean Tourrilhes
>  opened my eyes, the changes touch carefully crafted locking semantics
>  and could give trouble (although it has been working well for quite a
>  while), and suggested adding it as an independent (alternative) driver.

I think it's a reasonable request.  It's a pity that the future work on
the Orinoco driver won't be integrated into your driver automatically.  In
particular, scanning, monitor mode and switching to the separate wireless
handlers may be useful for the USB driver as well.

But indeed, Orinoco USB is very different from other Orinoco cards.  There
is a firmware that stands between the driver and the PCMCIA card, and that
firmware is less transparent than, say, PLX bridges.

It's a tough call, and it's up to you to make.

>  It has happened before with rtl8139/8139too and others, while the new
>  driver probes it's merits stability conscious people can still use the
>  standard driver.

I don't know what happened to rtl8139/8139too but I think the situation is
different from your description.  Unless you are going to make more
development on Orinoco USB than David Gibson does on Orinoco, the Orinoco
USB is not going to be the development version.  Besides, the drivers
support different hardware, so there is no choice for users.

As far as I know, Orinoco USB devices are quite rare, so the pool of
testers is going to be small compared to the standard Orinoco driver that
supports Symbol and Intersil cards as well.

>  Please comment, how much of that or what else needs to be done to get
>  it in the kernel?

If you are going to create a separate driver, you should rename the
module.  I wouldn't bother with separate modules.  Just link hermes,
orinoco and orinoco_usb to one driver, say orinoco-usb.

You may also need to rename all files if you want the driver to live in
drivers/net/wireless rather than in drivers/usb/net.

That's of course assumes that you want to use separate versions of
hermes.c and orinoco.c.  But maybe you want to share them with the Orinoco
driver now or in the future?  Then I'd like to know about your plans.

>  Oh, and since I am at it, I wouldn't mind cleaning kcompat.h for
>  inclusion in 2.4 kernels to make driver porting easier. I have also
>  been working in porting lirc so I could put it all together (the
>  kcompat.h stuff) for 2.4 inclusion.

That's a separate and very interesting topic.  It's good to encourage
developers to write for the current development kernel, but on the other
hand, if kcompat.h is shared between all drivers, changes in it (caused
by further changes in 2.5.x API) would break drivers in the stable
kernels.

Perhaps backported drivers should not share their compatibility code
unless there is some kind of coordination between their maintainers.

-- 
Regards,
Pavel Roskin
