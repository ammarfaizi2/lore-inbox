Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTEHTUM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTEHTUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:20:12 -0400
Received: from palrel12.hp.com ([156.153.255.237]:54253 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261969AbTEHTUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:20:11 -0400
Date: Thu, 8 May 2003 12:32:45 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: The magical mystical changing ethernet interface order
Message-ID: <20030508193245.GA26721@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote :
> 
> Does anyone know if there's a reason that the ethernet driver initialisation
> order has changed again in 2.5?
>
> Its rather annoying when your dhcpd starts on the wrong interface.

David S. Miller wrote
> Any reliance on link ordering is broken and needs to be fixed.

	I fully agree with David, this problem goes beyond the link
order.
	Since 97, I've been figthing this issue with my laptop. I've
got various Pcmcia card (Ethernet and Wireless), as well as PCI and
ISA Ethernet cards in the docking station. Depending on which
configuration the laptop is started in, eth0 could be any Pcmcia card
or any ISA/PCI card in the docking station.
	With USB in the picture, things are even more dynamic. And no
careful kernel link order mechanism will ensure that eth0 is the same
device.
	So, let's get rid of the link order "fix", because this
address only a small subset of the problem. Let's fix the real problem
which is that eth0 can't map any specific hardware device, and the
device name is totally arbitrary and meaningless.

Randy.Dunlap wrote :
> An alternative is to use 'nameif' to associate MAC addresses with
> interface names.  See here for mini HOWTO:
> 
>   http://www.xenotime.net/linux/doc/network-interface-names.txt

	Currently this feels like a kludge, because not fully
inegrated, but goes in the right direction.
	Actually, it's pretty funny that the original Pcmcia package
got it right since the beggining (and Win2k as well), but
distributions took a step backward from that when integrating Pcmcia.
	My belief is that configuration scripts should be specified in
term of MAC address (or subset) and not in term of device name. Just
like the Pcmcia scripts are doing it.
	And let's go the extra mile : ifconfig should accept a MAC
address as the argument instead of a device name. And in the long
term, just get rid of device name from the user view.

	Have fun...

	Jean

