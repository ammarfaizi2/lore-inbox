Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSEQVbL>; Fri, 17 May 2002 17:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316685AbSEQVbK>; Fri, 17 May 2002 17:31:10 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:448 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316683AbSEQVbK>;
	Fri, 17 May 2002 17:31:10 -0400
Date: Fri, 17 May 2002 14:30:52 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Question : Broadcast Inter Process Communication ?
Message-ID: <20020517143052.A30047@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi everybody,

	I was looking under Linux for a mechanism to distribute an
event from one process (a daemon) to a set of other processes (deamons
or applications). The number and indentity of those other processes
would not be known by the process generating the event, those
processes would register themselves dynamically to the stream of
event. And the event need to be delivered to all of them (not only the
first one).
	In other words, it would look like a *broadcast* message
queue, where the sender process would create the queue and write
events to it, and the other bunch of processes would dynamically open
the queue and listen for events.
	My first attempt was with IPC message queues, but my
experimentations show that only the first receiver get the message. It
is pretty clear that no amount of tweaking will get the IPC message
queue to behave like that : IPC message queues don't have a notion of
receiver session, so can't send message to all receivers.
	I can't use signals because signals are unicast, and I don't
want the sender to have to manage a list of processes it has to send
signals to. Also, signals don't have payload and are synchronous.
	Unix sockets don't have a broadcast mode, and therefore are
limited to a single receiver (actually, I think you can only have one
sender). In theory, you could implement a broadcast mode for Datagram
sockets using the current API, it's just not done today.
	I don't really want to use a UDP broadcast socket for
efficiency reason (and also because I don't want those events to go
accidentally over the network, or beeing succeptible to receive
spoofed events from the network). Also, it require the network stack
to be active and properly configured. But I must admit a UDP broadcast
on the loopback does pretty much what I need.
	Failing that, I could hack a kernel module to do that, but I
don't want to re-invent the wheel...

	This "one sender - multiple reader" model seems common and
usefull enough that there must be a way to do that under Linux. I know
that it exist under Windows. Can somebody help me to find out how to
do it under Linux ?
	Thanks in advance...

	Jean
