Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265339AbUFBFdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUFBFdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 01:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUFBFdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 01:33:52 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:23242 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S265331AbUFBFdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 01:33:50 -0400
From: jyotiraditya@softhome.net
To: linux-kernel@vger.kernel.org
Subject: Select/Poll
Date: Tue, 01 Jun 2004 23:33:49 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.54.13.34]
Message-ID: <courier.40BD66BD.00006D7D@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All, 

In one of the threads named: "Linux's implementation of poll() not 
scalable?'
Linus has stated the following:
**************
Neither poll() nor select() have this problem: they don't get more
expensive as you have more and more events - their expense is the number
of file descriptors, not the number of events per se. In fact, both poll()
and select() tend to perform _better_ when you have pending events, as
they are both amenable to optimizations when there is no need for waiting,
and scanning the arrays can use early-out semantics.
************** 

Please help me understand the above.. I'm using select in a server to read
on multiple FDs and the clients are dumping messages (of fixed size) in a
loop on these FDs and the server maintainig those FDs is not able to get all
the messages.. Some of the last messages sent by each client are lost.
If the number of clients and hence the number of FDs (in the server) is
increased the loss of data is proportional.
eg: 5 clients send messages (100 each) to 1 server and server receives
   96 messages from each client.
   10 clients send messages (100 by each) to 1 server and server again
   receives 96 from each client. 

If a small sleep in introduced between sending messages the loss of data
decreases.
Also please explain the algorithm select uses to read messages on FDs and
how does it perform better when number of FDs increases. 

Thanks and Regards,
Jyotiraditya 
