Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTJHJL5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 05:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTJHJL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 05:11:57 -0400
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:52744 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261276AbTJHJLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 05:11:51 -0400
From: Rex Coffin <rex@ieee.org>
Reply-To: rex@ieee.org
To: Andries.Brouwer@cwi.nl, bryce@obviously.com, util-linux@math.uio.no
Subject: 4294967295 - Re: Why would a valid DVD show zero files on Linux?
Date: Wed, 8 Oct 2003 10:13:34 -0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310081013.34465.rex@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been searching the net for a solution to the problem of reading my DVD 
drive correctly.

I am currently running Linux Kernel 2.4.20-8 with RedHat9.  I cannot read my 
DVD (/dev/cdrom) as a user using udf.

As a user with udf;

[rex@localhost rex]$ ll /mnt
dr--r--r--    5 4294967295 4294967295      312 Aug 19 10:03 cdrom
drwxr-xr-x    2 root     root         4096 Oct  4 16:18 cdrom1
...etc
[rex@localhost rex]$ ll /mnt/cdrom
ls: /mnt/cdrom/Autorun.inf: Permission denied
ls: /mnt/cdrom/PDFs: Permission denied
ls: /mnt/cdrom/pcw.exe: Permission denied
ls: /mnt/cdrom/Software: Permission denied
ls: /mnt/cdrom/xsys: Permission denied

As root with udf;

[root@localhost rex]# ll /mnt/cdrom
total 88
    1 4294967295 4294967295       49 Jun 27 10:45 Autorun.inf
-r--r--r--    1 4294967295 4294967295    74209 Aug 13 16:33 pcw.exe
dr--r--r--    3 4294967295 4294967295     5764 Aug 11 10:57 PDFs
dr--r--r--   10 4294967295 4294967295      520 Aug 13 13:59 Software
dr--r--r--   10 4294967295 4294967295     4032 Aug 11 10:58 xsys

The filenames are correct and I can navigate directories with long filenames 
OK.  Using Konqueror as a user I can of course see nothing.

As user or root with iso9660;

[rex@localhost rex]$ ll /mnt/cdrom
total 83
-r-xr-xr-x    1 root     root           49 Jun 27 10:45 autorun.inf
-r-xr-xr-x    1 root     root        74209 Aug 13 16:33 pcw.exe
dr-xr-xr-x    1 root     root         4096 Aug 11 10:57 pdfs
dr-xr-xr-x    1 root     root         2048 Aug 13 13:59 software
dr-xr-xr-x    1 root     root         4096 Aug 11 10:58 xsys

But Ialso get the Windoze short filenames;

[root@localhost rex]# ll /mnt/cdrom/software
total 20
dr-xr-xr-x    1 root     root         6144 Aug 14 11:25 essent~2
dr-xr-xr-x    1 root     root         2048 Aug 13 08:19 featured
dr-xr-xr-x    1 root     root         2048 Aug  8 14:13 fullso~1
dr-xr-xr-x    1 root     root         2048 Aug  8 15:31 games
dr-xr-xr-x    1 root     root         2048 Aug  8 13:00 groupt~1
dr-xr-xr-x    1 root     root         2048 Aug  8 13:39 handso~1
dr-xr-xr-x    1 root     root         2048 Aug 13 08:30 resour~1
dr-xr-xr-x    1 root     root         2048 Aug  8 08:53 trials~1

The problem appears to be the udf mounting the drive as owned by 
0x100000000-1.  This cannot be chown'ed as it is a ro drive.  Despite the 
apparent -r--r--r-- lisitng users cannot read it at all.  I cannot think of a 
good reason why it is not the same as the iso9660 drive  [drwxr-xr-x   root     
root]

I noticed that bryce@obviously.com had a very similar result in his tests 
(below).

Is there some way of changing the udf module to give the correct ownership and 
access rights to the mounted directories?

And could this correction become part of the standard linux Kernel?

Rex Coffin

___________________________________________
Re: Why would a valid DVD show zero files on Linux?

 
 
To: Andries.Brouwer@cwi.nl, bryce@obviously.com, util-linux@math.uio.no
 
Subject: Re: Why would a valid DVD show zero files on Linux?
 
From: Andries.Brouwer@cwi.nl
 
Date: Sat, 5 Jan 2002 17:16:22 GMT
 
Cc: linux-kernel@vger.kernel.org
 
