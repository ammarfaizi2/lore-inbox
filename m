Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRK0JmP>; Tue, 27 Nov 2001 04:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274789AbRK0JmE>; Tue, 27 Nov 2001 04:42:04 -0500
Received: from mail.science.uva.nl ([146.50.4.51]:55014 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S274368AbRK0Jlw>; Tue, 27 Nov 2001 04:41:52 -0500
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Date: Tue, 27 Nov 2001 10:38:53 +0100 (CET)
From: Kamil Iskra <kamil@science.uva.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with APM suspend and ext3
Message-ID: <Pine.LNX.4.33.0111270958320.3391-100000@krakow.science.uva.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Kernel 2.4.15 has problems with APM suspend if ext3 filesystem is compiled
into the kernel.

I noticed the problems on my just acquired Compaq Armada E500 notebook.
The problem was also there with kernel 2.4.14 + ext3 patch.  BUT I am
almost sure that it worked fine on my old Compaq Armada 7800 with the same
2.4.14 + ext3, so the problem might in some way be influenced by the
hardware/BIOS/whatever.

The problem is that, when I press the suspend button on the laptop or when
I invoke "apm -s", the screen blanks, but the laptop doesn't suspend.
After a second or two I get an error beep and the screen is back on again.
In the kernel log I get "User suspend" from "apmd", followed by "kernel:
apm: suspend: Unable to enter requested state", followed by "Normal
resume" from "apmd".  "apm -s" returns with "Input/output error" (EIO) in
this case.  The chance of a successful suspend is non-zero, but rather
small, I would say less than 10%.  Appending "apm=debug" on the kernel
commandline doesn't seem to add any useful info.

I've been starting my system (RedHat 7.2 on i686) in the single user mode,
starting just syslogd and apmd, but that doesn't help.  Neither does
changing the filesystem type back to ext2 in /etc/fstab: kjournald is
still started and the problem still occurs.  What does help is recompiling
the kernel without ext3: as soon as this happens, I get a 100% success
rate with suspends, either in single user mode or with all the daemons and
X running.  Just loading the ext3 into the kernel with "modprobe ext3"
doesn't seem to negatively affect it in that case, my guess would be that
that's due to kjournald not being started.

I tried to locate others with such problems via Google, and with some
success, although I can't be entirely sure that the reason for their
problems is the same as mine, of course.  Some examples would be:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100444185918459&w=2
http://groups.google.com/groups?hl=en&selm=9t28me%2416i6h0%241%40ID-106838.news.dfncis.de
http://groups.google.com/groups?q=apm+ext3&hl=en&rnum=1&selm=Pine.LNX.4.30.0111071331010.26250-100000%40fyspc-rp18.uio.no

So the problem does seem to be known among some, but somehow I couldn't
find a clear report in the linux-kernel archives about the issue.  Hence
this email.

If you reply, please Cc to me, as I'm not on the list.

Regards,

-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands

