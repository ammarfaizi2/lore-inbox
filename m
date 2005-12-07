Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVLGHLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVLGHLj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 02:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbVLGHLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 02:11:39 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:41663 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1030324AbVLGHLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 02:11:38 -0500
Date: Tue, 6 Dec 2005 23:11:02 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Jiri Benc <jbenc@suse.cz>, netdev@vger.kernel.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Michael Renzmann <netdev@nospam.otaku42.de>,
       Pavel Machek <pavel@suse.cz>, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051207071102.GC8953@jm.kir.nu>
References: <20051206224728.GA31894@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206224728.GA31894@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 02:47:28PM -0800, Jean Tourrilhes wrote:

> DeviceScape stack :
> 	drivers using it : ?
> 	potential drivers : hostap, ipw2100, ipw2200, r8180, adm8211

It's mainly used with Atheros chipsets nowadays, but it has been used
with couple of other chipsets, too, including Prism2/2.5/3 and parts of
Host AP driver.

> 	If you want to use the DeviceScape stack instead of the IPW
> stack, my first question is how do you plan to migrate the drivers
> using it to the new stack. Currently, people are hard at work
> targetting the IPW stack (see above), I don't want them to have to
> throw away all their work.

No matter how this is done, I think it is quite likely that lot of work
has to be thrown away in the sense that it does not end up being in the
kernel. Having n+1 implementations for generic 802.11 functionality is a
good proof of this already being the case. I wouldn't say all work is
thrown away, though, even if lots of code will get thrown away. It is
good to get understanding on what kind of specific requirements each
chipset has in order to be able to accommodate them in the 802.11 design
for Linux.

> 	In particular, iwp2*00 are working today in the kernel, and I
> expect that they would be migrated to the new stack at the stack
> switchover. As both the IPW and the DeviceScape stacks are derived
> from the HostAP stack, that should not be too hard.

Devicescape code is not actually derived from Host AP code. The user
space component is same (hostapd), but the kernel side is completely new
implementation. As far as IPW is concerned, some parts of it is indeed
derived from Host AP (I can never remember which one, but either TX or
RX; while the other side was new design for some reason).

> 	Also, what puzzle me is that Jouni doesn't seem to have
> anounced any plan to port his HostAP driver to his DeviceScape
> stack. If there is one driver that should use it, that's HostAP.

Prism2/2.5/3 is getting somewhat old nowadays and I certainly prefer
other chipset designs that do not have a large firmware component
preventing driver/802.11 stack from doing things. Anyway, I have
actually used Devicescape code with Prism2/2.5/3 cards by taking the
low-level parts of the Host AP driver. This just happened to be
two-three years ago and that code has found no use after that, so it has
not been maintained.

I would certainly like to get rid of maintaining many parts of Host AP
driver by getting it to use shared IEEE 802.11 code. I have been quite
occupied with other projects lately which has made it more difficult to
get much progress done here. Anyway, the current goal is to free up my
time by end of this year so that I could start concentrating on the open
source IEEE 802.11 stack for Linux 2.6.

One of the things I would like to do is to make sure that there is
somewhat more complete setup available for testing the Devicescape code
as part of open source development. I'm most familiar with Atheros
chipset nowadays, so I would probably prefer to work with that and maybe
Prism2 (i.e., support from Host AP driver) would be a good example of a
firmware-based design, so those could be the easiest low-level drivers
to get available using Devicescape 802.11 code. Getting ipw2x00 working
with some kind of mix of the 802.11 stacks would be good think to do in
order to make it easier to maintain existing functionality if larger
changes for net/ieee80211 code is desired.

My goal is to get something into kernel tree that allows all types of
chipset designs to benefit from the same implementation of 802.11
functionality. I'm not sure what would be the best way to achieve this
quickly, but I have to admit that I would prefer the design used in
Devicescape implementation over the code that is currently in Linux 2.6
tree.

I need to take a closer look at what could be done to merge the 802.11
code in a way that would not break existing in-tree drivers that are
using net/ieee80211 (i.e., mainly ipw2x00). I'm afraid quite large
changes will be needed to make the current in-tree code more usable for
devices that use very minimal firmware or no firmware at all. In
addition, the issue of dropping AP code from Host AP when merging in the
version that ipw2x00 was using needs more attention when deciding what
kind of design would allow all drivers to work with shared IEEE 802.11
stack.

-- 
Jouni Malinen                                            PGP id EFC895FA
