Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUDPVaT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbUDPV3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:29:51 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:29343 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263827AbUDPV3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:29:16 -0400
Date: Fri, 16 Apr 2004 22:27:38 +0100
From: Dave Jones <davej@redhat.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: jgarzik@pobox.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: baycom_par dereference before check.
Message-ID: <20040416212738.GQ20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	viro@parcelfarce.linux.theplanet.co.uk, jgarzik@pobox.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040416212004.GO20937@redhat.com> <20040416212541.GH24997@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416212541.GH24997@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:25:41PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

 > > +++ linux-2.6.5/drivers/net/hamradio/baycom_par.c	2004-04-16 22:19:33.000000000 +0100
 > > @@ -272,9 +272,13 @@
 > >  static void par96_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 > >  {
 > >  	struct net_device *dev = (struct net_device *)dev_id;
 > > -	struct baycom_state *bc = netdev_priv(dev);
 > > +	struct baycom_state *bc;
 > >  
 > > -	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
 > > +	if (!dev)
 > > +		return;
 > > +
 > > +	bc = netdev_priv(dev);
 > 
 > That's OK - netdev_priv(p) just adds a constant offset to p; no problem
 > with doing that to NULL.

Good point. Still doesn't strike me as particularly nice though.

		Dave

