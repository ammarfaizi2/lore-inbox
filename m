Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290913AbSASFJA>; Sat, 19 Jan 2002 00:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290914AbSASFI4>; Sat, 19 Jan 2002 00:08:56 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:60916 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S290913AbSASFIg>; Sat, 19 Jan 2002 00:08:36 -0500
Message-ID: <02f801c1a0a7$5643a1a0$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Ken Brownfield" <brownfld@irridia.com>
Cc: "Rik van Riel" <riel@conectiva.com.br>,
        =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        <linux-kernel@vger.kernel.org>, "Andrea Arcangeli" <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.33L.0201171721230.32617-100000@imladris.surriel.com> <012d01c19fb7$ba1cb680$02c8a8c0@kroptech.com> <20020118182837.D31076@asooo.flowerfire.com>
Subject: Re: [PATCH *] rmap VM 11c (RMAP IS A WINNER!)
Date: Sat, 19 Jan 2002 00:08:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 19 Jan 2002 05:08:30.0959 (UTC) FILETIME=[56382FF0:01C1A0A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield:

> Do you get more even throughput with this:
>
> /bin/echo "10 0 0 0 500 3000 10 0 0" > /proc/sys/vm/bdflush
>
> It seems to help significantly for me under heavy sustained I/O load.

With a little modification, Ken's suggestion makes -rmap11c a winner on my test
case.

/bin/echo "10 0 0 0 500 3000 30 0 0" > /proc/sys/vm/bdflush

Switching to synchronous bdflush a little later than Ken did brings performance
up to ~2000 blocks/sec, which is similar to older -ac kernels. This writeout
rate is very consistent (even more so than -ac) and seems to be the top end in
all large writes to the RAID (tried FTP, samba, and local balls-to-the-wall "cat
/dev/zero >..."), which helps show that this is not a network driver or protocol
interaction.

The same bdflush tuning (leaving aa's additional parameters at their defaults)
on 2.4.18pre2aa2 yields some improvement, but rmap is consistently faster by a
good margin. 2.4.17 performs worse with this tuning and is pretty much eating
dust at this point.

Latest Results:
2.4.17-rmap11c: 5:41 (down from 6:58)
2.4.18-pre2aa2: 6:31 (down from 7:10)
2.4.17: 7:06 (up from 6:57)

Congrats, Rik and thanks, Ken!

--Adam


