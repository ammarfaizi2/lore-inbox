Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUHZQtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUHZQtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269220AbUHZQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:49:36 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:44042 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S269214AbUHZQqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:46:37 -0400
Date: Thu, 26 Aug 2004 18:46:10 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: Patrick McHardy <kaber@trash.net>, herbert@gondor.apana.org.au,
       nuno.silva@vgertech.com, linux-kernel@vger.kernel.org,
       master@sectorb.msk.ru, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0 to become free. Usage count = 1
Message-ID: <20040826164610.GA11790@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <E1BynUy-0007t1-00@gondolin.me.apana.org.au> <4128941D.9030000@trash.net> <20040822214746.1efb3682.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822214746.1efb3682.davem@redhat.com>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller <davem@redhat.com>
Date: Sun, Aug 22, 2004 at 09:47:46PM -0700
> On Sun, 22 Aug 2004 14:39:57 +0200
> Patrick McHardy <kaber@trash.net> wrote:
> 
> > Herbert Xu wrote:
> > 
> > >Nuno Silva <nuno.silva@vgertech.com> wrote:
> > >  
> > >OK, this appears to be due to the changeset titled
> > >
> > >[PKT_SCHED]: Refcount qdisc->dev for __qdisc_destroy rcu-callback
> > >
> > >It adds a reference to dev.
> > >
> > >I don't see any code that cleans up that reference when the dev goes
> > >down.  So someone needs to add that similar to the code in net/core/dst.c.
> > >
> > >Patrick, could you please have a look at this?
> > >  
> > The reference is dropped in __qdisc_destroy. The problem lies in the CBQ
> > qdisc, it doesn't destroy the root-class and leaks the inner qdisc. These
> > two patches for 2.4 and 2.6 fix the problem.
> 
> Awesome, good detective work guys.
> 
> Patch applied, thanks.

I get the same error with 2.6.9-rc1-mm1, but now for my ipv6-over-ipv4
tunnel.

unregister_netdevice: waiting for xs6all to become free

etc. when trying to reboot or shutdown. Usage count = 1

I'm pretty sure I didn't see this in 2.6.8.1 nor in 2.6.8.1-mm1.

This is a plain ipv6-over-ipv4 tunnel like this:

/etc/network/interfaces:
auto xs6all
iface xs6all inet6 v4tunnel
        endpoint xxx.xxx.xxx.xxx
        up ip route add 2000::0/3 via xxx:xxx:xxx:xxx:xxx:xxx
        address xxx:xxx:xxx:xxx:xxx:xxx
        netmask 64
        up ip tunnel change xs6all ttl 64

I'm running Debian Unstable with all the latest updates as of today.

Thanks for any hints,
Jurriaan
-- 
"At least she's on our side," said Lindholm.
Corbie looked at him. "Investigators aren't on anybody's side."
	Simon R Green - Hellworld
Debian (Unstable) GNU/Linux 2.6.9-rc1 2x6078 bogomips load 0.46
