Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263838AbUDPXIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbUDPXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:08:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:20965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263838AbUDPXIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:08:00 -0400
Date: Fri, 16 Apr 2004 16:07:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: baycom_par dereference before check.
Message-ID: <20040416160759.D22989@build.pdx.osdl.net>
References: <20040416212004.GO20937@redhat.com> <20040416212541.GH24997@parcelfarce.linux.theplanet.co.uk> <20040416212738.GQ20937@redhat.com> <408054C9.5070202@pobox.com> <20040416215319.GW20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040416215319.GW20937@redhat.com>; from davej@redhat.com on Fri, Apr 16, 2004 at 10:53:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> On Fri, Apr 16, 2004 at 05:48:57PM -0400, Jeff Garzik wrote:
>  > >Good point. Still doesn't strike me as particularly nice though.
>  > I would rather just remove the checks completely.  The success of any of 
>  > those checks is a BUG() condition that should never occur.
> 
> That works for me too. How about this?
> 
> 		Dave
> 
> --- linux-2.6.5/drivers/net/hamradio/baycom_par.c~	2004-04-16 22:52:35.000000000 +0100
> +++ linux-2.6.5/drivers/net/hamradio/baycom_par.c	2004-04-16 22:52:53.000000000 +0100
> @@ -274,8 +274,8 @@
>  	struct net_device *dev = (struct net_device *)dev_id;
>  	struct baycom_state *bc = netdev_priv(dev);
>  
> -	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
> -		return;
> +	BUG_ON(!bc);

If it's adding a constant offset to dev, the bc would be non-NULL in a bug
case, no?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
