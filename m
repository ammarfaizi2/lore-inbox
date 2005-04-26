Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVDZS0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVDZS0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 14:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDZS0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 14:26:03 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:36798 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261598AbVDZSZy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 14:25:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BiHbGgnfAdCvYoMgVQi86hfQEkL8ny9NF4vqwANz7Rc/RImobm6COE2wP84cqQ75hsN/OvBaCc0NTX1sAPiEIWql/PM935VH7ZkMP9eOp61Z6P2Ww7MprN4B2V2ay1ERCXWYIdJrw1I5TxSX4ZHmjotP1qhC16ctNgbM3ZrHt+A=
Message-ID: <d120d500050426112578940fea@mail.gmail.com>
Date: Tue, 26 Apr 2005 13:25:50 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050426221325.20fbba58@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <d120d5000504260857cb5f99e@mail.gmail.com>
	 <20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
	 <d120d50005042610317961a564@mail.gmail.com>
	 <20050426220354.5dd619bf@zanzibar.2ka.mipt.ru>
	 <20050426221026.108f3698@zanzibar.2ka.mipt.ru>
	 <20050426221325.20fbba58@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Tue, 26 Apr 2005 22:10:26 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > > > > There may not be the same work with different data.
> > > > >
> > > >
> > > > Ugh, that really blows. Now every user of a particular message type
> > > > has to coordinate efforts with other users of the same message type...
> > > >
> > > > Imability to "fire and forget" undermines usefulness of whole
> > > > connector. How will you for example implement hotplug notification
> > > > over connector? Have kobject_hotplug wait and block other instances?
> > > > But wait on what?
> > >
> > > This is a simple load balancing schema.
> > > Netlink messages may be dropped in socket queue when
> > > they are bing delivered to userspace - this is the same -
> > > if work queue can not be scheduled, message will be dropped,
> > > but in this case userspace also can not be scheduled
> > > and message will be dropped.
> >
> > Btw, I belive we see that it is reverse direction...
> > So we have reverse load balancing schema here -
> > exactly like userspace socket queueing.
> > We basically can not sleep here - it will be DOS.
> 
> And yet another btw - netlink is unreliable protocol,
> that is why there are seq and ack fields in connector's header -
> connector's users must implement some check on top of
> raw connector messages - it could be returned message with
> timeout resending and so on.
> I wrote it several times and it is in connector's documentation.
> 

I can accept that netlink is unreliable protocol and can drop messages
- but that should only happen when there is memory pressure. In your
case you simply can not send messages with frequency higher than your
timeslice unless you implement synchronous protocol.

Load balancing allows bursts as long as average rate is under control
- connector does not.

-- 
Dmitry
