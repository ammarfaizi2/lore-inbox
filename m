Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270485AbTGNB1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270487AbTGNB1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:27:39 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:59540 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270485AbTGNB1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:27:33 -0400
Date: Mon, 14 Jul 2003 02:41:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, e0206@foo21.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030714014135.GA22769@mail.jlokier.co.uk>
References: <20030712181654.GB15643@srv.foo21.com> <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com> <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk> <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com> <20030713191559.GA20573@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Yes, this could be improved though. If we could only pass our event
> interest mask to f_op->poll() the function will be able to register it
> inside the wait queue structure and release only waiters that matches the
> available condition.

It's not a bad idea.

> > And ttys?  They are problematic, because ttys can return EOF _after_
> > returning data without closing (and without being hung-up).  An epoll
> > loop which is reading a tty (and isn't programmed specially for a tty)
> > _must_ receive POLLRDHUP when the EOF is pending, else it may hang.
> 
> Please replace 'it may hung' with 'it may hung if it is using the read()
> return bytes check trick' ;)

Sure - but take an app that is normally using TCP sockets and give it
an AF_UNIX socket..  Something as general as the event loop
_shouldn't_ have to depend on that subtlety.

Ok that's avoidable, but it's a trap.  It would be nice to get a flag
that doesn't have a caveat in the manual saying "this flag only works
(at present) on TCP sockets in kernels >= 2.5.76.  Take care not to
use the optimisation for any other kind of fd including other sockets,
as it will break your app...".  That's not the sort of thing I want to
see in the epoll manual page :)

Anyway, there is a correct answer and I have made the patch so wait
for next mail... :)

-- Jamie
