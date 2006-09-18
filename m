Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965570AbWIRI3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965570AbWIRI3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965575AbWIRI3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:29:18 -0400
Received: from ns.suse.de ([195.135.220.2]:24285 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965570AbWIRI3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:29:17 -0400
To: "Stuart MacDonald" <stuartm@connecttech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP stack behaviour question
References: <057a01c6d8ec$4d52c7b0$294b82ce@stuartm>
From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 10:29:12 +0200
In-Reply-To: <057a01c6d8ec$4d52c7b0$294b82ce@stuartm>
Message-ID: <p73slip4lyf.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stuart MacDonald" <stuartm@connecttech.com> writes:

> I'm having some trouble with a network application I've written. I've
> done a lot of research the last few days; man 7 ip, man 7 tcp, kernel
> 2.4.31 source code, Stevens' Illustrated TCP/IP Vol 1 & 3 (for some
> reason we don't have Vol 2), Usenet, websites. I'm hoping someone here
> can help me out, or point me in the correct direction.

Stevens is a good reference to BSD networking, but not necessarily to Linux.

> Question 1: There's the original packet, plus 7 retransmitted packets
> for a total of 8, then TCP gives up. How is 7 (or 8) derived from the
> tcp_retries[12] settings?

Documented in tcp(7)
 
> Question 1a: The time between last and second-last retransmit packets
> is only about 27 seconds. I've read there's a maximum time, but also
> that it's usually 100 or 120 seconds. Where can I find that setting in
> /proc?

It's fixed by the TCP specification.

> Question 2: After the retransmit has given up, the app is still
> making an occasional write(), which succeeds! However, tearing down
> and attemting a new connection results in an immediate EHOSTUNREACH
> error. Why is the write() succeeding?

It goes all in the local buffer, until it starts blocking (or EAGAIN
for non blocking sockets)

> 
> Question 2a: How can my app find out the EHOSTUNREACH error
> immediately? IP_RECVERR is not implemented on TCP, and SO_ERROR always
> reports no error (0).

Did you really read the manpages?  It is implemented and it's documented.

-Andi (your new temporary manpage proxy)  
