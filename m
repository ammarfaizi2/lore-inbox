Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVCAIWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVCAIWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVCAIWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:22:04 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:35507 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261745AbVCAIVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:21:40 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: hadi@cyberus.ca, Thomas Graf <tgraf@suug.ch>,
       Andrew Morton <akpm@osdl.org>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       marcelo.tosatti@cyclades.com, "David S. Miller" <davem@redhat.com>,
       jlan@sgi.com, LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
References: <4221E548.4000008@ak.jp.nec.com>
	 <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
	 <1109592658.2188.924.camel@jzny.localdomain>
	 <20050228132051.GO31837@postel.suug.ch>
	 <1109598010.2188.994.camel@jzny.localdomain>
	 <20050228135307.GP31837@postel.suug.ch>
	 <1109599803.2188.1014.camel@jzny.localdomain>
	 <20050228142551.GQ31837@postel.suug.ch>
	 <1109604693.1072.8.camel@jzny.localdomain>
	 <20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
Date: Tue, 01 Mar 2005 09:21:39 +0100
Message-Id: <1109665299.8594.55.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 01/03/2005 09:30:39,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 01/03/2005 09:30:41,
	Serialize complete at 01/03/2005 09:30:41
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 19:17 +0300, Evgeniy Polyakov wrote:
> On 28 Feb 2005 10:31:33 -0500
> jamal <hadi@cyberus.ca> wrote:
> > I would bet the benefit you are seeing has to do with batching rather
> > than such an optimization flag. Different ballgame.
> > I relooked at their code snippet, they dont even have skbs built nor
> > even figured out what sock or PID. That work still needs to be done it
> > seems in cn_netlink_send(). So probably all they need to do is move the
> > check in cn_netlink_send() instead. This is assuming they are not
> > scratching their heads with some realted complexities.
> [...]
> As connector author, I still doubt it worth copying several lines 
> from netlink_broadcast() before skb allocation in cn_netlink_send().
> Of course it is easy and can be done, but I do not see any profit here.
> Atomic allocation is fast, if it succeds,  but there are no groups/socket to send,
> skb will be freed, if allocation fails, then group check is useless.
> 
> I would prefer Guillaume Thouvenin as fork connector author to test
> his current implementation and show that connector's cost is negligible
> both with and without userspace listeners.
> As far as I remember it is first entry in fork connector's TODO list.

I tested without user space listeners and the cost is negligible. I will
test with a user space listeners and see the results. I'm going to run
the test this week after improving the mechanism that switch on/off the
sending of the message.

Best regards,
Guillaume

