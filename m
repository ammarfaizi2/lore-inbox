Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbTCRTSu>; Tue, 18 Mar 2003 14:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbTCRTSu>; Tue, 18 Mar 2003 14:18:50 -0500
Received: from [64.246.18.23] ([64.246.18.23]:59617 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id <S262489AbTCRTSt>;
	Tue, 18 Mar 2003 14:18:49 -0500
From: "Steve Lee" <steve@tuxsoft.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
Date: Tue, 18 Mar 2003 13:34:25 -0600
Message-ID: <001a01c2ed85$66ac5b00$0201a8c0@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <Pine.LNX.4.53.0303181404270.27869@chaos>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please excuse my lack of understanding.  My dial-in box (using mgetty)
is running on a dual Athlon 1900 MP system.  Previous system was a dual
P3 450.  I've called into the Athlon system multiple times a day for
almost a year now, the previous system, for several years.  What issue
should I be seeing?  At times, I send some files home and when I get
home I'll have to manually reset the modem (reset button), however,
mgetty resets and is ready to answer again.  I have mgetty configured to
skip the first call, then answer with the modem if another call happens
within 45 seconds.

Steve


-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Tuesday, March 18, 2003 1:17 PM
To: Steve Lee
Cc: Linux kernel
Subject: RE: Linux-2.4.20 modem control

On Tue, 18 Mar 2003, Steve Lee wrote:

> Richard,
> 	You might give mgetty a try.  I've been doing the same thing as
> you with almost every version of Linux 2.4.x and some of 2.2.x.  I
don't
> know the differences between agetty and mgetty, but I would like
mgetty
> could handle your needs.
>
> Steve

They are all basically the same with certain "enhancements"
(work-arounds) for different things. You can run any of them
and hook a RS-232C terminal to your 'COM' port and log-in.

The problem is when you log out! With a terminal connected,
you get the login prompt again. This is no good if you are
connected to a modem. The modem will not be disconnected
and you have to forcably disconnect at the remote end by
disconnecting the phone line or lowering DTR with your remote
terminal program. Then the modem will not be ready to
answer another call. It will remain in a off-line condition
forever.

What needs to be done, is when the program (probably /bin/bash)
logs off (calls exit()), and STDIN_FILENO, STDOUT_FILENO, and
STDERR_FILENO get closed, the closure of that terminal must
cause the modem to hang-up and then, when init starts another
`getty` the modem will wait for another connection. The current
work-around is to modify a `getty` to hangup the modem, then
initialize I/O to wait for a new connection. This logic is
"backwards" and should be done transparently in the terminal
driver.

This problem is a 'discovered check` which happens with higher
speed machines. At one time, init was so slow in getting another
getty on-line that the modem had a chance to hang up. This is
no longer the case and is being worked on by one of the terminal
driver contributors as I write this.

It will eventually be fixed. I included the source-code of a
work-around in some previous communications, just in case others
have the same problem. Many will not because very few log-in
using a modem anymore.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about
it.


