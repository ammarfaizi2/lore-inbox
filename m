Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRHYSCq>; Sat, 25 Aug 2001 14:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270073AbRHYSCh>; Sat, 25 Aug 2001 14:02:37 -0400
Received: from mailg.telia.com ([194.22.194.26]:51165 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S270031AbRHYSCQ>;
	Sat, 25 Aug 2001 14:02:16 -0400
Message-Id: <200108251802.f7PI2Oh18565@mailg.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: =?iso-8859-1?q?G=E9rard=20Roudier?= <groudier@free.fr>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sat, 25 Aug 2001 19:56:33 +0200
X-Mailer: KMail [version 1.3]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010825130606.Q1086-100000@gerard>
In-Reply-To: <20010825130606.Q1086-100000@gerard>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturdayen den 25 August 2001 13:49, Gérard Roudier wrote:
> On Sat, 25 Aug 2001, Roger Larsson wrote:

> > Where did the seek time go? And rotational latency?
>
> They just go away, for the following reasons:
>
> - For random IOs, IOs are rather seek time bounded.
>   Tagged commands may help here.

> - For sequential IOs, the drive is supposed to prefetch data.
>

Ok, the disk does buffering itself (but it has less memory than . But will it 
do read ahead when
there is a request to do something else waiting?
Will it continue to read when it should have moved?
(Note: lets assume that the disk are never out of requests)
When it moves. The arm has to move and the platter will rotate to the right
spot - lets see. You can start reading directly when you are at the right
track. It can be stuff needed later... (ok, latency can be ignored)

> > This is mine (a IBM Deskstar 75GXP)
> > Sustained data rate (MB/sec)  37
> > Seek time  (read typical)
> >       Average (ms)             8.5
> >       Track-to-track (ms)      1.2
> >       Full-track (ms)         15.0
> > Data buffer                   2 MB
> > Latency (calculated 7200 RPM) 4.2 ms
> >
> > So sustained data rate is 37 MB/s
> >
> > > hdparm -t gives around 35 MB/s
> >
> > best I got during testing or real files is 32 MB/s

Note: the 32 MB/s is for reading two big file sequentially.
(first one then the other)
If I instead do a diff the two files the throughput drops
2.4.0 gave around 15 MB/s
2.4.7 gave only 11 MB/s
2.4.8-pre3 give around 25 MB/s (READA higher than normal)
2.4.9-pre2 gives 11 MB/s
2.4.9-pre4 gives 12 MB/s
My patch against 2.4.8-pre1 gives 28 MB/s

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
