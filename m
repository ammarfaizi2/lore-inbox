Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVB1Pyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVB1Pyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVB1Pyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:54:46 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53964 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261660AbVB1Pyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:54:35 -0500
Date: Mon, 28 Feb 2005 19:17:59 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: hadi@cyberus.ca
Cc: Thomas Graf <tgraf@suug.ch>, Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, marcelo.tosatti@cyclades.com,
       "David S. Miller" <davem@redhat.com>, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
In-Reply-To: <1109604693.1072.8.camel@jzny.localdomain>
References: <4221E548.4000008@ak.jp.nec.com>
	<20050227140355.GA23055@logos.cnet>
	<42227AEA.6050002@ak.jp.nec.com>
	<1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	<20050227233943.6cb89226.akpm@osdl.org>
	<1109592658.2188.924.camel@jzny.localdomain>
	<20050228132051.GO31837@postel.suug.ch>
	<1109598010.2188.994.camel@jzny.localdomain>
	<20050228135307.GP31837@postel.suug.ch>
	<1109599803.2188.1014.camel@jzny.localdomain>
	<20050228142551.GQ31837@postel.suug.ch>
	<1109604693.1072.8.camel@jzny.localdomain>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Mon, 28 Feb 2005 18:52:38 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 2005 10:31:33 -0500
jamal <hadi@cyberus.ca> wrote:

> On Mon, 2005-02-28 at 09:25, Thomas Graf wrote:
> > * jamal <1109599803.2188.1014.camel@jzny.localdomain> 2005-02-28 09:10
> [..]
> > > To justify writting the new code, I am assuming someone has actually sat
> > > down and in the minimal stuck their finger in the air
> > > and said "yes, there is definetely wind there".
> > 
> > I did, not for this problem though. The code this idea comes from sends
> > batched events 
> 
> I would bet the benefit you are seeing has to do with batching rather
> than such an optimization flag. Different ballgame.
> I relooked at their code snippet, they dont even have skbs built nor
> even figured out what sock or PID. That work still needs to be done it
> seems in cn_netlink_send(). So probably all they need to do is move the
> check in cn_netlink_send() instead. This is assuming they are not
> scratching their heads with some realted complexities.
> 
> I am gonna disapear for a while; hopefully the original posters have
> gathered some ideas from what we discussed.

As connector author, I still doubt it worth copying several lines 
from netlink_broadcast() before skb allocation in cn_netlink_send().
Of course it is easy and can be done, but I do not see any profit here.
Atomic allocation is fast, if it succeds,  but there are no groups/socket to send,
skb will be freed, if allocation fails, then group check is useless.

I would prefer Guillaume Thouvenin as fork connector author to test
his current implementation and show that connector's cost is negligible
both with and without userspace listeners.
As far as I remember it is first entry in fork connector's TODO list.

> cheers,
> jamal
> 


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
