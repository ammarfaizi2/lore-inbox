Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWBXJab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWBXJab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWBXJab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:30:31 -0500
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:4839 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932160AbWBXJaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:30:30 -0500
Date: Fri, 24 Feb 2006 03:15:36 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] Add Wake on LAN support to sis900 (2)
To: Dave Jones <davej@redhat.com>
Cc: Daniele Venzano <venza@brownhat.org>, Jeff Garzik <jgarzik@pobox.com>,
       John Reiser <jreiser@bitwagon.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602240317_MC3-1-B92E-70BC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060224025759.GA14027@redhat.com>

On Thu, 23 Feb 2006 at 21:57:59 -0500, Dave Jones wrote:
> The patch below applied on Jan 5th causes some systems to no longer boot.
> See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=179601
> for details.
> 
> Thanks go to John Reiser for his debugging with git bisect
> to narrow this one down.
> ...
> > --- a/drivers/net/sis900.c
> > +++ b/drivers/net/sis900.c
> ...
> > @@ -538,6 +539,11 @@ static int __devinit sis900_probe(struct
> >             printk("%2.2x:", (u8)net_dev->dev_addr[i]);
> >     printk("%2.2x.\n", net_dev->dev_addr[i]);
> >  
> > +   /* Detect Wake on Lan support */
> > +   ret = inl(CFGPMC & PMESP);

 What is this?  It appears to be doing 'inl(0)'.

> > +   if (netif_msg_probe(sis_priv) && (ret & PME_D3C) == 0)
> > +           printk(KERN_INFO "%s: Wake on LAN only available from suspend to RAM.", net_dev->name);
> > +
> >     return 0;
> >  
> >   err_unmap_rx:

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

