Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283916AbRL1RRI>; Fri, 28 Dec 2001 12:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284020AbRL1RRA>; Fri, 28 Dec 2001 12:17:00 -0500
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:20741
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S283916AbRL1RQu>; Fri, 28 Dec 2001 12:16:50 -0500
From: "Phil Oester" <kernel@theoesters.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.17 still croaks under heavy load
Date: Fri, 28 Dec 2001 09:16:49 -0800
Message-ID: <001c01c18fc3$6f97d260$6400a8c0@philxp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20011228120145.G1072@mea-ext.zmailer.org>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No RAID1 on disks.

Here's /proc/meminfo within 1 minute of the box dying last night:

        total:    used:    free:  shared: buffers:  cached:
Mem:  1054371840 1044684800  9687040        0  7802880 834752512
Swap: 535797760  7626752 528171008
MemTotal:      1029660 kB
MemFree:          9460 kB
MemShared:           0 kB
Buffers:          7620 kB
Cached:         811872 kB
SwapCached:       3316 kB
Active:         231880 kB
Inactive:       747344 kB
HighTotal:      131072 kB
HighFree:         1028 kB  <---------  See comment below
LowTotal:       898588 kB
LowFree:          8432 kB
SwapTotal:      523240 kB
SwapFree:       515792 kB

The HighFree value was at 2044 for the prior hour.  It went to 1028
within 1 minute of the box freezing.  Out of HighMem???

Here's vmstat within 30 seconds of freezing:

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 1  0  0   7448   9536   7616 812092   0   0   932     2  235   577  50
1  49

Seems VM related.

-Phil

-----Original Message-----
From: Matti Aarnio [mailto:matti.aarnio@zmailer.org] 
Sent: Friday, December 28, 2001 2:02 AM
To: Phil Oester
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 still croaks under heavy load


On Thu, Dec 27, 2001 at 11:06:50PM -0800, Phil Oester wrote:
> Have a webserver running Zope (specifically the ZEO db) which dies
every
> few days with no messages in syslog.  Locks up so tight a powercycle
is
> required to recover.  System has 1gb RAM, 2xSMP, kernel configured
with
> 4gb highmem.  

  Do you have RAID1 on the disks ?
  Apparently "noapic" option helps, e.g. breaking the SYMMETRIC part of
SMP.
  You may also try "nmi_watchdog=1", if you have serial console attached
  to the box for kernel message logging (and command).

> Since the kernel doesn't provide any info in syslog when it dies, I
just
> ran a vmstat 30 to a file and waited for the next untimely demise.
> Here's what happened when it died last time.  Note the sudden surge in
> disk activity (bi) 

   Yes, looks familiar.  My hangups have been during high disc activity
too.
   My box is located into a place into which I have difficult access,
e.g.
   I can't use it to collect the debug data, and do magics (press reset)
   to recover.

> I'd be more than willing to collect any other data required here, just
> let me know what would be of assistance.  Note though that I only have
> remote access to this box, so getting magic sysrq info could be
> difficult/impossible (tho I do have console access if that helps).
> 
> Thanks,
> 
> Phil Oester

/Matti Aarnio


