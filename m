Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132041AbQLVPzx>; Fri, 22 Dec 2000 10:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132107AbQLVPzo>; Fri, 22 Dec 2000 10:55:44 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:31736 "EHLO
	mail.plan9.de") by vger.kernel.org with ESMTP id <S132041AbQLVPzc>;
	Fri, 22 Dec 2000 10:55:32 -0500
Date: Fri, 22 Dec 2000 16:24:50 +0100
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Subject: time function problems with 2.2.18 / hang
Message-ID: <20001222162447.A657@fuji.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux version 2.2.18 (root@fuji) (gcc version pgcc-2.95.2 19991024 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an error that occurs after upgrading from 2.2.18pre23 to 2.2.18 +
vm-global-7 patch.

Apart from enhanced stability in low-memory cases (hey, it doesn't
freeze ten times a day ;), I have the problem that once every few days,
preferably under high load, X behaves strangely (window manager shows no
reaction, mouse works OR mousecursor stops moving OR wm works, mouse works
but rxvt's stop working tc..)

When this happens I can still log-in via the network and run command, but
every copmmand that uses waits (select(0,0,0,xxx) or nanosleep) just hangs:

cerebro:~# strace -f sleep 1
...
nanosleep({1, 0}, 

Also, when I beep the terminal it starts beeping but never stops, so it
seems the timer system inside the kernel is somehow wrecked in this state.

Doing while :;do kill -CONT -1;done lets me do some things, like runing top
or kill and restart X (very slowly ;).

That is the strangest thing I ever saw in a release kernel ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
