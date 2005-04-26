Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVDZSLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDZSLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 14:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVDZSLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 14:11:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:18623 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261637AbVDZSLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 14:11:05 -0400
Date: Tue, 26 Apr 2005 22:10:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: johnpol@2ka.mipt.ru
Cc: dtor_core@ameritech.net, dmitry.torokhov@gmail.com, netdev@oss.sgi.com,
       Greg KH <greg@kroah.com>, Jamal Hadi Salim <hadi@cyberus.ca>,
       Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number
 next.
Message-ID: <20050426221026.108f3698@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050426220354.5dd619bf@zanzibar.2ka.mipt.ru>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	<d120d5000504260857cb5f99e@mail.gmail.com>
	<20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
	<d120d50005042610317961a564@mail.gmail.com>
	<20050426220354.5dd619bf@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 26 Apr 2005 22:10:39 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 22:03:54 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> On Tue, 26 Apr 2005 12:31:58 -0500
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > > There may not be the same work with different data.
> > > 
> > 
> > Ugh, that really blows. Now every user of a particular message type
> > has to coordinate efforts with other users of the same message type...
> > 
> > Imability to "fire and forget" undermines usefulness of whole
> > connector. How will you for example implement hotplug notification
> > over connector? Have kobject_hotplug wait and block other instances?
> > But wait on what?
> 
> This is a simple load balancing schema.
> Netlink messages may be dropped in socket queue when 
> they are bing delivered to userspace - this is the same - 
> if work queue can not be scheduled, message will be dropped,
> but in this case userspace also can not be scheduled
> and message will be dropped.

Btw, I belive we see that it is reverse direction...
So we have reverse load balancing schema here - 
exactly like userspace socket queueing.
We basically can not sleep here - it will be DOS.

> > -- 
> > Dmitry
> > 
> 
> 
> 	Evgeniy Polyakov
> 
> Only failure makes us experts. -- Theo de Raadt


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
