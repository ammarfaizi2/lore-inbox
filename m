Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287531AbSASWPt>; Sat, 19 Jan 2002 17:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSASWPj>; Sat, 19 Jan 2002 17:15:39 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:65267 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S287531AbSASWPU>; Sat, 19 Jan 2002 17:15:20 -0500
Message-ID: <048201c1a136$c292c8b0$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "Ken Brownfield" <brownfld@irridia.com>,
        "Rik van Riel" <riel@conectiva.com.br>,
        =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201171721230.32617-100000@imladris.surriel.com> <012d01c19fb7$ba1cb680$02c8a8c0@kroptech.com> <20020118182837.D31076@asooo.flowerfire.com> <02f801c1a0a7$5643a1a0$02c8a8c0@kroptech.com> <20020119185016.F21279@athlon.random> <03c501c1a118$9d0dd120$02c8a8c0@kroptech.com> <20020119212134.G21279@athlon.random>
Subject: Re: [PATCH *] rmap VM 11c (RMAP IS A WINNER!)
Date: Sat, 19 Jan 2002 17:15:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 19 Jan 2002 22:15:10.0710 (UTC) FILETIME=[C2884160:01C1A136]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andrea, the previous version of this mail wasn't supposed to go out yet. I
fat-fingered and sent it before I was done. This is the full version.)

Andrea Arcangeli:
> On Sat, Jan 19, 2002 at 01:39:22PM -0500, Adam Kropelin wrote:
> > Andrea Arcangeli:
> > > With -aa something sane along the above lines is:
> > >
> > > /bin/echo "10 2000 0 0 500 3000 30 5 0" > /proc/sys/vm/bdflush
> >
> > Unfortunately, those adjustments on top of 2.4.18-pre2aa2 set a new record
for
> > worst performance: 7:19.
>
> then please try to decrease the nfract variable again, the above set it
> to 2000, if you've a slow harddisk maybe that's too much, so you can try
> to set it to 500 again.

Yes, the harddisk is definitely slow: it's a hw RAID5 partition with older
drives, so writes are pretty slow.

I tried various nfract settings:

/bin/echo "10 300 0 0 500 3000 30 5 0" > /proc/sys/vm/bdflush
7:33

/bin/echo "10 500 0 0 500 3000 30 5 0" > /proc/sys/vm/bdflush
6:00

/bin/echo "10 800 0 0 500 3000 30 5 0" > /proc/sys/vm/bdflush
7:17

nfract=500 seems to be the best and gets much closer to the performance of rmap
and -ac. Writeout is still very bursty compared to the other kernels, but that
may not really matter, I don't know.

> I'd also give a try with the below settings:
>
> /bin/echo "10 500 0 0 500 3000 80 8 0" > /proc/sys/vm/bdflush

7:08

<snip>

> Also just in case, I'd suggest to try to repeat each benchmark three
> times, so we know we are not bitten by random variations in the numbers.

I've been doing a variation on that theme already. The numbers I've been
reporting are best of 2 runs. I have never seen the 2 runs differ by more than
+/- 10 seconds.

--Adam



