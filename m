Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268984AbUJQA3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268984AbUJQA3y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268980AbUJQA3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:29:53 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:59656 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S268989AbUJQA33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:29:29 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sat, 16 Oct 2004 17:28:24 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041016062512.GA17971@mark.mielke.cc>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 16 Oct 2004 17:05:08 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 16 Oct 2004 17:05:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sure, but this isn't about the future, remember. The kernel
> already has the
> information to know whether there is data, or whether there isn't. It just
> isn't doing the work to find out.

	The kernel does not have the information yet. It could get it, but it does
not have it.

> Allowed by who? For select() to say data is ready, and read() to block,
> is not allowed by all the standards that I have read. This is the first
> time I have ever heard of a situation like this, for select(). It is *not*
> the same as writing an arbitrary number of bytes, or accepting.

	So is it your position that a kernel cannot drop a UDP packet at any time
after it indicated that the socket was readable because of that packet? If
so, please cite where in POSIX you think you find this requirement.

	The kernel elects to drop the packet on the call to 'recvmsg'. This is its
right -- it can drop a UDP packet at any time. POSIX is careful not to imply
that 'select' guarantees future behavior because this is not possible in
principle.

> You say it will not break any application that could not already be broken
> by other circumstances. I disagree. For example, a UDP-based server that
> only receives, and never sends, would be perfectly happy to select() on
> several file descriptors, and readmesg() whenever the UDP file descriptor
> says readable. It would not break on other operating systems that
> implement
> select() to be useful for determining whether or not to read() from a
> blocking file descriptor.

	Sure it would. It would break on any platform that dropped a UDP packet
after having triggered a read hit on 'select' because of that packet. POSIX
does not say that a future read will not block because it cannot guarantee
that under at least some circumstances.

	DS


