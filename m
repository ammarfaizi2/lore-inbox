Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278692AbRJ1Vx6>; Sun, 28 Oct 2001 16:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRJ1Vxt>; Sun, 28 Oct 2001 16:53:49 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:4869 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S278692AbRJ1Vxd>;
	Sun, 28 Oct 2001 16:53:33 -0500
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100316b80221a2f45f@[192.168.239.101]>
In-Reply-To: <20011028191328.CCC828A6EA@pobox.com>
In-Reply-To: <20011028191328.CCC828A6EA@pobox.com>
Date: Sun, 28 Oct 2001 21:42:17 +0000
To: barryn@pobox.com, zlatko.calusic@iskon.hr
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
Cc: torvalds@transmeta.com (Linus Torvalds), axboe@suse.de (Jens Axboe),
        marcelo@conectiva.com.br (Marcelo Tosatti), linux-mm@kvack.org,
        linux-kernel@vger.kernel.org (lkml)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Unfortunately, things didn't change on my first disk (IBM 7200rpm
>>  @home). I'm still getting low numbers, check the vmstat output at the
>>  end of the email.
>>
>>  But, now I found something interesting, other two disk which are on
>>  the standard IDE controller work correctly (writing is at 17-22
>>  MB/sec). The disk which doesn't work well is on the HPT366 interface,
>>  so that may be our culprit. Now I got the idea to check patches
>  > retrogradely to see where it started behaving poorely.

>This really reminds me of a problem I once had with a hard drive of
>mine. It would usually go at 15-20MB/sec, but sometimes (under both
>Linux and Windows) would slow down to maybe 350KB/sec. The slowdown, or
>lack thereof, did seem to depend on the alignment of the stars. I lived
>with it for a number of months, then started getting intermittent I/O
>errors as well, as if the drive had bad sectors on disk.
>
>The problem turned out to be insufficient ventilation for the controller
>board on the bottom of the drive

As an extra datapoint, my IBM Deskstar 60GXP's (40Gb version) runs 
slightly slower with writing than with reading.  This is on a VIA 
686a controller, UDMA/66 active.  The drive also has plenty of air 
around it, being in a 5.25" bracket with fans in front.

Writing 1GB from /dev/zero takes 34.27s = 29.88MB/sec, 19% CPU
Reading 1GB from test file takes 29.64s = 34.58MB/sec, 18% CPU

Hmm, that's almost as fast as the 10000rpm Ultrastar sited just above 
it, but with higher CPU usage.  Ultrastar gets 36MB/sec on reading 
with hdparm, haven't tested write performance due to probable 
fragmentation.

Both tests conducted using 'dd bs=1k' on my 1GHz Athlon with 256Mb 
RAM.  Test file is on a freshly-created ext2 filesystem starting at 
10Gb into the 40Gb drive (knowing IBM's recent trend, this'll still 
be fairly close to the outer rim).  Write test includes a sync at the 
end.  Kernel is Linus 2.4.9, no relevant patches.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
