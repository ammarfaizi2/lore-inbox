Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270506AbTGNDCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270507AbTGNDCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:02:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:7061 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S270506AbTGNDCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:02:13 -0400
Date: Mon, 14 Jul 2003 04:16:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half closed TCP connections)
Message-ID: <20030714031614.GD23110@mail.jlokier.co.uk>
References: <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk> <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com> <20030713191559.GA20573@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com> <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com> <20030714025644.GA23110@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131958120.15022@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307131958120.15022@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > > Where this will break by using a POLLRDHUP ?
> >
> > It will break if
> >
> > 	(a) fd isn't a socket
> > 	(b) fd isn't a TCP socket
> > 	(c) kernel version <= 2.5.75
> > 	(d) SO_RCVLOWAT < s
> > 	(e) there is urgent data with OOBINLINE (I think)

> Jamie, did you smoke that stuff again ? :)
> With Eric patch in the proper places it is just fine. You just make
> f_op->poll() to report the extra flag other that POLLIN. What's the problem ?

The problem in cases (a)-(e) is your loop will call read() just once
when it needs to call read() until it sees EAGAIN.

What's wrong is the behaviour of your program when the extra flag
_isn't_ set.

-- Jamie
