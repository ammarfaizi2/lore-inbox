Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbUCBVkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUCBVjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:39:42 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:33587 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261728AbUCBVj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:39:26 -0500
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
References: <Pine.LNX.4.53.0403021318580.796@chaos>
	<527jy3qalg.fsf@topspin.com> <Pine.LNX.4.53.0403021510270.1856@chaos>
	<52vflnq807.fsf@topspin.com> <Pine.LNX.4.53.0403021624300.2296@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 02 Mar 2004 13:39:24 -0800
In-Reply-To: <Pine.LNX.4.53.0403021624300.2296@chaos>
Message-ID: <52n06zq67n.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Mar 2004 21:39:24.0715 (UTC) FILETIME=[D4BC27B0:01C4009E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> I don't think so.  Even in kernel 2.4, poll_wait() just
    Roland> calls __pollwait().  I don't see anything in __pollwait()
    Roland> that sleeps.  Think about it.  How would the kernel handle
    Roland> userspace calling poll() with more than one file
    Roland> descriptor if each individual driver slept?

    Richard> Well what to you think they do? Spin?

I don't know why I continue this, but.... can you point out the line
in the kernel 2.4 source for __pollwait() where it sleeps?

Or think about it.  Suppose a user called poll() with two fds, each of
which belonged to a different driver.  Suppose each driver slept in
its poll method.  If the first driver never became ready (and stayed
asleep), how would poll() return to user space if the second driver
became ready?

What actually happens is that each driver registers with the kernel
the wait queues that it will wake up when it becomes ready.  But the
core kernel is responsible for sleeping, outside of the driver code.

Really, read:
    <http://www.xml.com/ldd/chapter/book/ch05.html#t3>

You might believe you're familiar with poll() but I think it would
help to read what the Linux Device Drivers book has to say.  It
answers the exact question you're asking, and if you don't believe me
you might believe the definitive published book.

 - Roland
