Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276687AbRJBVKw>; Tue, 2 Oct 2001 17:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276693AbRJBVKm>; Tue, 2 Oct 2001 17:10:42 -0400
Received: from f283.law10.hotmail.com ([64.4.14.158]:49937 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S276687AbRJBVKb>;
	Tue, 2 Oct 2001 17:10:31 -0400
X-Originating-IP: [209.213.222.214]
From: "captain smp" <captainsmp@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: sock_sendmsg() from a kernel thread question
Date: Tue, 02 Oct 2001 21:10:54 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F283XKGoyufRev86cl300004950@hotmail.com>
X-OriginalArrivalTime: 02 Oct 2001 21:10:54.0632 (UTC) FILETIME=[B91AB280:01C14B86]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to call sock_sendmsg() from a kernel thread
and it seems to work fine on a UP system but on SMP system
it hangs up and the thread can't even accept a SIGKILL.
It it stuck after the following calls happen:

sock_sendmsg()
sock->ops->sendmsg()
tcp_do_sendmsg()

then tcp_do_sendmsg() calls:

skb = sock_wmalloc(sk, tmp, 0, GFP_KERNEL);

but that call never returns.  It doesn't get to
the code where the comment says: "If we didn't get
any memory, we need to sleep."

I've mucked with sock->sk->allocation flavors but to no avail.

BTW, this is 2.2.16-22 (stock red hat 6.2 kernel)

Is this fixed in later kernels, or is there some semaphore/spinlock
needed to call sock_sendmsg()/recvmsg() from kernel threads?

Is there a race with skbuff allocation/deallocation from the
NET_BH network bottom half handler or NIC interrupt handler
that I can prevent from happening somehow?

-Captain


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

