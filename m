Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263878AbUDPVwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263863AbUDPVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:50:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35712 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263772AbUDPVtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:49:14 -0400
Message-ID: <408054C9.5070202@pobox.com>
Date: Fri, 16 Apr 2004 17:48:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: baycom_par dereference before check.
References: <20040416212004.GO20937@redhat.com> <20040416212541.GH24997@parcelfarce.linux.theplanet.co.uk> <20040416212738.GQ20937@redhat.com>
In-Reply-To: <20040416212738.GQ20937@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Apr 16, 2004 at 10:25:41PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
>  > > +++ linux-2.6.5/drivers/net/hamradio/baycom_par.c	2004-04-16 22:19:33.000000000 +0100
>  > > @@ -272,9 +272,13 @@
>  > >  static void par96_interrupt(int irq, void *dev_id, struct pt_regs *regs)
>  > >  {
>  > >  	struct net_device *dev = (struct net_device *)dev_id;
>  > > -	struct baycom_state *bc = netdev_priv(dev);
>  > > +	struct baycom_state *bc;
>  > >  
>  > > -	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
>  > > +	if (!dev)
>  > > +		return;
>  > > +
>  > > +	bc = netdev_priv(dev);
>  > 
>  > That's OK - netdev_priv(p) just adds a constant offset to p; no problem
>  > with doing that to NULL.
> 
> Good point. Still doesn't strike me as particularly nice though.


I would rather just remove the checks completely.  The success of any of 
those checks is a BUG() condition that should never occur.

	Jeff



