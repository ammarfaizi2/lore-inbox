Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283672AbRK3POM>; Fri, 30 Nov 2001 10:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283664AbRK3PNz>; Fri, 30 Nov 2001 10:13:55 -0500
Received: from unknown.Level3.net ([63.210.233.154]:10757 "EHLO
	cinshrexc01.shermfin.com") by vger.kernel.org with ESMTP
	id <S283667AbRK3PNr>; Fri, 30 Nov 2001 10:13:47 -0500
Message-ID: <35F52ABC3317D511A55300D0B73EB8056FCC90@cinshrexc01.shermfin.com>
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: "'Ken Brownfield'" <brownfld@irridia.com>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: kupdated high load with heavy disk I/O
Date: Fri, 30 Nov 2001 10:13:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just as an FYI, I am now running 2.4.16 on my production box and it has been
running smooth since Monday afternoon.  The VM issues that I was having in
2.4.14 seemed to have been resolved.  Thanks again to everyone for their
help.

Regards,
Andy.

-----Original Message-----
From: Ken Brownfield [mailto:brownfld@irridia.com]
Sent: Monday, November 26, 2001 6:08 PM
To: Rechenberg, Andrew
Cc: 'linux-mm@kvack.org'; 'linux-kernel@vger.kernel.org'
Subject: Re: kupdated high load with heavy disk I/O


Yes, the extra swapping is more visible via kswapd in top, but as it was
explained to me (and time has confirmed in my experience) it's not the
performance hit that it may seem to be, and typically the opposite.
Linus posted an explanation for my similar question as part of the "[VM]
2.4.14/15-pre4 too "swap-happy"?" LKML thread.

Great to hear it solved your problem as well.
-- 
Ken.
brownfld@irridia.com

On Mon, Nov 26, 2001 at 10:08:27AM -0500, Rechenberg, Andrew wrote:
| Ken,
| 
| The 2.4.15pre7 kernel seems to have fixed my issue with kupdated and 4GB
| RAM.  We did some testing over the weekend and the box was still
interactive
| with a load of 7+.  There still seems to be a lot of swapping going on
| though.  I've read from previous threads that 2.4 uses swap more readily
| than 2.2 did, but should it use 10% of my swap and have almost 8MB
| SwapCached?
| 
| Here are some numbers for example:
| 
| [root@mybox ~]# cat /proc/meminfo
|         total:    used:    free:  shared: buffers:  cached:
| Mem:  4092899328 4082126848 10772480        0 12406784 3672317952
| Swap: 542826496 57561088 485265408
| MemTotal:      3996972 kB
| MemFree:         10520 kB
| MemShared:           0 kB
| Buffers:         12116 kB
| Cached:        3578108 kB
| SwapCached:       8140 kB
| Active:        2964668 kB
| Inactive:       877168 kB
| HighTotal:     3145720 kB
| HighFree:         2084 kB
| LowTotal:       851252 kB
| LowFree:          8436 kB
| SwapTotal:      530104 kB
| SwapFree:       473892 kB
| [root@mybox ~]# free
|              total       used       free     shared    buffers     cached
| Mem:       3996972    3986640      10332          0      12156    3577900
| -/+ buffers/cache:     396584    3600388
| Swap:       530104      56340     473764
| 
| 
| The above question is more for my personal knowledge, but I would like to
| know.
| 
| Thanks again for your help.
| 
| Regards,
| Andy.
| 
| 
| 
| -----Original Message-----
| From: Ken Brownfield [mailto:brownfld@irridia.com]
| Sent: Wednesday, November 21, 2001 12:07 PM
| To: Rechenberg, Andrew
| Subject: Re: kupdated high load with heavy disk I/O
| 
| 
| Yeah, the kswapd/kupdated issue was patched in -pre7:
| 
| 	 - me: modified Andrea VM page allocator tuning
| 
| -pre8 came out after I mailed you. ;-)  So unless it's mentioned it
| should stay in the kernel.
| 
| Of course, it's important to give it a try soon if you can, just to make
| sure that it _does_ solve your specific problem.  Especially before the
| kernel is handed off to Marcelo.
| 
| Thx,
| -- 
| Ken.
| 
| 
| On Wed, Nov 21, 2001 at 11:09:17AM -0500, Rechenberg, Andrew wrote:
| | Ken,
| | 
| | Thanks for the reply.  I would assume then that any future 15-pre kernel
| | would have the same fix?  I ask because pre8 is now the current 15-pre.
| | 
| | Thanks,
| | Andy.
| | 
| | -----Original Message-----
| | From: Ken Brownfield [mailto:brownfld@irridia.com]
| | Sent: Tuesday, November 20, 2001 6:09 PM
| | To: Rechenberg, Andrew
| | Subject: Re: kupdated high load with heavy disk I/O
| | 
| | 
| | Be sure to tru 2.4.15-pre7 which should fix your problem.
| | -- 
| | Ken.
| | brownfld@irridia.com
| | 
| | On Tue, Nov 20, 2001 at 05:58:44PM -0500, Rechenberg, Andrew wrote:
| | | I have to find time to down the box because it's production, but as
soon
| | as
| | | I do I'll post the numbers here.
| | | 
| | | Thanks for your help.	
| | | 
| | | Regards,
| | | Andy.
| | | 
| | | 
| | | > Could you please guys try to reproduce the problem with kernel
| profiling
| | | > turned on and send us the output of readprofile? 
| | | 
| | | > This way we can know which function is using more CPU time, thus we
| can
| | | > identify the problem. 
| | | 
| | | 
| | | On Wed, 14 Nov 2001, John McCutchan wrote:
| | | 
| | | > Hi,
| | | > 
| | | > I also have the exact same behaviour when running mkisofs. During
the 
| | | > creation of the ISO the interactive feel is sluggish and after
mkisofs
| | | > is complete the box is sluggish and appears to lock up. During
| | | > this sluggish period there is alot of disk activity. This is under
| | | > 2.4.14
| | | > 
| | | > John
| | | > On Wed, Nov 14, 2001 at 06:01:23PM -0500, Rechenberg, Andrew wrote:
| | | > > Hello,
| | | > > 
| | | > > I have read some previous threads about kupdated consuming 99% of
| CPU
| | | under
| | | > > intense disk I/O in kernel 2.4.x on the archives of linux-kernel
| | (April
| | | > > 2001), and some issues about I/O problems on linux-mm, but have
yet
| to
| | | find
| | | > > any suggestions or fixes.  I am currently experiencing the same
| issue
| | | and
| | | > > was wondering if anyone has any thoughts or suggestions on the
| issue.
| | I
| | | am
| | | > > not subscribed to the list so would you please CC: me directly on
| any
| | | > > responses?  I can also check out the archives at theaimsgroup.com
if
| a
| | | CC:
| | | > > would not be appropriate.  Thank you.
| | | > > 
| | | > > The issue that I am having is that when there is a heavy amount a
| disk
| | | I/O,
| | | > > the box becomes slightly unresponsive and kupdated is using 99.9%
in
| | | 'top.'
| | | > > Sometimes the box appears to totally lock up.  If one waits
several
| | | seconds
| | | > > to a couple of minutes the system appears to 'unlock' and runs
| | | sluggishly
| | | > > for a while.  This cycle will repeat itself until the I/O
subsides.
| | The
| | | > > memory usage goes up to the full capacity of the box and then
about
| | 10MB
| | | of
| | | > > swap is used while this problem is occurring.  Memory and swap
does
| | not
| | | get
| | | > > relinquished afer the incident.
| | | > > 
| | | > > The issue appears in kernel 2.4.14 compiled directly from source
| from
| | | > > kernel.org with no patches.  These problems manifest themselves
with
| | | only
| | | > > one user doing heavy disk I/O.  The normal user load on the box
can
| | run
| | | > > between 350-450 users so this behavior would be unacceptable
because
| | the
| | | > > application that is being run is interactive.  With 450 users, and
| the
| | | same
| | | > > process running on a 2.2.20 kernel the performance of the box is
| | great,
| | | with
| | | > > only a very slightly noticeable slow down.
| | | > > 
| | | > > I am running the Informix database UniVerse version 9.6.2.4 on a 4
| | | processor
| | | > > 700MHz Xeon Dell PowerEdge 6400.  The disk subsystem is controlled
| by
| | a
| | | PERC
| | | > > 2/DC RAID card with 128MB on-board cache (megaraid driver compiled
| | | directly
| | | > > in to the kernel).  Data array is on 5 36GB 10K Ultra160 disks in
a
| | | RAID5
| | | > > configuration.  The box has 4GB RAM, but is only using 2GB due to
| the
| | | move
| | | > > back to the 2.2 kernel.  The only kernel paramters that have been
| | | modified
| | | > > are in /proc/sys/kernel/sem.  All filesystems are ext2.
| | | > > 
| | | > > If you need any more detailed info, please let me know.  Any help
on
| | | this
| | | > > problem would be immensely appreciated.  Thank you in advance.
| | | > > 
| | | > > Regards,
| | | > > Andrew Rechenberg
| | | > > Network Team, Sherman Financial Group
| | | > > arechenberg@shermanfinancialgroup.com
| | | > > 
| | | > > --
| | | > > To unsubscribe, send a message with 'unsubscribe linux-mm' in
| | | > > the body to majordomo@kvack.org.  For more info on Linux MM,
| | | > > see: http://www.linux-mm.org/
| | | > > 
| | | > --
| | | > To unsubscribe, send a message with 'unsubscribe linux-mm' in
| | | > the body to majordomo@kvack.org.  For more info on Linux MM,
| | | > see: http://www.linux-mm.org/
| | | > 
| | | 
| | | --
| | | To unsubscribe, send a message with 'unsubscribe linux-mm' in
| | | the body to majordomo@kvack.org.  For more info on Linux MM,
| | | see: http://www.linux-mm.org/
| | | -
| | | To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
| in
| | | the body of a message to majordomo@vger.kernel.org
| | | More majordomo info at  http://vger.kernel.org/majordomo-info.html
| | | Please read the FAQ at  http://www.tux.org/lkml/
