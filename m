Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSAEQOz>; Sat, 5 Jan 2002 11:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288853AbSAEQOq>; Sat, 5 Jan 2002 11:14:46 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:15634 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S288852AbSAEQOe>;
	Sat, 5 Jan 2002 11:14:34 -0500
Message-ID: <3C372658.1B548E80@obviously.com>
Date: Sat, 05 Jan 2002 11:14:16 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl, util-linux@math.uio.no
CC: linux-kernel@vger.kernel.org
Subject: Re: Why would a valid DVD show zero files on Linux?
In-Reply-To: <UTC200201050250.CAA232926.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the table of contents mounted three ways.  First udf, then
iso9660, then iso9660 nojoliet.  Only the udf version works with the
application.  Note that the huge udf filesizes are not a mistake -
this DVD is also offered as 7 CD set.


/mnt/cdrom1/:
total 14
dr-xr-xr-x    3 4294967295 4294967295      184 Feb 28  2001 .
drwxr-xr-x   24 root     root         4096 Jan  5 10:27 ..
-r--r--r--    1 4294967295 4294967295     2763 Feb 28  2001 CD.TXT
dr-xr-xr-x    2 4294967295 4294967295      380 Feb 28  2001 DATA
-r--r--r--    1 4294967295 4294967295      196 Feb 28  2001 PDATASET.TXT

/mnt/cdrom1/DATA:
total 3266832
dr-xr-xr-x    2 4294967295 4294967295      380 Feb 28  2001 .
dr-xr-xr-x    3 4294967295 4294967295      184 Feb 28  2001 ..
-r--r--r--    1 4294967295 4294967295 34735660 Feb 28  2001 GRIDAK.DAT
-r--r--r--    1 4294967295 4294967295  1921298 Feb 28  2001 GRIDAK.IND
-r--r--r--    1 4294967295 4294967295 1832319997 Feb 28  2001 GRID.DAT
-r--r--r--    1 4294967295 4294967295 51128921 Feb 28  2001 GRID.IND
-r--r--r--    1 4294967295 4294967295    34839 Feb 28  2001 VEC.COV
-r--r--r--    1 4294967295 4294967295 1424439251 Feb 28  2001 VEC.V
-r--r--r--    1 4294967295 4294967295   643405 Feb 28  2001 VEC.VI


/mnt/cdrom1/:
total 1
dr-xr-xr-x    1 root     root            1 Feb 28  2001 .



/mnt/cdrom1/:
total 12
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
drwxr-xr-x   24 root     root         4096 Jan  5 10:27 ..
-r-xr-xr-x    1 root     root         2763 Feb 28  2001 cd.txt
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 data
-r-xr-xr-x    1 root     root          196 Feb 28  2001 pdataset.txt

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


As this is one clear example of differing iso9660 and udf views
of the same disc, I propose to change mount(8) and fstab(5) to warn the
two can be different (either intentionally, accidentally, or because
of iso9660 limitations).

I also propose to change "mount -t auto" to try udf first, and fall back to
iso9660.  This, of course, requires more discussion first.  But based
on serching other lists, reading the udf "iso9660 bridge" spec,
and email conversations, it seems to be the right long term answer.
Since udf is used on CD's, I propose that udf be tried first for
all meda, not just DVD's.

The kernel, of course, remains unchanged, and because you're using Linux,
you would still be able force mount anything you want.

			-Bryce



Andries.Brouwer@cwi.nl wrote:
> 
> > Here are the first 2048 1024 byte blocks.
> 
> Hmm. I am a bit slow, but just looked at this image.
> It looks fine in iso9660 style, provided you give the
> nojoliet option. I get:
> 
> # mount DeLorme_TopoUSA_DVD.head /mnt -t iso9660 -o loop,nojoliet
> # ls -l /mnt
> total 12
> dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
> drwxr-xr-x   31 root     root         4096 Jan  3 02:11 ..
> -r-xr-xr-x    1 root     root         2763 Feb 28  2001 cd.txt
> dr-xr-xr-x    1 root     root         2048 Feb 28  2001 data
> -r-xr-xr-x    1 root     root          196 Feb 28  2001 pdataset.txt
> 
> and
> 
> # mount DeLorme_TopoUSA_DVD.head /mnt -t udf -o loop
> # ls -l /mnt
> total 14
> dr-xr-xr-x    3 4294967295 4294967295      184 Feb 28  2001 .
> drwxr-xr-x   31 root     root         4096 Jan  3 02:11 ..
> -r--r--r--    1 4294967295 4294967295     2763 Feb 28  2001 CD.TXT
> dr-xr-xr-x    2 4294967295 4294967295      380 Feb 28  2001 DATA
> -r--r--r--    1 4294967295 4294967295      196 Feb 28  2001 PDATASET.TXT
> 
> so the iso9660 version looks a bit better than the udf version.
> (But I cannot look at the actual contents because the initial
> fragment is not large enough. You can check for yourself
> whether the nojoliet mount is OK.)
> 
> Thus, there do not seem reasons to change mount(2) or mount(8)
> in the way you suggested. There is no "empty iso9660 filesystem" here.
> 
> Andries
