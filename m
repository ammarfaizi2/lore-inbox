Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262550AbTCRTDm>; Tue, 18 Mar 2003 14:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262551AbTCRTDm>; Tue, 18 Mar 2003 14:03:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21638 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262550AbTCRTDk>; Tue, 18 Mar 2003 14:03:40 -0500
Date: Tue, 18 Mar 2003 14:17:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Steve Lee <steve@tuxsoft.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
In-Reply-To: <001601c2ed7c$f984e900$0201a8c0@pluto>
Message-ID: <Pine.LNX.4.53.0303181404270.27869@chaos>
References: <001601c2ed7c$f984e900$0201a8c0@pluto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, Steve Lee wrote:

> Richard,
> 	You might give mgetty a try.  I've been doing the same thing as
> you with almost every version of Linux 2.4.x and some of 2.2.x.  I don't
> know the differences between agetty and mgetty, but I would like mgetty
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
Why is the government concerned about the lunatic fringe? Think about it.

