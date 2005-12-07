Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbVLGTRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbVLGTRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbVLGTRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:17:11 -0500
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:64432 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S964897AbVLGTRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:17:09 -0500
Date: Wed, 7 Dec 2005 11:16:22 -0800
To: Jouni Malinen <jkmaline@cc.hut.fi>
Cc: Jiri Benc <jbenc@suse.cz>, netdev@vger.kernel.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Michael Renzmann <netdev@nospam.otaku42.de>,
       Pavel Machek <pavel@suse.cz>, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051207191622.GB1913@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20051206224728.GA31894@bougret.hpl.hp.com> <20051207071102.GC8953@jm.kir.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207071102.GC8953@jm.kir.nu>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 11:11:02PM -0800, Jouni Malinen wrote:
> On Tue, Dec 06, 2005 at 02:47:28PM -0800, Jean Tourrilhes wrote:
> 
> > DeviceScape stack :
> > 	drivers using it : ?
> > 	potential drivers : hostap, ipw2100, ipw2200, r8180, adm8211
> 
> It's mainly used with Atheros chipsets nowadays, but it has been used
> with couple of other chipsets, too, including Prism2/2.5/3 and parts of
> Host AP driver.


	Well, the burning question is : Is it possible to include your
Atheros driver in the Linux kernel ? Meaning, will it be released, and
will it contain a binary blob ?
	If we can't put it in the kernel, it does not bring any thing
new comapre to MadWifi.

> > 	If you want to use the DeviceScape stack instead of the IPW
> > stack, my first question is how do you plan to migrate the drivers
> > using it to the new stack. Currently, people are hard at work
> > targetting the IPW stack (see above), I don't want them to have to
> > throw away all their work.
> 
> No matter how this is done, I think it is quite likely that lot of work
> has to be thrown away in the sense that it does not end up being in the
> kernel. Having n+1 implementations for generic 802.11 functionality is a
> good proof of this already being the case. I wouldn't say all work is
> thrown away, though, even if lots of code will get thrown away. It is
> good to get understanding on what kind of specific requirements each
> chipset has in order to be able to accommodate them in the 802.11 design
> for Linux.

	Precisely, which is why I've been pushing as many driver as I
can in the kernel, so that the need is clear and obvious.

> Devicescape code is not actually derived from Host AP code. The user
> space component is same (hostapd), but the kernel side is completely new
> implementation. As far as IPW is concerned, some parts of it is indeed
> derived from Host AP (I can never remember which one, but either TX or
> RX; while the other side was new design for some reason).

	Not cool. I usually don't like wrapper, but would it be
possible to wrap the IPW API around DeviceScape ?

> > 	Also, what puzzle me is that Jouni doesn't seem to have
> > anounced any plan to port his HostAP driver to his DeviceScape
> > stack. If there is one driver that should use it, that's HostAP.
> 
> Prism2/2.5/3 is getting somewhat old nowadays and I certainly prefer
> other chipset designs that do not have a large firmware component
> preventing driver/802.11 stack from doing things. Anyway, I have
> actually used Devicescape code with Prism2/2.5/3 cards by taking the
> low-level parts of the Host AP driver. This just happened to be
> two-three years ago and that code has found no use after that, so it has
> not been maintained.

	It's old, but because it's the only current card properly
supported under Linux, most people are still using it. And you have
many original Prism2 designs that you can't find with other chipset,
such as the high power version and the CF cards.

> I need to take a closer look at what could be done to merge the 802.11
> code in a way that would not break existing in-tree drivers that are
> using net/ieee80211 (i.e., mainly ipw2x00). I'm afraid quite large
> changes will be needed to make the current in-tree code more usable for
> devices that use very minimal firmware or no firmware at all. In
> addition, the issue of dropping AP code from Host AP when merging in the
> version that ipw2x00 was using needs more attention when deciding what
> kind of design would allow all drivers to work with shared IEEE 802.11
> stack.

	Well, the problem is that the more we wait, the more people
are going in other directions. Driver authors are voting with their
feets. I personally welcome your contribution, and I must admit I
don't really know what is the best course of action.

> Jouni Malinen

	Jean
