Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTFIRmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264611AbTFIRmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:42:00 -0400
Received: from mail.webmaster.com ([216.152.64.131]:41141 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264601AbTFIRl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:41:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: select for UNIX sockets?
Date: Mon, 9 Jun 2003 10:55:35 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <m3znkr41bd.fsf@defiant.pm.waw.pl>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Schwartz" <davids@webmaster.com> writes:

> > 	It really doesn't matter. UDP applications have to control
> > the transmit
> > pacing at application level. There is absolutely no way for the
> > kernel to
> > know whether the path to the recipient is congested or not.

> Because what? The kernel knows everything it has to know - i.e. complete
> state of socket queue in question.

	For the last time, there is no socket queue. You wouldn't want there to be
one.

	Consider a UDP application that is sending packets to two destinations, one
over a 56Kbps serial link running PPP and one over gigabit Ethernet. If
there were a socket send queue, the packets going over the 56Kbps serial
link would block the packets going over the gigabit Ethernet.

> But if select() on sockets is illegal, should we make it return -Esth
> instead of success. Certainly, we should get rid of invalid kernel code,
> right?

	No, it is legal, you are just misusing it. If you don't want your socket
operations to ever block, use non-blocking socket operations. If you use
UDP, or another connectionless protocol, you should understand that *you*
are responsible for transmit pacing.

> > The kernel can't tell you when to send because that depends upon
> > factors
> > that are remote.

> Such as?

	Such as where the packet you send is actually *going*.

> > Yes, it would be nice of the kernel helped more. But the application
> > has to
> > deal with remote packet loss as well.

> Could you please show me a place in the kernel which could cause such
> a loss on local datagram sockets?

	I guess I'm not getting through. The fact is, you don't have the guarantee
that you think you have. I'm giving you examples to show you why you don't
have that guarantee. You argue that the examples don't apply to your
specific case. I'm not saying they do. I'm saying that because there are
unavoidable cases where what you're trying to do won't work, then what
you're trying to do is not guaranteed to work in all cases and you shouldn't
try to do it.

	The kernel does not remember that you got a write hit on 'select' and use
it to somehow ensure that your next 'write' doesn't block. A 'write' hit
from 'select' is just a hint and not an absolute guarantee that whatever
'write' operation you happen to choose to do won't block.

	DS


