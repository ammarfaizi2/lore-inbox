Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVDJMQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVDJMQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 08:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVDJMQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 08:16:41 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:48287 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261484AbVDJMQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 08:16:39 -0400
Date: Sun, 10 Apr 2005 16:15:49 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Thomas Graf <tgraf@suug.ch>
Cc: Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, jmorris@redhat.com,
       ijc@hellion.org.uk, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@oss.sgi.com,
       jamal <hadi@cyberus.ca>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050410161549.3abe4778@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050410121005.GF26731@postel.suug.ch>
References: <1112942924.28858.234.camel@uganda>
	<E1DKZ7e-00070D-00@gondolin.me.apana.org.au>
	<20050410143205.18bff80d@zanzibar.2ka.mipt.ru>
	<1113131325.6994.66.camel@localhost.localdomain>
	<20050410153757.104fe611@zanzibar.2ka.mipt.ru>
	<20050410121005.GF26731@postel.suug.ch>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Sun, 10 Apr 2005 16:15:50 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005 14:10:05 +0200
Thomas Graf <tgraf@suug.ch> wrote:

> * Evgeniy Polyakov <20050410153757.104fe611@zanzibar.2ka.mipt.ru> 2005-04-10 15:37
> > --- ./net/netlink/af_netlink.c.orig     2005-04-10 15:46:48.000000000 +0400
> > +++ ./net/netlink/af_netlink.c  2005-04-10 15:47:04.000000000 +0400
> > @@ -747,7 +747,7 @@
> >         if (p->exclude_sk == sk)
> >                 goto out;
> >  
> > -       if (nlk->pid == p->pid || !(nlk->groups & p->group))
> > +       if (nlk->pid == p->pid || (nlk->groups != p->group))
> >                 goto out;
> >  
> >         if (p->failure) {
> 
> Not valid, would break RTMGRP_*.

Yes, it will break too many existing application, 
it would be new API, like do_one_broadcast_direct().
If I understand Kay right, it is what he needs
for the new multicast.

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
