Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270507AbTGNDEt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270508AbTGNDEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:04:49 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:12937 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270507AbTGNDEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:04:47 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 20:12:09 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half
 closed TCP connections)
In-Reply-To: <20030714030437.GB23110@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307132006420.15022@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com>
 <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com>
 <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
 <20030713191559.GA20573@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
 <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com>
 <20030714030437.GB23110@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > Ouch, I definitely liked more the POLLHUP thing. It is not linked to epoll
> > at all.
>
> POLLRDONCE isn't linked to epoll - it's a valid hint for poll/select too.
>
> It means something different, i.e. you can't write:
>
> > 	if (events & EPOLLRDHUP) {
> > 		d->flags |= HANGUP;
> > 		schedule_removal(d);
> > 	}
>
> Be careful, because that isn't valid if there is urgent data.  You
> need to check POLLPRI too.  Granted urgent data is usually best ignored :)

I didn't want to code the whole application here, hope you understand ;)


> If fast hangup is a useful optimisation too, we should have both flags.
> (However calling read() doesn't seem like a great penalty for that).

Indeed. Hangup cases are a small fraction of std ones, so it has no sense
to optimize for them trying to avoid at all the read. And the name
READONCE seems to imply that you can't read(2) twice. I'd rather prefer
the RDHUP flag that tells me : There's an hungup condition for sure, and
you might also find some data since POLLIN is set.



- Davide

