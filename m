Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbSJ0VxL>; Sun, 27 Oct 2002 16:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbSJ0VxL>; Sun, 27 Oct 2002 16:53:11 -0500
Received: from h-66-166-207-249.SNVACAID.covad.net ([66.166.207.249]:60906
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262665AbSJ0VxJ>; Sun, 27 Oct 2002 16:53:09 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 27 Oct 2002 13:58:26 -0800
Message-Id: <200210272158.NAA03617@adam.yggdrasil.com>
To: akpm@digeo.com
Subject: Re: Pauses in 2.5.44 (some kind of memory policy change?)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Adam J. Richter" wrote:
>> 
>> ...
>>  1  0  2      0  45252  31420 142520    0    0     0     0 3573   349  9 38 53
>> 
>> ...Started /usr/bin/mail around here...
>> 
>>  1  0  2      0  30024  31420 157636    0    0     0     0 6540   510 20 80  0
>>  1  0  2      0  14908  31420 172544    0    0     0     0 6433   499 16 84  0
>>  3  0  2      0   9196  31420 178172    0    0     0 17152 6939   259  3 97  0
>>  1  0  1      0   2452  31420 185112    0    0     0  4056 4061   278  9 91  0
>>  0  0  0      0   2636  31420 184848    0    0     0     0 1294   195  2  6 92
>> 
>> ...Pause occurred around here...
>> 
>>  1  0  1      0   2664  31420 184848    0    0     0  4004 1766    55  0 44 56
>>  0  0  0      0   2676  31420 184848    0    0     0    40 1103   282  2  3 95
>>  0  0  0      0   2676  31420 184848    0    0     0     0 1064   169  0  0 100

>Sorry, don't know.

>It's possible that your X server got paged out, but the system
>doesn't seem to be under any sort of stress, and there's not
>much page reclaim happening and no evidence of executable pagein.

	I don't know exactly what the "bo" column represents, but I
find it surprising that *after* /usr/bin/mail has read my mail spool,
often after bo has dropped to near zero, and often after I have typed
a few characters to the mail prompt which have been echoed just fine,
then "bo" spikes back up and then I experience the ~1 second pause.
By the way, the mail program isn't even running at this point.  It is
waiting for input from the tty line discipline, and the echoing
resumes without my having to hit the return key.

>I'm assuming that everything is on local disks apart from that
>mail file.  Really, you haven't told me much.  What's all that
>`bo' activity there?  What filesystems are in use?

	My home directory is on NFS via autofs.  The mail spool is on
NFS.  Everything else is on local ext3 partitions.

>Could it be a networking problem?  Are your keyboard and mouse
>dependent on ethernet traffic in any way (eg: executables on
>NFS).

	I have already checked with tcpdump.  No significant network
traffic addressed to my machine's ethernet interface occurs during
this time.

>Did the vmstat output exhibit any stalls?

	Yes. It stalled with the keyboard and mouse.  I'm pretty sure
everything is stalled.

>What makes you believe it's a vm/fs thing rather than a keyboard/mouse
>thing?

	Everything seems to stall at the same time, the second jump in
the "bo" number when the pause occurs, the fact that it occurs *after*
the big IO is done and ~24MB of RAM has been allocated.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
