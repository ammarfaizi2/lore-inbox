Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSBRWRS>; Mon, 18 Feb 2002 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288342AbSBRWRJ>; Mon, 18 Feb 2002 17:17:09 -0500
Received: from tomts24-srv.bellnexxia.net ([209.226.175.187]:63684 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288174AbSBRWQv>; Mon, 18 Feb 2002 17:16:51 -0500
Date: Mon, 18 Feb 2002 17:16:50 -0500 (EST)
From: Craig <penguin@wombat.ca>
X-X-Sender: carsnau@wombat
To: linux-kernel@vger.kernel.org
Subject: Serial Console changes in linux 2.4.15??
Message-ID: <Pine.LNX.4.42.0202181657240.23209-100000@wombat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have run into a problem with using my serial port as a console in linux
2.4.17, and tracked down the change.  Just wondering if anyone could shed some
light on the situation.  Here's the scoop:

In Linux 2.4.10 -> 2.4.14 (and probably earlier than 2.4.10, but i didn't
check) my serial console port works just fine.  I then started using 2.4.17 and
the serial port would continue to spit out output, but would not accept any
input.   I turned on the debugging statements and traced the problem down to the
following piece of code from "drivers/char/serial.c".

function -> "change_speed"

#if 0 /* breaks serial console during boot stage */
        /*
         * !!! ignore all characters if CREAD is not set
         */
        if ((cflag & CREAD) == 0)
                info->ignore_status_mask |= UART_LSR_DR;
#endif


The "#if 0" statements exist in 2.4.10 -> 2.4.14.
In Linux 2.4.15, the "#if 0" statements were removed, so now that code is hit,
and all the input characters are now ignored.
It is still missing in 2.4.16 & 2.4.17.
If i manually put the lines back (the "#if 0" and "#endif"), then my serial
console works just fine.

Did someone submit serial.c with the "#if 0" lines removed by accident?
I did look at the 2.4.15 changelog and could not see any changes regarding this.

My other question is: Why does this break the serial console?
Someone must have know it has that affect in 2.4 because of the comment that is
in the "#if 0" line.  Any idea what is causing 'cflag' to be improperly set in
the serial driver?
I'd much prefer to fix the root problem, as opposed to putting in the "#if 0"
work-around.

Any ideas or pointers would be most appreciated.
Thanks.

--
Craig.
+------------------------------------------------------+
http://www.wombat.ca               Why? Why not.
http://www.washington.edu/pine/    Pine @ the U of Wash.
+-------------=*sent via Pine4.42*=--------------------+





