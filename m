Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUCBVAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbUCBVAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:00:53 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:45359 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261777AbUCBVAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:00:41 -0500
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
References: <Pine.LNX.4.53.0403021318580.796@chaos>
	<527jy3qalg.fsf@topspin.com> <Pine.LNX.4.53.0403021510270.1856@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 02 Mar 2004 13:00:40 -0800
In-Reply-To: <Pine.LNX.4.53.0403021510270.1856@chaos>
Message-ID: <52vflnq807.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Mar 2004 21:00:40.0871 (UTC) FILETIME=[6B9DB370:01C40099]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard> I'm talking about the driver! When a open fd called
    Richard> poll() or select(), in user-mode code, the driver's
    Richard> poll() was called, and the driver's poll() would call
    Richard> poll_wait().  Poll_wait() used to NOT return until the
    Richard> driver executed wake_up_interruptible() on that
    Richard> wait-queue. When poll_wait() returned, the driver would
    Richard> return to the caller with the new poll- status.

I don't think so.  Even in kernel 2.4, poll_wait() just calls
__pollwait().  I don't see anything in __pollwait() that sleeps.
Think about it.  How would the kernel handle userspace calling poll()
with more than one file descriptor if each individual driver slept?

I'll repeat my earlier suggestion.  Read the description of "poll and
select" in LDD:
     <http://www.xml.com/ldd/chapter/book/ch05.html#t3>

If you refuse to understand the documented interface, I don't think
anyone can help you.

 - Roland
