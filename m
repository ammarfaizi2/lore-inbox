Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270550AbTGNGnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 02:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270551AbTGNGnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 02:43:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:19861 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270550AbTGNGnm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 02:43:42 -0400
Date: Mon, 14 Jul 2003 07:57:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half closed TCP connections)
Message-ID: <20030714065741.GC24031@mail.jlokier.co.uk>
References: <20030714022412.GD22769@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com> <20030714025644.GA23110@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131958120.15022@bigblue.dev.mcafeelabs.com> <20030714031614.GD23110@mail.jlokier.co.uk> <Pine.LNX.4.55.0307132018200.15022@bigblue.dev.mcafeelabs.com> <20030714034244.GC23534@mail.jlokier.co.uk> <Pine.LNX.4.55.0307132044350.15022@bigblue.dev.mcafeelabs.com> <20030714055122.GA24031@mail.jlokier.co.uk> <Pine.LNX.4.55.0307132252310.15022@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307132252310.15022@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > > > (d) SO_RCVLOWAT < s
> > > This does not apply with non-blocking fds.
> > Look at the line "if (copied >= target)" in tcp_recvmsg.
> 
> Look at this :
> 	timeo = sock_rcvtimeo(sk, nonblock);

How does `nonblock' prevent short reads?  I don't see it.

> > I disagree - inside a stream parser callback (e.g. XML transcoder) I
> > prefer to _not_ know the difference between pipe, file, tty and socket
> > that I am reading.
> 
> These are streams and you can use the read(2) trick w/out problems. I
> don't think you want to mount your XML parser over UDP.

You cannot use the read(2) trick with a tty or file; RDHUP doesn't help.

> > > > (c) kernel version <= 2.5.75
> > > Obviously, POLLRDHUP is not yet inside the kernel :)
> > Quite.  When you write an app that uses it and the read(2) trick
> > you'll see the bug which Eric brought up :)
> >
> > I'm saying there's a way to write an app which can use the read(2)
> > trick, yet which does _not_ hang on older kernels.  Hence is robust.
> 
> How, if you do not change the kernel by making it returning an extra flag ?

By defining the interface such that _not_ setting the flag merely
suppresses the optimisation, it doesn't stop the program from working.

-- Jamie

