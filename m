Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVB1ONj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVB1ONj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVB1OMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:12:54 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:33971 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261627AbVB1OKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:10:12 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Thomas Graf <tgraf@suug.ch>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, marcelo.tosatti@cyclades.com,
       "David S. Miller" <davem@redhat.com>, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
In-Reply-To: <20050228135307.GP31837@postel.suug.ch>
References: <20050224212839.7953167c.akpm@osdl.org>
	 <20050227094949.GA22439@logos.cnet> <4221E548.4000008@ak.jp.nec.com>
	 <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
	 <1109592658.2188.924.camel@jzny.localdomain>
	 <20050228132051.GO31837@postel.suug.ch>
	 <1109598010.2188.994.camel@jzny.localdomain>
	 <20050228135307.GP31837@postel.suug.ch>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1109599803.2188.1014.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Feb 2005 09:10:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 08:53, Thomas Graf wrote:
> * jamal <1109598010.2188.994.camel@jzny.localdomain> 2005-02-28 08:40
> > 
> > netlink broadcast or a wrapper around it.
> > Why even bother doing the check with netlink_has_listeners()?
> 
> To implement the master enable/disable switch they want. The messages
> don't get send out anyway but why bother doing all the work if nothing
> will get send out in the end? It implements a well defined flag
> controlled by open/close on fds (thus handles dying applications)
> stating whether the whole code should be enabled or disabled. It is of
> course not needed to avoid sending unnecessary messages.

To justify writting the new code, I am assuming someone has actually sat
down and in the minimal stuck their finger in the air
and said "yes, there is definetely wind there".

Which leadsto Marcello's question in other email:
Theres some overhead. 
- Message needs to be built with skbs allocated (not the cn_xxx thing
that seems to be invoked - I suspect that thing will build the skbs);
- the netlink table needs to be locked 
-and searched and only then do you find theres nothing to send to. 

The point i was making is if you actually had to post this question,
then you must be running into some problems of complexity ;->
which implies to me that the delta overhead maybe worth it compared to
introducing the complexity or any new code.
I wasnt involved in the discussion - I just woke up and saw the posting
and was bored. So the justification for the optimization has probably
been explained and it may be worth doing the check (but probably such
check should go into whatever that cn_xxx is).

cheers,
jamal

