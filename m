Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVIVCqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVIVCqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVIVCqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:46:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965222AbVIVCqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:46:07 -0400
Date: Wed, 21 Sep 2005 19:42:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: fmalita@gmail.com, linux-kernel@vger.kernel.org,
       ctindel@users.sourceforge.net, fubar@us.ibm.com, davem@davemloft.net,
       netdev@vger.kernel.org
Subject: Re: [PATCH] bond_main.c: fix device deregistration in init
 exception path
Message-Id: <20050921194205.309695a7.akpm@osdl.org>
In-Reply-To: <43321922.70707@pobox.com>
References: <432D0612.7070408@gmail.com>
	<20050917233224.2d4b3652.akpm@osdl.org>
	<43321922.70707@pobox.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > diff -puN drivers/net/bonding/bond_main.c~bond_mainc-fix-device-deregistration-in-init-exception drivers/net/bonding/bond_main.c
> > --- devel/drivers/net/bonding/bond_main.c~bond_mainc-fix-device-deregistration-in-init-exception	2005-09-17 23:18:38.000000000 -0700
> > +++ devel-akpm/drivers/net/bonding/bond_main.c	2005-09-17 23:31:02.000000000 -0700
> > @@ -5039,6 +5039,14 @@ static int __init bonding_init(void)
> >  	return 0;
> >  
> >  out_err:
> > +	/*
> > +	 * rtnl_unlock() will run netdev_run_todo(), putting the
> > +	 * thus-far-registered bonding devices into a state which
> > +	 * unregigister_netdevice() will accept
> > +	 */
> > +	rtnl_unlock();
> > +	rtnl_lock();
> > +
> 
> 
> Don't we want a schedule() or schedule_timeout(1) in between?
> 

No, it's all synchronous.  See the nice comment ;)
