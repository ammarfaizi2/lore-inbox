Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSASSjz>; Sat, 19 Jan 2002 13:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286904AbSASSjq>; Sat, 19 Jan 2002 13:39:46 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:44528 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S286895AbSASSjg>; Sat, 19 Jan 2002 13:39:36 -0500
Message-ID: <03c501c1a118$9d0dd120$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "Ken Brownfield" <brownfld@irridia.com>,
        "Rik van Riel" <riel@conectiva.com.br>,
        =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201171721230.32617-100000@imladris.surriel.com> <012d01c19fb7$ba1cb680$02c8a8c0@kroptech.com> <20020118182837.D31076@asooo.flowerfire.com> <02f801c1a0a7$5643a1a0$02c8a8c0@kroptech.com> <20020119185016.F21279@athlon.random>
Subject: Re: [PATCH *] rmap VM 11c (RMAP IS A WINNER!)
Date: Sat, 19 Jan 2002 13:39:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 19 Jan 2002 18:39:22.0920 (UTC) FILETIME=[9D0C4A80:01C1A118]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli:
> On Sat, Jan 19, 2002 at 12:08:30AM -0500, Adam Kropelin wrote:
> > /bin/echo "10 0 0 0 500 3000 30 0 0" > /proc/sys/vm/bdflush
>   ^
>
> you cannot set the underlined one to zero (way too low, insane) or to
> left it to its default (20) in -aa, or it will be misconfigured setup
> that can lead to anything. the rule is:
>
> nfract_stop_bdflush <= nfract <= nfract_sync

<snip>

> so nfract_stop_bdflush cannot be 20.

Ok, thanks for straightening me out on that. I figured there might be some
consequence of  the additional knobs in -aa which I didn't know about.

> Furthmore you set ndirty to 0, that also is an invalid setup.

I didn't. That was one of the "additional parameters" that I left at the default
on -aa (500, it seems). Sorry, I should have been clearer about exactly what
settings I used on -aa; the quoted settings were for -rmap only. For reference,
the exact command I tried on -aa was:

/bin/echo "10 500 0 0 500 3000 30 20 0" > /proc/sys/vm/bdflush

> With -aa something sane along the above lines is:
>
> /bin/echo "10 2000 0 0 500 3000 30 5 0" > /proc/sys/vm/bdflush

Unfortunately, those adjustments on top of 2.4.18-pre2aa2 set a new record for
worst performance: 7:19.

An additional datapoint: The quoted bdflush settings which make 2.4.17-rmap11c a
winner do not do well at all on 2.4.17-rmap11a. Rik's initial reaction to the
issue was that there was a bug and I know he made some changes in rmap11c to
address it. The fact that 11c definitely performs better for me than 11a seems
to support this. Perhaps this bug or a variant thereof also exists in aa?

--Adam


