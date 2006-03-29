Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWC2O13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWC2O13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWC2O12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:27:28 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:14051 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1750746AbWC2O12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:27:28 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603291427.k2TEREE7001642@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: klassert@mathematik.tu-chemnitz.de (Steffen Klassert)
Date: Wed, 29 Mar 2006 09:27:14 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements),
       klassert@mathematik.tu-chemnitz.de (Steffen Klassert),
       linux-kernel@vger.kernel.org (linux-kernel),
       akpm@osdl.org (Andrew Morton)
In-Reply-To: <20060329114751.GA8629@bayes.mathematik.tu-chemnitz.de>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch gives me the network back (applied to git16).
Timeout problem remains, trying Andrews patches.

  > >   > > FYI:
  > >   > >   Single 3c900 card, UP i386
  > >   > >   Lost networking with .16-git12, message
  > >   > >   ADDRCONF(NETDEV_UP): eth0: link is not ready
  > >   > 
  > >   > This could be due to the recent driver update.
  > >   > I can not reproduce this with a 3c900B-Combo,
  > >   > so I need some more information to track it down.
  > > 
  > > Data attached. Note:
  > >  1) Using coax 10base2.
  > 
  > Somehow 10base2 does not like a netif_carrier_off.
  > 
  > Please try the pach below. It makes 10base2 work again for me.
  > 
  > Steffen
  > 
  > --- linux-2.6.16-git12/drivers/net/3c59x.c	2006-03-29 11:23:48.000000000 +0200
  > +++ linux-2.6.16-git12-sk/drivers/net/3c59x.c	2006-03-29 13:40:28.000000000 +0200
  > @@ -1723,7 +1723,6 @@
  >  		printk(KERN_DEBUG "vortex_up(): writing 0x%x to InternalConfig\n", config);
  >  	iowrite32(config, ioaddr + Wn3_Config);
  >  
  > -	netif_carrier_off(dev);
  >  	if (dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
  >  		EL3WINDOW(4);
  >  		vortex_check_media(dev, 1);
  > 


-- 
Pete Clements 
