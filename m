Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270354AbRHMSHH>; Mon, 13 Aug 2001 14:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270359AbRHMSG5>; Mon, 13 Aug 2001 14:06:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15746 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270354AbRHMSGs>; Mon, 13 Aug 2001 14:06:48 -0400
Date: Mon, 13 Aug 2001 14:06:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Serial I/O error
Message-ID: <Pine.LNX.3.95.1010813140119.2631A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

I have a simple `getty` for monitoring a modem. It is designed
for access like the old Digital terminal servers so it can't
get confused with "CONNECT NNN" messages, etc.

A thumbnail sketch of the code is:

Parent getty opens /dev/ttySn using flags O_NDELAY. It then sets
flags back.

Parent waits for activity on modem, then forks to execute /bin/login.

Parent waits for the child to expire either because of a login-failure
or because of normal process termination.

The parent keeps the child's fd open because it wants to hang up the
modem when the child is through.

After the child exits, the parent attempts to hang-up the modem by
setting the baud-rate to B0, waiting 2 seconds, then setting the
band-rate back. The modem DOES get hung up, however `tcsetattrib()`
returns -1 and errno is set to EIO.

If the parent, instead of using the original fd, keeps that open and
opens another fd for the serial link, everything works okay.

So, it __seems__ as though the fd that was duped in the child to
0, 1, and 2, is corrupted once the child expires. If the parent uses
the file descriptor before the child expires, everything is fine.

The code is available if anyone wants to see it. I don't like
to have to use a work-around, like the second open(), in what
should be simple code.

Anybody have any ideas? Is it a serial bug?  FYI, the code works
both on my Sun and on Linux 2.4.1. However, it reports an error
on Linux and does not report an error on the Sun, SunOS 5.5.1.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


