Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129398AbRAZCMh>; Thu, 25 Jan 2001 21:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAZCM1>; Thu, 25 Jan 2001 21:12:27 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:56583 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129398AbRAZCMR>; Thu, 25 Jan 2001 21:12:17 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 extreme slowdown and crash
Date: Thu, 25 Jan 2001 18:10:20 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHMENFEDAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been testing 2.4 on one of my webservers and it seems to exhibit an
extreme case of slowdowns every 2-3 days.  It slows down to the point where
I can't really type anything into the telnet screen (remotely admin'd).
However, when I was able to get a few commands to the system (w, memstat,
ps, free), it showed absolutely nothing out of the ordinary.  The system
runs like a breeze and then just _slows_ to a complete crawl.  Needless to
say, all the services also slowed down.  It's the second time it happened
since I started testing this new kernel.

A little background on the server:  It's a webserver that runs Apache and
MySQL.  It has ~896MB RAM, and runs with an Adaptec 2940U2W SCSI card and
several SCSI drives.  The system experiences a load average of about 1-2
throughout the day with the new kernel.  It used to experience load averages
of 8-14 with 2.2.17.  I don't make very much use of shared memory, and from
what I can tell, the system never swaps to swap space.  Below are the last
stats I was able to retrieve before power-cycling the system (nothing else I
could do to fix it.  It was unresponsive to a shutdown -r now).

uptime:

  4:53pm  up 2 days, 15 min,  4 users,  load average: 2.57, 1.87, 2.26


free:

             total       used       free     shared    buffers     cached
Mem:        899712     896924       2788          0      24476     331660
-/+ buffers/cache:     540788     358924
Swap:      1052248          0    1052248


Peering through the aftermath, syslog contains this:

Jan 25 02:59:54 omega kernel: reset_xmit_timer sk=f00c9680 1 when=0x3744,
caller
=c0218172
Jan 25 02:59:58 omega kernel: reset_xmit_timer sk=f00c9680 1 when=0x3087,
caller
...skipping...
Jan 25 16:53:27 omega named[182]: ns_req: sendto([141.133.112.25].53):
Resource
temporarily unavailable

[... manually shortened ... ]

Jan 25 16:53:27 omega named[182]: ns_req: sendto([65.24.0.167].46484):
Resource
temporarily unavailable
Jan 25 16:53:27 omega named[182]: ns_req: sendto([198.77.116.8].37441):
Resource
 temporarily unavailable
Jan 25 16:53:27 omega named[182]: ns_req: sendto([64.59.128.213].2102):
Resource
 temporarily unavailable
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@

[... manually shortened ... ]

^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@
^@^@^@^@^@^@^@^@Jan 25 18:01:02 omega syslogd 1.3-3#33.1: restart.
Jan 25 18:01:02 omega kernel: klogd 1.3-3#33.1, log source = /proc/kmsg
started.
Jan 25 18:01:02 omega kernel: Inspecting /boot/System.map-2.4.0
Jan 25 18:01:03 omega kernel: Loaded 15215 symbols from
/boot/System.map-2.4.0.
Jan 25 18:01:03 omega kernel: Symbols match kernel version 2.4.0.
Jan 25 18:01:03 omega kernel: No module symbols loaded.
Jan 25 18:01:03 omega kernel: Linux version 2.4.0 (root@omega) (gcc version
2.95
.2 20000220 (Debian GNU/Linux)) #1 SMP Fri Jan 19 23:03:21 PST 2001

Does anyone have any ideas as to what is causing this?  I will likely be
taking 2.4 out of testing and replacing it with good old 2.2.17 if I can't
resolve this problem.

--
Vibol Hou
KhmerConnection, http://khmer.cc
"Connecting Cambodian Minds, Art, and Culture"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
