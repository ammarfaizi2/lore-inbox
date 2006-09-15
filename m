Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWIOR2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWIOR2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWIOR2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:28:31 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:33222 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S932126AbWIOR2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:28:31 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "LKML" <linux-kernel@vger.kernel.org>
Subject: TCP stack behaviour question
Date: Fri, 15 Sep 2006 13:28:04 -0400
Organization: Connect Tech Inc.
Message-ID: <057a01c6d8ec$4d52c7b0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some trouble with a network application I've written. I've
done a lot of research the last few days; man 7 ip, man 7 tcp, kernel
2.4.31 source code, Stevens' Illustrated TCP/IP Vol 1 & 3 (for some
reason we don't have Vol 2), Usenet, websites. I'm hoping someone here
can help me out, or point me in the correct direction.

Distro: Debian 3.0 r2
Kernel: Stock 2.4.24

tcp_retries1 == 3
tcp_retries2 == 15

I have an application that setups up a TCP connection to a server. If
the server has a power failure, TCP starts retransmitting the packet
that wasn't ACKed. I see the exponential backoff.

Question 1: There's the original packet, plus 7 retransmitted packets
for a total of 8, then TCP gives up. How is 7 (or 8) derived from the
tcp_retries[12] settings?

Question 1a: The time between last and second-last retransmit packets
is only about 27 seconds. I've read there's a maximum time, but also
that it's usually 100 or 120 seconds. Where can I find that setting in
/proc?

Question 1b: If RTO is that high, why is retransmit stopping?

Question 2: After the retransmit has given up, the app is still
making an occasional write(), which succeeds! However, tearing down
and attemting a new connection results in an immediate EHOSTUNREACH
error. Why is the write() succeeding?

Question 2a: How can my app find out the EHOSTUNREACH error
immediately? IP_RECVERR is not implemented on TCP, and SO_ERROR always
reports no error (0).

..Stu

