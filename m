Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270510AbTGNDK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270511AbTGNDK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:10:29 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:15497 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270510AbTGNDK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:10:28 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 20:17:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half
 closed TCP connections)
In-Reply-To: <20030714031242.GC23110@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307132015230.15022@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com>
 <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
 <20030713191559.GA20573@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
 <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com>
 <20030714025644.GA23110@mail.jlokier.co.uk> <20030714031242.GC23110@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Jamie Lokier wrote:

> Jamie Lokier wrote:
> > 	(e) there is urgent data with OOBINLINE (I think)
>
> To be more precise, using the POLLRDHUP patch as-is, if someone sends
> your program some data, then an URGent segment, then a FIN with
> optional data in between, your program won't notice the second data or
> FIN and will fail to clean up the socket.

And why ? To me it looks fairly simple. When the FIN is received a wakeup
is done on the poll wait list and the following f_op->poll will fetch the
RDHUP flag. Then the next epoll_wait() will fetch the event and will have
all the info it needs to do things correctly.



- Davide

