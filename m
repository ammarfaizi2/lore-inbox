Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAPQPv>; Tue, 16 Jan 2001 11:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAPQPl>; Tue, 16 Jan 2001 11:15:41 -0500
Received: from web5201.mail.yahoo.com ([216.115.106.95]:62738 "HELO
	web5201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129401AbRAPQPZ>; Tue, 16 Jan 2001 11:15:25 -0500
Message-ID: <20010116161522.2435.qmail@web5201.mail.yahoo.com>
Date: Tue, 16 Jan 2001 08:15:22 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: qlogicfc.c hard lockups in 2.4.0
To: cwl@iol.unh.edu
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a 20 drive raid0 set up off of two asus fiber
channel controllers using the qlogicfc.c driver.  (I
think it's a variant of ISP2200.)  Dual pentium 866
SMP machine, apparently stable under NT.  Half a gig
of ram, booting off of a different drive (hanging off
of an LSI1010 scsi controller not involved in the
raid, doubt that's involved).

The problem is that when I go:

time dd if=/dev/zero of=/root/raid/zerofile bs=1000000
count=8000

The sucker not only has visible bus stalls (the array
has lots of lights on the front), but sometimes the
whole machine locks hard (I.E. num-lock no longer
affecting the keyboard LEDs).

Before it goes bye-bye (and it doesn't always. 
Sometimes it finishes with lower throughput than it
should have...)  I get rather a lot of the following
in /var/log/messages:

Jan 16 03:40:55 dalek kernel: qlogicfc0 : no handle
slots, this should not happen.
Jan 16 03:40:55 dalek kernel: hostdata->queued is 4f,
in_ptr: 49
Jan 16 03:40:55 dalek kernel: qlogicfc0 : no handle
slots, this should not happen.
Jan 16 03:40:55 dalek kernel: hostdata->queued is 4f,
in_ptr 53

Repeat the above with in_ptr being 58, 5d, 6c, 76, 7b,
5, f, 19, 20, 2a, 2f, and 39.  At that point, the
machine achieved lockup and the next thing in the log
is syslog restarting from the (hard power off) reboot.

Help!  Should I enable any of the debugging macros in
qlogicfc.c?  I've reproduced this lockup three times
so far this morning.  It's rather annoying, but making
it happen again doesn't seem to be a problem...

Rob

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
