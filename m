Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270536AbTGNDwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270537AbTGNDwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:52:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:11648 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270536AbTGNDwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:52:39 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 21:00:00 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half
 closed TCP connections)
In-Reply-To: <20030714034244.GC23534@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307132044350.15022@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
 <20030713191559.GA20573@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
 <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com>
 <20030714025644.GA23110@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131958120.15022@bigblue.dev.mcafeelabs.com>
 <20030714031614.GD23110@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307132018200.15022@bigblue.dev.mcafeelabs.com>
 <20030714034244.GC23534@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Jamie Lokier wrote:

> (a) fd isn't a socket
> (b) fd isn't a TCP socket

Jamie, libraries, like for example libevent, are completely generic indeed.
They fetch events and they call the associated callback. You obviously
know inside your callback which kind of fd you working on. So you use the
reading function that best fit the fd type. Obviously the read(2) trick
only works for stream type fds.


> (c) kernel version <= 2.5.75

Obviously, POLLRDHUP is not yet inside the kernel :)


> (d) SO_RCVLOWAT < s

This does not apply with non-blocking fds.


> (e) there is urgent data with OOBINLINE (I think)

You obviously need an EPOLLPRI check in your read handling routine if you
app is expecting urgent data.



- Davide

