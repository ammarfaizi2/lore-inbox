Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQKQExy>; Thu, 16 Nov 2000 23:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbQKQExq>; Thu, 16 Nov 2000 23:53:46 -0500
Received: from ha2.rdc2.tx.home.com ([24.14.77.21]:36315 "EHLO
	mail.rdc2.tx.home.com") by vger.kernel.org with ESMTP
	id <S129314AbQKQExf>; Thu, 16 Nov 2000 23:53:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make CPU usage and virtual itimers accurate
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 16 Nov 2000 20:55:45 -0600
Message-ID: <m2hf57e28e.fsf@c469597-a.grlnd1.tx.home.com>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have patches written to improve the accuracy of CPU measurement
(getrusage()) and virtual itimers.  This lets the amount of CPU used
by a process be measured fairly accurately.  The patches are on my web
page: http://members.home.com/minyard

This is if anyone is interested.  I don't know if anyone has any
interest in putting these into the main kernel.  The patches are only
turned on if the configuration option is set on, so it shouldn't
affect anything otherwise.

Patches are against 2.4.0-test10 and 2.2.16.  I have not tested the
2.2.16 patch yet.

Some text from the web page:

The current method of measure CPU usage of a process in Linux is crude
at best.  For most applications, that is fine, but for some it is
critical to know how much CPU you have used.  Also, using setitimer's
viritual timers have a rather crude measurement mechanism, if the
timer tick hits when the task is running then an entire tick is added
to the processes time.  It's actually possible to use no CPU and still
time out.  CPU measurement is done the same way.

The following patch fixes all that.  They add a kernel configuration
parameter that allows high-resolution (microsecond) timing of task CPU
usage.  There are a few caveats:

 * It only works on PowerPC right now.  If someone wants to do an
   Intel port (or another platform port), feel free to send me the
   patches.

 * It costs extra time in interrupts, exceptions, and system calls.
   There is no real way around this, to accurately count system time
   verses user time you have to know when the kernel is running verses
   the user process.  (If you don't enable the configuration option,
   there is no affect from the patch)

 * There is some wierd interaction with gettimeofday.  If I have a
   loop calling gettimeofday, the system doesn't seem to keep time
   properly.  I haven't figured this out yet.  It may not be this
   patch, either.  As long as you don't use gettimeofday a few
   thousand times a second, though, you should be ok.

 * The patches are new and, of course, experimental.  They may crash
   your system and destroy all your data.

 * I have not tested the 2.2.16 patch at all, I have just gotten it to
   compile.


Corey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
