Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317893AbSGPPbY>; Tue, 16 Jul 2002 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317894AbSGPPbY>; Tue, 16 Jul 2002 11:31:24 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:5011 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S317893AbSGPPbW>; Tue, 16 Jul 2002 11:31:22 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793998@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: Networking question
Date: Tue, 16 Jul 2002 11:34:18 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an application which uses a device driver which I wrote to receive
UDP/IP messages. This driver does not use interrupts but polls to see if
messages are available. Once a message is detected I call netif_rx to pass
it up the stack. The application running from user space knows that a
message was received and does a recvfrom on my socket. On a 2.2 Kernel, this
works every time. i.e. I see a message and pass it up the stack and the
recvfrom does indeed get the message from the socket. In a 2.4 environment I
see that netif_rx is using softirq to handle the message as opposed to a BH.
There seems to be a latency introduced because of this. The ksoftirqd runs
at a low priority and my application runs at a high priority (nice value of
-10), Now it seems that the message is not waiting for me when I do a
recvfrom. I do not want to yield my program for too long since the
application is real-time intensive (i.e it must process 30 000msgs/second
which it has been able to do on a 2.2 Kernel). Is there any way to increasy
the priority of the softirq daemon or ensure that it is always awoken when a
netif_rx is called? Please CC me directly on any responses.

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550

