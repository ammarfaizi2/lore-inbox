Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRDFCBS>; Thu, 5 Apr 2001 22:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbRDFCBI>; Thu, 5 Apr 2001 22:01:08 -0400
Received: from [209.250.53.73] ([209.250.53.73]:17931 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S130768AbRDFCAw>; Thu, 5 Apr 2001 22:00:52 -0400
Date: Thu, 5 Apr 2001 20:59:22 -0500
From: Steven Walter <srwalter@yahoo.com>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Problems with serial driver 5.05, kernel 2.4.3
Message-ID: <20010405205922.A16574@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 8:08pm  up 2 days, 23:25,  3 users,  load average: 2.79, 2.80, 2.62
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting some interesting behavior with the 2.4.3 serial driver and
agetty.

This system uses the onboard serial port (ttyS0) for a serial console
(console=ttyS0,38400) along with the VGA port.  If I try to start an
agetty on this line (agetty -L ttyS0 38400), it gets as far as
outputting "Debian GNU/Linux", etc, before freezing in ioctl(0,
SNDCTL_STOP...), this according to strace.  According to "ps -eo wchan",
it's hanging in tty_wait_until_sent.  fd 0 is /dev/ttyS0.
This happens if the port is connected via null-modem cable to another
computer, a null-modem cable connected to no other computer, or no cable
at all.

This seems to be a kernel problem to me, since its hanging in kernel
space.  However, the problem can be worked around somewhat by starting
agetty as "agetty -n -L ttyS0 38400".  In this mode of operation, the
login prompt gets printed (though the banner doesn't), and I can log in.
It seems to work well, except that large sustained transfers seem to
lock the program on this end.  For example, "dmesg" will print out a
considerable amount of text, and then simply stop.  Ctrl+C returns me to
a bash prompt.  It stops at the same spot every time, unless I start
typing between "dmesg" and stoppage.  It never varies by more than a few
(10-15) characters.  Interestingly enough, characters are still echoed
between stoppage and return to bash.

I wouldn't blame the cable or the remote computer, though, as I've tried
using an entirely different computer complete with different OS as the
terminal, with precisely the same behavior.  I've also used the cable
between the two other computers, in which it works correctly.  (The
kernel used in which it works correctly is 2.2.14 on an RH 5.2 system.)

I hope I've given you enough information to make a useful evaluation,
and hopefully a fix.  If I've left something out, please ask, and I'll be
happy to give you whatever I can.  I'm also willing to try out possible
fixes.

Thanks
-- 
-Steven
Freedom is the freedom to say that two plus two equals four.
