Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268182AbRHFM1Z>; Mon, 6 Aug 2001 08:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268150AbRHFM1Q>; Mon, 6 Aug 2001 08:27:16 -0400
Received: from lech.pse.pl ([194.92.3.7]:17543 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S268137AbRHFM1I>;
	Mon, 6 Aug 2001 08:27:08 -0400
Date: Mon, 6 Aug 2001 14:27:04 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: linux-kernel@vger.kernel.org
Subject: getty problems
Message-ID: <20010806142703.A25428@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Organization: Polskie Sieci Elektroenergetyczne S.A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In short: on 2.4.7-ac[3-7] getty cannot open /dev/ttyX,
while on 2.4.5 it can.

I've done "strace -o /tmp/GETTY-`uname -r` /sbin/getty tty9 vc linux"
in both cases and compared otput files. The big difference is here:

2.4.5:
open("/dev/tty9", O_RDWR|O_NONBLOCK)    = 0

2.4.7-ac7:
open("/dev/tty9", O_RDWR|O_NONBLOCK)    = -1 ENODEV (No such device)

And yes, I believe I have terminal support compiled in:

===
#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
===

$ gcc -v      
Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)

This problem hit me when I compiled and installed new kernel
(2.4.5 comes with the distribution) - I could not log in because
all gettys got disabled:

Aug  6 14:10:09 nnet /sbin/agetty[103]: /dev/tty6: cannot open as standard input: No such device
Aug  6 14:10:09 nnet init: Id "c4" respawning too fast: disabled for 5 minutes

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
