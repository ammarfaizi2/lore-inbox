Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130777AbRCFNvM>; Tue, 6 Mar 2001 08:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130779AbRCFNvC>; Tue, 6 Mar 2001 08:51:02 -0500
Received: from picard.csihq.com ([204.17.222.1]:58009 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S130777AbRCFNux>;
	Tue, 6 Mar 2001 08:50:53 -0500
Message-ID: <02f901c0a644$61dca150$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Andre Hedrick" <andre@linux-ide.org>,
        "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Douglas Gilbert" <dougg@torque.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10103052310080.13719-100000@master.linux-ide.org>
Subject: Re: scsi vs ide performance on fsync's  
Date: Tue, 6 Mar 2001 08:50:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Write caching is the culprit for the performance diff:

On IDE:
time xlog /blah.dat fsync
0.000u 0.190s 0:01.72 11.0%     0+0k 0+0io 91pf+0w
# hdparm -W 0 /dev/hda

/dev/hda:
 setting drive write-caching to 0 (off)
# time xlog /blah.dat fsync
0.000u 0.220s 0:50.60 0.4%      0+0k 0+0io 91pf+0w
# hdparm -W 1 /dev/hda

/dev/hda:
 setting drive write-caching to 1 (on)
# time xlog /blah.dat fsync
0.010u 0.230s 0:01.88 12.7%     0+0k 0+0io 91pf+0w

On my SCSI setup:
# time xlog /usr5/blah.dat fsync
0.020u 0.230s 0:30.48 0.8%      0+0k 0+0io 91pf+0w


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Andre Hedrick" <andre@linux-ide.org>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Douglas Gilbert" <dougg@torque.net>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, March 06, 2001 2:12 AM
Subject: Re: scsi vs ide performance on fsync's


On Mon, 5 Mar 2001, Linus Torvalds wrote:

> Well, it's fairly hard for the kernel to do much about that - it's almost
> certainly just IDE doing write buffering on the disk itself. No OS
> involved.

I am pushing for WC to be defaulted in the off state, but as you know I
have a bigger fight than caching on my hands...

> I don't know if there is any way to turn of a write buffer on an IDE disk.

You want a forced set of commands to kill caching at init?

Andre Hedrick
Linux ATA Development
ASL Kernel Development
----------------------------------------------------------------------------
-
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

