Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKFTQM>; Mon, 6 Nov 2000 14:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbQKFTQD>; Mon, 6 Nov 2000 14:16:03 -0500
Received: from [63.95.244.10] ([63.95.244.10]:32227 "EHLO mailhub.webgain.com")
	by vger.kernel.org with ESMTP id <S129066AbQKFTP5>;
	Mon, 6 Nov 2000 14:15:57 -0500
Message-Id: <5.0.0.25.0.20001106111445.034a8660@stargate>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Mon, 06 Nov 2000 11:15:35 -0800
To: linux-kernel@vger.kernel.org
From: Thomas Pollinger <tpolling@rhone.ch>
Subject: Re: [BUG REPORT] TCP/IP weirdness in 2.2.15
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen

>Let me see if I understand this correct:
>
>         Client  Router  Server
>         ------------------------------------
>         Linux   Linux   HPUX            Bad
>         WinNT   Linux   HPUX            Good
>         HPUX    Linux   HPUX            Good
>
>With all Linux boxes version 2.2.something
>
>Is this correct?

Yes, this is right.

>This is slightly different from my situation; I had a Linux client and
>Linux server directly connected to the same switch (3Com Superstack
>II, FWIW)

This is probably a configuration I'm going to try as well: put the cvs 
server on a linux box and have it communicate to different clients. 
However, the configuration I have now simply suggests that there cannot be 
a problem on the IP level as the Linux box as router is working as expected.


>Perhaps if I get time I'll repeat the experiment with (a) the most
>recent Alan pre-2.2 kernel and (b) the most recent 2.4-test kernel...
>
>I'll re-iterate my original request, which was not "it's broke - can
>you fix it" but was "okay, how do I go about tracking this one down?"

At this stage, I am uncertain of the cause of the problem. I am pretty much 
sure that the card, drivers and the IP level should work as expected. It is 
lilkely that there could be a problem with CVS which gets caught in a kind 
of deadlock - however, observing the TCP-packet communication and the 
system calls done by both CVS client and server shows always the same 
result (I put a printf before and after the read/recv call in the client):
         - The clilent is stuck in the read system call on the socket for 
reads and waits forever
         - The server gets EWOULDBLOCK notifications when writing to the 
socket and eventually goes
           to sleep
         - The last packages sent by the server will be resent roughly 
every 30-60 seconds.
           The client either responds no packages accepted or the last 
packages are accepted by the
           client but the system call still blocks.

Regards,
-Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
