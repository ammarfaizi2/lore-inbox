Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTAUAti>; Mon, 20 Jan 2003 19:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbTAUAti>; Mon, 20 Jan 2003 19:49:38 -0500
Received: from unknown.Level3.net ([63.210.233.185]:46278 "EHLO
	cinshrexc03.shermfin.com") by vger.kernel.org with ESMTP
	id <S265008AbTAUAth> convert rfc822-to-8bit; Mon, 20 Jan 2003 19:49:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Processes hang in get_request_wait (2.4.18-19-7.xbigmem)
Date: Mon, 20 Jan 2003 19:58:21 -0500
Message-ID: <8075D5C3061B9441944E137377645118012E19@cinshrexc03.shermfin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Processes hang in get_request_wait (2.4.18-19-7.xbigmem)
Thread-Index: AcLA6DGMe8fG5xebR4yUqZ5AeyXeOQ==
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a database (IBM/Informix/Ardent UniVerse) that is running on a
Dell PowerEdge 6600 (stats below).  Sometimes when there is a very high
I/O, any database command shell will hang when trying to exit.  A ps
shows that the process is in a get_request_wait.

When the process that is causing the high I/O finishes what it is doing,
then about 5-10 seconds later the command shell that was trying to exit
will finish.  I've read some threads on the list and elsewhere and seen
some patches that refer to "fixing" get_request_wait and
wait_on_page/wait_on_buffer "bugs."

Could mounting file systems onto directories that are only accessible
after another file system is mounted cause an issue (nested mount
points)?  For example I have fs /dev/sdd1 that contains a directory
called 'dbms,' I then mount other filesystems onto directories contained
within dbms/:

/dev/sdd1   /cubs
/dev/sdc1	/cubs/dbms/ACCOUNT
/dev/sde1	/cubs/dbms/16kb

System specs are below.  I would try 2.4.20 vanilla, but for some reason
I get a panic WRT some SMP things when 2.4.20 boots, but that's another
issue that I will try to tackle on my own.

Is there anything that I can try (patches, /proc settings, etc.) to help
alleviate this issue?  Should I reconfigure my mount points?  If more
information is needed, please let me know.

Thanks in advance,
Andy.

Andrew Rechenberg
Infrastructure Team, Sherman Financial Group
arechenberg@shermanfinancialgroup.com

------------------------------------------------------------------------
-------
Dell PE6600
(4) Xeon 1.4GHz with HT enabled
8GB RAM
Red Hat 7.3
2.4.18-19-7.xbigmem with SD_TIMEOUT in sd.c upped to 90*HZ and
megaraid2.[c,h]
(2) Dell PERC3/QC (megaraid2 2.00.2) with most recent firmware
(1.74:3.27]
(1) Dell PERC3/DC (megaraid2 2.00.2)



[root@box ~]# ps -eo pid,stat,pcpu,nwchan,wchan=WIDE-WCHAN-COLUMN -o
args | grep wait
   20 DW    0.1 19e8a6 get_request_wait  [bdflush]
   21 DW    0.3 19e8a6 get_request_wait  [kupdated]
 1440 S     0.0 1217c8 wait4             -bash
 1580 S     0.0 1217c8 wait4             su -
 1581 S     0.0 1217c8 wait4             -bash
 1748 S     0.0 1217c8 wait4             -bash
 1850 S     0.0 1217c8 wait4             /bin/bash
 1918 S     0.0 1217c8 wait4             su -
 1919 S     0.0 1217c8 wait4             -bash
 2158 S     0.0 1217c8 wait4             /bin/bash
 2430 S     0.0 1217c8 wait4             -bash
 2611 S     0.0 1217c8 wait4             su -
 2612 S     0.0 1217c8 wait4             -bash
 2869 S     0.0 1217c8 wait4             -bash
 3013 S     0.0 1217c8 wait4             su -
 3014 S     0.0 1217c8 wait4             -bash
 3425 S     0.0 1217c8 wait4             su -
 3427 S     0.0 1217c8 wait4             -bash
 3534 S     0.0 1217c8 wait4             -bash
 3673 S     0.0 1217c8 wait4             su -
 3674 S     0.0 1217c8 wait4             -bash
 3753 S     0.0 1217c8 wait4             uv
 3853 D     6.7 19e8a6 get_request_wait  RESIZE -N ALECREDCBI1 18 29826
128
 3882 S     0.0 1217c8 wait4             uv
 3913 D     0.0 19e8a6 get_request_wait  uv
 3929 D     4.4 19e8a6 get_request_wait  RESIZE -N PFMODDEBTOR3 2 342313
8
 3939 D     0.2 19e8a6 get_request_wait  uv
 3954 D     0.1 19e8a6 get_request_wait  uv
 3956 S     0.0 14d79c pipe_wait         grep wait
