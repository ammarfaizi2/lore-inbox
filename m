Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132854AbRDQVE7>; Tue, 17 Apr 2001 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132859AbRDQVEt>; Tue, 17 Apr 2001 17:04:49 -0400
Received: from himalia.xerox.com ([208.140.33.21]:11979 "EHLO
	himalia.eastgw.xerox.com") by vger.kernel.org with ESMTP
	id <S132854AbRDQVEg>; Tue, 17 Apr 2001 17:04:36 -0400
Message-Id: <200104172104.RAA08013@mailhost.eng.mc.xerox.com>
To: linux-kernel@vger.kernel.org
cc: leisner@rochester.rr.com
Subject: kernel threads and close method in a device driver
Date: Tue, 17 Apr 2001 17:04:28 -0400
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm involved with modifying a device driver for new hardware.

The architecture is currently:

	open device
	do IOCTL (spinning a kernel thread and doing initialization)

There is currently an IOCTL which short-circuits to the close method.
Turns out it seems necessary to do this IOCTL -- close never gets 
invoked.

What can cause a close not to get invoked?  BTW, the close is returning
with a 0 status to the application ...(it definitely did NOT 
get invoked in the driver)

In ps:
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
040 33839   750     1   7   0  1064  348 end    D    pts/2      0:00 ./openinit
040 33839   630     1   0   0  1064  348 end    D    pts/0      0:00 ./openinit

These are the kernel threads which won't go away.

I'm running 2.2.12 with the bigphysarea patch...

(leave my work address on the distribution -- I get linux kernel at home...)

marty		mleisner@eng.mc.xerox.com   
Don't  confuse education with schooling.
	Milton Friedman to Yogi Berra
