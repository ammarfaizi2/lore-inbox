Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVB1CcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVB1CcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 21:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVB1CcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 21:32:03 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:22214 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261503AbVB1CcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 21:32:00 -0500
Date: Mon, 28 Feb 2005 03:32:06 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050228023206.GN31837@postel.suug.ch>
References: <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com> <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet> <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42227AEA.6050002@ak.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I'm not aware of the whole discussion, ignore this if it
has been brought to attention already.

> > Yep, the netlink people should be able to help - they known what would be
> > required for not sending messages in case there is no listener registered.
> >
> > Maybe its already possible? I have never used netlink myself.

The easiest way is to use netlink_broadcast() and have userspace
register to a netlink multicast group (set .nl_groups before connecting
the socket). The netlink message will be sent to only those netlink
sockets assigned to the group, no message will be send out if no
userspace listeners has registered.

Did you have a look at the syscall enter/exit audit netlink hooks
before trying to invent your own thing?

I can also give you some code if you want, I use it to track the path
of skbs in the net stack. It puts events into a preallocated ring buffer
and a separate kernel thread broadcasts them over netlink. The events
can be enqueued in any context at the cost of a possible ring buffer
overrun resulting in loss of events. It's just a debugging hack though.
