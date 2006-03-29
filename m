Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWC2Lrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWC2Lrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 06:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWC2Lrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 06:47:53 -0500
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:61894 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1750756AbWC2Lrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 06:47:52 -0500
Date: Wed, 29 Mar 2006 13:47:51 +0200
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
Message-ID: <20060329114751.GA8629@bayes.mathematik.tu-chemnitz.de>
Mail-Followup-To: Pete Clements <clem@clem.clem-digital.net>,
	Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060328141443.GB8455@gareth.mathematik.tu-chemnitz.de> <200603281644.k2SGish7001726@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603281644.k2SGish7001726@clem.clem-digital.net>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.1 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 2da4cb75faf7b3f12212370ffd4cc0ae
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 11:44:54AM -0500, Pete Clements wrote:
> Quoting Steffen Klassert
>   > > 
>   > > FYI:
>   > >   Single 3c900 card, UP i386
>   > >   Lost networking with .16-git12, message
>   > >   ADDRCONF(NETDEV_UP): eth0: link is not ready
>   > 
>   > This could be due to the recent driver update.
>   > I can not reproduce this with a 3c900B-Combo,
>   > so I need some more information to track it down.
> 
> Data attached. Note:
>  1) Using coax 10base2.

Somehow 10base2 does not like a netif_carrier_off.

Please try the pach below. It makes 10base2 work again for me.

Steffen

--- linux-2.6.16-git12/drivers/net/3c59x.c	2006-03-29 11:23:48.000000000 +0200
+++ linux-2.6.16-git12-sk/drivers/net/3c59x.c	2006-03-29 13:40:28.000000000 +0200
@@ -1723,7 +1723,6 @@
 		printk(KERN_DEBUG "vortex_up(): writing 0x%x to InternalConfig\n", config);
 	iowrite32(config, ioaddr + Wn3_Config);
 
-	netif_carrier_off(dev);
 	if (dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
 		EL3WINDOW(4);
 		vortex_check_media(dev, 1);

