Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWEAJbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWEAJbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWEAJbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:31:46 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:32942 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750819AbWEAJbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:31:45 -0400
Subject: Re: IP1000 gigabit nic driver
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: David Vrabel <dvrabel@cantab.net>
Cc: romieu@fr.zoreil.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
In-Reply-To: <44554ADE.8030200@cantab.net>
References: <20060427142939.GA31473@fargo>
	 <20060427185627.GA30871@electric-eye.fr.zoreil.com>
	 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>
	 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
	 <20060428113755.GA7419@fargo>
	 <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
	 <1146306567.1642.3.camel@localhost>  <20060429122119.GA22160@fargo>
	 <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost>
	 <44554ADE.8030200@cantab.net>
Date: Mon, 01 May 2006 12:31:40 +0300
Message-Id: <1146475901.11271.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 00:40 +0100, David Vrabel wrote:
> Thanks for doing this Pekka.  I've fixed up some stuff and given it some 
> brief testing on a 100BaseT network and it seems to work now.

Thanks! I merged your stuff and pushed out an updated patch.

				Pekka

[PATCH] IP1000 Gigabit Ethernet device driver

This is a cleaned up fork of the IP1000A device driver:

  http://www.icplus.com.tw/driver-pp-IP1000A.html

Open issues:

  - ipg_probe() looks really fishy and doesn't handle all errors
    (e.g. ioremap failing).
  - ipg_nic_do_ioctl() is playing games with user-space pointer.
    We should use ethtool ioctl instead as suggested by Arjan.
  - something (PHY reset/auto negotiation?) takes 2-3 seconds and
    appears to be done with interrupts disabled.

Changelog:

  - Kill 2.2 and 2.4 compatability macros
  - Use proper module API
  - Use proper PCI API
  - Use netdev_priv
  - Consolidate headers to one file
  - Use __iomem annotations
  - Use iomap instead of read/out for I/O
  - Remove obfuscating register access macros
  - Remove changelogs
  - Remove ether_crc_le() -- use crc32_le() instead.
  - No more nonsense with root_dev -- ipg_remove() now works.
  - Move PHY and MAC address initialization into the ipg_probe().  It was
    previously filling in the MAC address on open which breaks some user
    space.
  - Folded ipg_nic_init into ipg_probe since it was broke otherwise.

I don't have the hardware, so I don't know if I broke anything.
The patch is 128 KB in size, so I am not including it in this
mail. You can find the patch here:

  http://www.cs.helsinki.fi/u/penberg/linux/ip1000-driver.patch

Signed-off-by: David Vrabel <dvrabel@cantab.net>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