Sender: linux-kernel-owner@vger.kernel.org
 
 
        From bryce@obviously.com Sat Jan  5 17:14:28 2002

        Here is the table of contents mounted three ways.  First udf, then
        iso9660, then iso9660 nojoliet.  Only the udf version works with the
        application.  Note that the huge udf filesizes are not a mistake -
        this DVD is also offered as 7 CD set.

[iso9660 nojoliet:]

        /mnt/cdrom1/data:
        total 22849
        dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
        dr-xr-xr-x    1 root     root         2048 Feb 28  2001 ..
        -r-xr-xr-x    1 root     root      1181228 Feb 28  2001 gridak.dat
        -r-xr-xr-x    1 root     root      1921298 Feb 28  2001 gridak.ind
        -r-xr-xr-x    1 root     root      3603453 Feb 28  2001 grid.dat
        -r-xr-xr-x    1 root     root       797273 Feb 28  2001 grid.ind
        -r-xr-xr-x    1 root     root        34839 Feb 28  2001 vec.cov
        -r-xr-xr-x    1 root     root     15153107 Feb 28  2001 vec.v
        -r-xr-xr-x    1 root     root       643405 Feb 28  2001 vec.vi

Hmm. I find

total 3266826
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 ..
-r-xr-xr-x    1 root     root     1832319997 Feb 28  2001 grid.dat
-r-xr-xr-x    1 root     root     51128921 Feb 28  2001 grid.ind
-r-xr-xr-x    1 root     root     34735660 Feb 28  2001 gridak.dat
-r-xr-xr-x    1 root     root      1921298 Feb 28  2001 gridak.ind
-r-xr-xr-x    1 root     root        34839 Feb 28  2001 vec.cov
-r-xr-xr-x    1 root     root     1424439251 Feb 28  2001 vec.v
-r-xr-xr-x    1 root     root       643405 Feb 28  2001 vec.vi

Could it be that you are using some old kernel, say, older than
2.4.13, that enables the "cruft" option when it sees a big file?
(You should see the corresponding messages in the logs.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


 
 

Re: Why would a valid DVD show zero files on Linux?

 
 
To: Andries.Brouwer@cwi.nl, bryce@obviously.com, util-linux@math.uio.no
 
Subject: Re: Why would a valid DVD show zero files on Linux?
 
From: Andries.Brouwer@cwi.nl
 
Date: Sat, 5 Jan 2002 17:16:22 GMT
 
Cc: linux-kernel@vger.kernel.org
 
Sender: linux-kernel-owner@vger.kernel.org
 
 
        From bryce@obviously.com Sat Jan  5 17:14:28 2002

        Here is the table of contents mounted three ways.  First udf, then
        iso9660, then iso9660 nojoliet.  Only the udf version works with the
        application.  Note that the huge udf filesizes are not a mistake -
        this DVD is also offered as 7 CD set.

[iso9660 nojoliet:]

        /mnt/cdrom1/data:
        total 22849
        dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
        dr-xr-xr-x    1 root     root         2048 Feb 28  2001 ..
        -r-xr-xr-x    1 root     root      1181228 Feb 28  2001 gridak.dat
        -r-xr-xr-x    1 root     root      1921298 Feb 28  2001 gridak.ind
        -r-xr-xr-x    1 root     root      3603453 Feb 28  2001 grid.dat
        -r-xr-xr-x    1 root     root       797273 Feb 28  2001 grid.ind
        -r-xr-xr-x    1 root     root        34839 Feb 28  2001 vec.cov
        -r-xr-xr-x    1 root     root     15153107 Feb 28  2001 vec.v
        -r-xr-xr-x    1 root     root       643405 Feb 28  2001 vec.vi

Hmm. I find

total 3266826
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 ..
-r-xr-xr-x    1 root     root     1832319997 Feb 28  2001 grid.dat
-r-xr-xr-x    1 root     root     51128921 Feb 28  2001 grid.ind
-r-xr-xr-x    1 root     root     34735660 Feb 28  2001 gridak.dat
-r-xr-xr-x    1 root     root      1921298 Feb 28  2001 gridak.ind
-r-xr-xr-x    1 root     root        34839 Feb 28  2001 vec.cov
-r-xr-xr-x    1 root     root     1424439251 Feb 28  2001 vec.v
-r-xr-xr-x    1 root     root       643405 Feb 28  2001 vec.vi

Could it be that you are using some old kernel, say, older than
2.4.13, that enables the "cruft" option when it sees a big file?
(You should see the corresponding messages in the logs.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


 
 
