Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbSLRXjF>; Wed, 18 Dec 2002 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267460AbSLRXjF>; Wed, 18 Dec 2002 18:39:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:56009 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267459AbSLRXjE>;
	Wed, 18 Dec 2002 18:39:04 -0500
Message-ID: <3E0108F1.F80B7F43@digeo.com>
Date: Wed, 18 Dec 2002 15:46:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Torben Frey <kernel@mailsammler.de>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
References: <1040245847.3e00e457a4d66@kolivas.net> <3E00F3B4.7050209@mailsammler.de> <3E00F894.BDAB4E05@digeo.com> <3E010531.8020101@mailsammler.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 23:46:57.0686 (UTC) FILETIME=[C080DB60:01C2A6EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torben Frey wrote:
> 
> Hi Andrew, hi Con,
> 
> > Here's a diff against base 2.4.20.  It may be a little out of date
> > wrt Andrea's latest but it should tell us if we're looking in the
> > right place.
> Ok, I did not run the complete 2.4.20aa1 kernel yet since I am not sure
> if it is intended to be used, but I applied your patch, Andrew (thanks
> for mailing it). It still does not fix the problem. One job doing much
> I/O starts with about 80% CPU but then drops down to about 30% in the
> first 40 seconds. Load goes from 0.00 to 2.4 within that time.
> 
> And I can see bdflush and my process marked with "D" in the process list.
> 
> Catting the device to /dev/null only made it worse :-(
> 
> Creating a 1GB file using dd takes about 1 minute compared to 16 seconds
> without other jobs running.

err, now hang on.

I thought you said that this simple dd sometimes takes 14 seconds, 
and sometimes takes 4 minutes.

Please describe _exactly_ what activity is happening, and against
what disks when this problem exhibits.  The "other jobs".
  
> Do you think it could be a ReiserFS problem on a RAID?

Doubtful.  As far as reiserfs (and the block layer) is concerned,
your raid array is just a single disk (is this correct??)

> Do you know of anything else I could try?

Try a different filesystem

Try a dd to the blockdevice itself (or cat /dev/zero > /dev/sda1)

Run `vmstat 1' and send us the output which corresponds to
the poor throughput.

Try a different RAID mode.

Pull some disks out.
