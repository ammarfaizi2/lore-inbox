Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUG2Tmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUG2Tmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUG2Tmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:42:44 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:42455 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264973AbUG2Tmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:42:38 -0400
Subject: Re: Integrated ethernet on SiS chipset doesn't work
From: Jean Francois Martinez <jfm512@free.fr>
To: Daniele Venzano <webvenza@libero.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040711101608.GB10738@picchio.gall.it>
References: <1089480939.2779.22.camel@agnes>
	 <Pine.LNX.4.53.0407102141560.5590@chaos> <1089538014.4690.32.camel@agnes>
	 <20040711101608.GB10738@picchio.gall.it>
Content-Type: multipart/mixed; boundary="=-Q4W277ACAS6CpwDcoygk"
Message-Id: <1091130156.2912.17.camel@agnes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 21:42:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q4W277ACAS6CpwDcoygk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few weeks ago I reported a problem with the Sis driver but the
poerson who owns the machine was out of town 


Le dim 11/07/2004 à 12:16, Daniele Venzano a écrit :
> On Sun, Jul 11, 2004 at 11:26:54AM +0200, Jean Francois Martinez wrote:
> > 2) The Sis 900 driver is supposed to be _supported_ ie someone is being
> > paid for fixing problems.  It has the highest maintenance status so
> > its problems are made to be fixed.
> The email listed in the MAINTAINERS file bounces, so the driver is not
> supported so well, I'm acting as maintainer, but no one is paying me.
> 
> The sis900 driver driver works in most cases, I am aware of some issues,
> mostly caused by new hardware not known by the driver. These problems,
> however, cause slowdowns, but the card is always detected.
> 
> So before saying anything let's wait for the poster's dmesg.
> 

Here is the interesting part of his dmesg, after reloading the
sis900 driver.  We can see that the card
indentifies a VIA transceiver at address 1 but instead uses the 
(inexistent) one at address 31.

When we look at the sis_default_phy function we notice that there is
a loop on the transceivers and that the first one to answer and have
a link will be selected.  If none answers then we end with the one
at address 31 (despite the varibale being named first_mii) and that
is what is probably happened.

The code looks quite absurd because it continues to loop after finding
an eligible transceiver despite the fact that transceivers with
higher addresses are uneligible to be selected as default.

Now the question is why the VIA transceiver is not answering the probe
or is reporting it has no link  despite having one.
 
---

		Jean Francois Martinez

--=-Q4W277ACAS6CpwDcoygk
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000005 00000000 
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000005 00000000 
sis900.c: v1.08.06 9/24/2002
eth0: Unknown PHY transceiver found at address 0.
eth0: VIA 6103 PHY transceiver found at address 1.
eth0: Unknown PHY transceiver found at address 2.
eth0: Unknown PHY transceiver found at address 3.
eth0: Unknown PHY transceiver found at address 4.
eth0: Unknown PHY transceiver found at address 5.
eth0: Unknown PHY transceiver found at address 6.
eth0: Unknown PHY transceiver found at address 7.
eth0: Unknown PHY transceiver found at address 8.
eth0: Unknown PHY transceiver found at address 9.
eth0: Unknown PHY transceiver found at address 10.
eth0: Unknown PHY transceiver found at address 11.
eth0: Unknown PHY transceiver found at address 12.
eth0: Unknown PHY transceiver found at address 13.
eth0: Unknown PHY transceiver found at address 14.
eth0: Unknown PHY transceiver found at address 15.
eth0: Unknown PHY transceiver found at address 16.
eth0: Unknown PHY transceiver found at address 17.
eth0: Unknown PHY transceiver found at address 18.
eth0: Unknown PHY transceiver found at address 19.
eth0: Unknown PHY transceiver found at address 20.
eth0: Unknown PHY transceiver found at address 21.
eth0: Unknown PHY transceiver found at address 22.
eth0: Unknown PHY transceiver found at address 23.
eth0: Unknown PHY transceiver found at address 24.
eth0: Unknown PHY transceiver found at address 25.
eth0: Unknown PHY transceiver found at address 26.
eth0: Unknown PHY transceiver found at address 27.
eth0: Unknown PHY transceiver found at address 28.
eth0: Unknown PHY transceiver found at address 29.
eth0: Unknown PHY transceiver found at address 30.
eth0: Unknown PHY transceiver found at address 31.
eth0: Using transceiver found at address 31 as default
eth0: SiS 900 PCI Fast Ethernet at 0xe800, IRQ 11, 00:0c:76:68:a9:89.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000005 00000000 

--=-Q4W277ACAS6CpwDcoygk--

