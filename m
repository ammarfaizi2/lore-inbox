Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbRC0Lqc>; Tue, 27 Mar 2001 06:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRC0LqX>; Tue, 27 Mar 2001 06:46:23 -0500
Received: from bart.one-2-one.net ([195.94.80.12]:46345 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S131232AbRC0LqJ>; Tue, 27 Mar 2001 06:46:09 -0500
Date: Tue, 27 Mar 2001 13:47:01 +0200 (CEST)
From: Martin Diehl <home@mdiehl.de>
To: linux-kernel@vger.kernel.org
Subject: issue with 243-pre8: strange userland/proc breakage
Message-ID: <Pine.LNX.4.21.0103271329280.2735-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Something not so obvious (at least for me ;-) seems to be broken in
userland. Could narrow it down to triggers like failing sed, for example
(from /etc/rc.d/init.d/usb)

PKLVL=`sed 's/^\(.\).*/\1/' < /proc/sys/kernel/printk`

Another probably related thing happens when rc.sysinit sed's from
/proc/cmdline.

Common in both cases:
sed operation from /proc-tree, no error from sed, but failed to work as
expected - i.e. instead of returning the first character/number from
kernel.printk sysctl it returns empty string. For 2.4.0 it is ok.
Simple "cat /proc/sys/kerl/printk" doesn't show any difference.

symptoms:
- Box hangs at rc.sysinit when broken "sed ... /proc/cmdline" tries to
  start linuxconf. Probably some kind of deadlock: all processes sleeping,
  according to SysRq: PC always in cpu_idle. Hitting SAK solves the
  issue: booting finishes without any observable degradation.

- "Malformed setting kernel.printk=" error message from sysctl(8) when
  starting/stopping usb. No harm, simply fails playing games with
  kernel.printk.

System is K6-II UP. Using egcs-2.91.66 or gcc-2.95.3(pre) doesn't make any
difference. Playing with .config to exclude fb(ati64), devfs, scsi, bttv,
usb didn't change anything either.
Unfortunately the step from 2.4.0 is quite big and I had no time yet to
narrow it down - going to try later.

Regards
Martin

