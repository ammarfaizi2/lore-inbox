Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUFBFyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUFBFyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 01:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265344AbUFBFyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 01:54:41 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:36617 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S265348AbUFBFyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 01:54:39 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Select/Poll
Date: Tue, 1 Jun 2004 22:54:40 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEJIMFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <courier.40BD66BD.00006D7D@softhome.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 01 Jun 2004 22:32:25 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 01 Jun 2004 22:32:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In one of the threads named: "Linux's implementation of poll() not
> scalable?'
> Linus has stated the following:
> **************
> Neither poll() nor select() have this problem: they don't get more
> expensive as you have more and more events - their expense is the number
> of file descriptors, not the number of events per se. In fact, both poll()
> and select() tend to perform _better_ when you have pending events, as
> they are both amenable to optimizations when there is no need for waiting,
> and scanning the arrays can use early-out semantics.
> **************
>
> Please help me understand the above.. I'm using select in a server to read
> on multiple FDs and the clients are dumping messages (of fixed size) in a
> loop on these FDs and the server maintainig those FDs is not able
> to get all
> the messages.. Some of the last messages sent by each client are lost.
> If the number of clients and hence the number of FDs (in the server) is
> increased the loss of data is proportional.
> eg: 5 clients send messages (100 each) to 1 server and server receives
>    96 messages from each client.
>    10 clients send messages (100 by each) to 1 server and server again
>    receives 96 from each client.
>
> If a small sleep in introduced between sending messages the loss of data
> decreases.
> Also please explain the algorithm select uses to read messages on FDs and
> how does it perform better when number of FDs increases.

	Your issue has nothing to do with select or poll scalability, it has to do
with the fact that UDP is unreliable and you must provide your own send
timing. A UDP server or client cannot just send 100 messages in one shot and
expect the other end to get all of them. They probably won't all even make
it to the wire, so the recipient can't solve the problem.

	DS


