Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbTIIVx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbTIIVx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:53:27 -0400
Received: from mid-1.inet.it ([213.92.5.18]:8154 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S264627AbTIIVwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:52:46 -0400
Message-ID: <014201c3771d$4e95c160$36af7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <1063142262.30981.17.camel@dhcp23.swansea.linux.org.uk>
Subject: Re: Efficient IPC mechanism on Linux
Date: Tue, 9 Sep 2003 23:57:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The text is a little hard to follow for an English speaker. I can follow
> a fair bit and there are a few things I'd take issue with (forgive me if
> I'm misunderstanding your material)

I know. I'm very sorry for this. I'm rewriting the text in English,
so, don't bore with Italian. The new page will be up in a moment.

> 1. Almost all IPC is < 512 bytes long. There are exceptions including
> X11 image passing which is an important performance one

Sure for system needs. What about programming?
You can write application of any complexity.
Why do I have to be limited by kernel in sending 4056 bytes
(for exmple, if I use SYS V message queues)
instead of an arbitrary sized message?

> 2. One of the constraints that a message system has is that if it uses
> shared memory it must protect the memory queues from abuse. For example
> if previous/next pointers are kept in the shared memory one app may be
> able to trick another into modifying the wrong thing. Sometimes this
> matters.

Please, refer to address space.
If you don't have the piece of information you want to access
into your own private address space, the only thing that will occur
is a general protection fault and your process will be killed.
Remember that, with my primitives, you're working with logical addresses
that need relocation in hardware. The MMU contestually performs
memory protection, too.

> 3. An interesting question exists as to how whether you can create the
> same effect with current 2.6 kernel primitives. We have posix shared
> memory objects, we have read only mappings and we have extremely fast
> task switch and also locks (futex locks)

I too need to use locks in my primitives. The fact that new kernel has
faster locks also reduceses the completion time of my primitives.

Also. The central point is not to have10 instead of 50 assembler lines
in the primitives. The central point is to implement communication
primitives
that do not require physical copying of the messages being sent and
received.
Lock probably reduces the time to write or read from a pipe.
But the order of magnitute remains the same.

Task switching is relevant in all communication primitives.
Fast task switch means proportionally fast primitives. Also mine primitives.

> Also from the benching point of view it is always instructive to run a
> set of benchmarks that involve the sender writing all the data bytes,
> sending it and the receiver reading them all. Without this zero copy
> mechanisms (especially mmu based ones) look artificially good.

The bench you are talking about is exactly the one I implemented to misure
the IPC overhead.
We have 2 process communicating over a channel in a pipeline fashion.
A writes some information in a buffer and sends it to B.
B receives and reads.
This for 1000 times.
Times reported are average time.

Bye,
Luca

