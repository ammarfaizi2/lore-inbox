Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUKRDwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUKRDwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUKRDwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:52:49 -0500
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:7140 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S262391AbUKRDwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:52:46 -0500
Date: Thu, 18 Nov 2004 05:52:45 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: jt@hpl.hp.com
Cc: irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ambx1@neo.rr.com
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
Message-ID: <20041118035245.GA24395@sci.fi>
Mail-Followup-To: jt@hpl.hp.com, irda-users@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, ambx1@neo.rr.com
References: <20041117232047.GA28061@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041117232047.GA28061@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 03:20:47PM -0800, Jean Tourrilhes wrote:
> Ville wrote :
> > Add PnP support to smsc-ircc2 driver.
> > Briefly tested with irdadump on a Dell Inpsiron 7000.
> 
> 	Thanks for the patch. I slightly moved you code around, you'll
> find my version of your patch on my web page.
> 
> 	Now, a few comments...
> 
> 	1) I don't have any SmSC chipset around, so I can't do any
> testing. I would appreciate other people to test your patch. Also,
> make sure I did not introduce mistakes in my version of the patch.

Your version works fine (irdadump works).

> 	2) I tried to apply the same code to NSC. It did not manage to
> read the ressource properly, and therefore the PnP code disabled the
> hardware, and I was no longer able to get it running (short of a
> reboot of the computer). The nsc-ircc has only one i/o region (dumb
> nsc).

I have a machine with nsc-ircc here so I think I'll try that too.

> 	The issue there is that if a smsc chipset has a valid PnP ID
> but somehow the pnp_probe fails to set it up, then the regular probe
> won't be able to configure it. This makes me nervous.
> 
> 	3) If the ressources are markes as disabled, you just quit
> with an error. Compouded with (2), this makes me doubly
> nervous. Wouldn't it be possible to forcefully enable those ressources ?
> 	The idea there is that more and more IrDA devices are comming
> disabled in BIOS with no BIOS entry to enable them. Enabling those
> ressources would fix that and possible make smc-init redundant (I wish).

pnp_activate_dev() should probably be used to enable the device but it was
only used by ISAPNP drivers so I didn't use it in this patch.

I must admit that I really don't know much about the PNP subsystem. I 
used the parport_pc driver as a guide. I've CC'd Adam Belay and 
linux-kernel in the hopes that someone can help with this stuff.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
