Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRAPGnA>; Tue, 16 Jan 2001 01:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRAPGmk>; Tue, 16 Jan 2001 01:42:40 -0500
Received: from gw33.sw.com.sg ([203.120.9.33]:59102 "EHLO relay1.sw.com.sg")
	by vger.kernel.org with ESMTP id <S129692AbRAPGmc>;
	Tue, 16 Jan 2001 01:42:32 -0500
X-Exchange-Loop: 1
thread-index: AcB/h5IuX1owUZy4RMqG8uZBTKs7Vw==
Message-ID: <3A63ED75.53094939@sw.com.sg>
Date: Tue, 16 Jan 2001 14:43:01 +0800
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: normal
From: "Vlad Bolkhovitine" <vladb@sw.com.sg>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: ru,en
MIME-Version: 1.0
To: "Mike Galbraith" <mikeg@wen-online.de>
Cc: "Zlatko Calusic" <zlatko@iskon.hr>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: mmap()/VM problems in 2.4.0
In-Reply-To: <Pine.Linu.4.10.10101152142440.772-100000@mikeg.weiden.de>
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2001 06:43:01.0341 (UTC) FILETIME=[9203D0D0:01C07F87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On 15 Jan 2001, Zlatko Calusic wrote:
> 
> > "Vlad Bolkhovitine" <vladb@sw.com.sg> writes:
> >
> > > Here is updated info for 2.4.1pre3:
> > >
> > > Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/sec
> > >
> > > with mmap()
> > >
> > >  File   Block  Num          Seq Read    Rand Read   Seq Write  Rand Write
> > >  Dir    Size   Size    Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> > > ------- ------ ------- --- ----------- ----------- ----------- -----------
> > >    .     1024   4096    2  1.089 1.24% 0.235 0.45% 1.118 4.11% 0.616 1.41%
> > >
[...]
> > > Mmap() performance dropped dramatically down to almost unusable level. Plus,
> > > system was unusable during test: "vmstat 1" updated results every 1-2 _MINUTES_!
> > >
> >
> > You need Marcelo's patch. Please apply and retest.
> 
> My box thinks quite highly of that patch fwiw, but insists that he needs
> to apply Jens Axboes' blk patch first ;-)  (Not because of tiobench)

New data:

2.4.1pre3 + Marcelo's patch

       File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     1024   4096    2  12.68 9.23% 0.497 0.92% 10.57 15.3% 0.594 1.44%

The same performance level as for 2.4.0. No improvement.

2.4.1pre3 + Marcelo's patch + Jens Axboes' blk-13B patch 

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     1024   4096    2  12.47 10.0% 0.504 1.13% 9.998 16.5% 0.735 2.21%

No significant difference, just noise. IMHO, it is expected, since 2 threads
simply aren't enough to launch blk patch's mechanisms

>         -Mike
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
