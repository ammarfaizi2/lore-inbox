Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270054AbTGMBDL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 21:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270055AbTGMBDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 21:03:11 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:36107 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S270054AbTGMBDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 21:03:08 -0400
Date: Sun, 13 Jul 2003 11:17:35 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: jkenisto@us.ibm.com, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <akpm@osdl.org>, <jgarzik@pobox.com>, <alan@lxorguk.ukuu.org.uk>,
       <rddunlap@osdl.org>, <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
In-Reply-To: <20030711224142.557b5b5e.davem@redhat.com>
Message-ID: <Mutt.LNX.4.44.0307131052420.2146-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, David S. Miller wrote:

> > +	/* Don't bother queuing skb if kernel socket has no input function */
> > +        if (nlk->pid == 0 && !nlk->data_ready)
> > +        	goto no_dst;
> > +
> 
> Oops, turns out this doesn't work.  data_ready is never NULL, look at
> how netlink_kernel_create() works.

It's ok: sk->data_ready is never null, but nlk_sk(sk)->data_ready will be 
null unless an input function is provided there.

> Also, the broadcast case probably needs to be handled
> too?

Netlink sockets created by netlink_kernel_create() do not subscribe to any 
groups and are not broadcast to.

> As an aside, to be honest what's so wrong with the socket receive
> buffer filling up?  The damage is limited to the receive buffer size
> of the kernel netlink socket, but that's it.

Agreed, it's not really harmful, but it's sloppy.  Better to let the
application know that it can't send to the socket rather than let it keep
sending (with successful return codes) until the kernel socket buffer 
fills up.


- James
-- 
James Morris
<jmorris@intercode.com.au>

