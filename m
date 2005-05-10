Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVEJKGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVEJKGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEJKGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:06:41 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:35776 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261606AbVEJKGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:06:23 -0400
Date: Tue, 10 May 2005 14:04:45 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number
 next.
Message-ID: <20050510140445.36cc15cb@zanzibar.2ka.mipt.ru>
In-Reply-To: <200505100118.48027.dtor_core@ameritech.net>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	<200505100118.48027.dtor_core@ameritech.net>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 10 May 2005 14:04:57 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005 01:18:46 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Monday 11 April 2005 07:59, Evgeniy Polyakov wrote:
> > /*****************************************/
> > Kernel Connector.
> > /*****************************************/
> > 
> > Kernel connector - new netlink based userspace <-> kernel space easy to use communication module.
> > 
> 
> Hi Evgeniy,

Hello, Dmitriy.

> I have looked at the connector implementation one more time and I think
> it can be improved in the following ways:
> 
> - drop unneeded refcounting;

It is already.

> - start only one workqueue entry instead of one for every callback type;

There is only one queue per callback device.

> - drop cn_dev - there is only one connector;

There may be several connectors with different socket types.
I use it in my environment for tests.

> - simplify cn_notify_request to carry only one range - it simplifies code
>   quite a bit - nothing stops clientd from sending several notification
>   requests;

? Nothing stops clients from sending several notification requests now.
I do not see how it simplifies the things?
Feel free to set idx_num and val_num to 1 and you will have the same.

> - implement internal queuefor callbacks so we are not at mercy of scheduler;

Current implementation has big warning about such theoretical behaviour, 
if it will be triggered, I will fix that behaviour, 
more likely not by naive work allocation - there might be
at least cache/memory pool or something...

> - admit that SKBs are message medium and do not mess up with passing around
>   destructor functions.

You mess up layers.
I do not see why you want it.

> - In callback notifier switch to using GFP_KERNEL since it can sleep just
>   fine;

Yes, it is correct

> - more... 
> 
> Because there were a lot of changes I decided against doing relative patch
> but instead a replacement patch for affected files. I have cut out cbus and
> documentation to keep it smaller so it will be easier to review. The patch
> is compile-tested only.

Connector with your changes just does not work.


Dmitry, I do not understand why do you change things in so radical manner,
especially when there are no 1. new interesting features, 2. no performance
improvements, 3. no right design changes.

> BTW, I do not think that "All rights reserved" statement is applicable/
> compatible with GPL this software is supposedly released under, I have
> taken liberty of removing this statement.

You substitute license agreements with copyright.
"All rights reserved" is targeted to copyright 
(avtorskoe pravo, zakon N 5351/1-1) of the code
and has nothing with license.


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
