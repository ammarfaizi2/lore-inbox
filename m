Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVDZSg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDZSg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 14:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVDZSg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 14:36:29 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:27076 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261417AbVDZSgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 14:36:25 -0400
Date: Tue, 26 Apr 2005 22:35:38 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number
 next.
Message-ID: <20050426223538.5f396691@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d500050426112578940fea@mail.gmail.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	<d120d5000504260857cb5f99e@mail.gmail.com>
	<20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
	<d120d50005042610317961a564@mail.gmail.com>
	<20050426220354.5dd619bf@zanzibar.2ka.mipt.ru>
	<20050426221026.108f3698@zanzibar.2ka.mipt.ru>
	<20050426221325.20fbba58@zanzibar.2ka.mipt.ru>
	<d120d500050426112578940fea@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 26 Apr 2005 22:35:51 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 13:25:50 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Tue, 26 Apr 2005 22:10:26 +0400
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > > > > > There may not be the same work with different data.
> > > > > >
> > > > >
> > > > > Ugh, that really blows. Now every user of a particular message type
> > > > > has to coordinate efforts with other users of the same message type...
> > > > >
> > > > > Imability to "fire and forget" undermines usefulness of whole
> > > > > connector. How will you for example implement hotplug notification
> > > > > over connector? Have kobject_hotplug wait and block other instances?
> > > > > But wait on what?
> > > >
> > > > This is a simple load balancing schema.
> > > > Netlink messages may be dropped in socket queue when
> > > > they are bing delivered to userspace - this is the same -
> > > > if work queue can not be scheduled, message will be dropped,
> > > > but in this case userspace also can not be scheduled
> > > > and message will be dropped.
> > >
> > > Btw, I belive we see that it is reverse direction...
> > > So we have reverse load balancing schema here -
> > > exactly like userspace socket queueing.
> > > We basically can not sleep here - it will be DOS.
> > 
> > And yet another btw - netlink is unreliable protocol,
> > that is why there are seq and ack fields in connector's header -
> > connector's users must implement some check on top of
> > raw connector messages - it could be returned message with
> > timeout resending and so on.
> > I wrote it several times and it is in connector's documentation.
> > 
> 
> I can accept that netlink is unreliable protocol and can drop messages
> - but that should only happen when there is memory pressure. In your
> case you simply can not send messages with frequency higher than your
> timeslice unless you implement synchronous protocol.
> 
> Load balancing allows bursts as long as average rate is under control
> - connector does not.

It happens not only when there is memory pressure,
but also when remote side does not read it's messages.
If system can not schedule work queue, then
it is the same situation. 
And, btw, if system under so strong pressure than 
work queue can not be scheduled, then no skb will be delivered
to/from userspace too.

> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
