Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268564AbRHDOXE>; Sat, 4 Aug 2001 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268566AbRHDOWo>; Sat, 4 Aug 2001 10:22:44 -0400
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:6279 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S268564AbRHDOWd>; Sat, 4 Aug 2001 10:22:33 -0400
Message-ID: <028001c11cf0$e5becca0$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: "Linus Torvalds" <torvalds@transmeta.com>, "Ben LaHaise" <bcrl@redhat.com>
Cc: "Daniel Phillips" <phillips@bonn-fries.net>,
        "Rik van Riel" <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, "Andrew Morton" <andrewm@uow.edu.au>
In-Reply-To: <Pine.LNX.4.33.0108032330450.1193-100000@penguin.transmeta.com>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
Date: Sat, 4 Aug 2001 10:22:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing 2.4.8-pre4 -- MUCH better interactivity behavior now.
I've been testing ext3/raid5 for several weeks now and this is usable now.
My system is Dual 1Ghz/2GRam/4GSwap fibrechannel.
But...the single thread i/o performance is down.
Previously I was getting about 60MB/sec on one thread for Seq Read -- now
it's 40MB/sec.
Here's the run:
tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  40.62 73.8% 0.675 1.38% 27.08 43.6% 1.207 2.00%
   .     4000   4096    2  17.02 30.2% 0.761 1.63% 16.84 29.9% 1.270 1.78%
   .     4000   4096    4  14.96 26.8% 0.885 2.13% 13.75 31.2% 1.278 1.69%
   .     4000   4096    8  13.39 21.5% 0.952 2.48% 12.46 33.2% 1.188 1.48%

During the 4-thread run there was one long pause (instead of being totally
unusable before with even 2 threads).
Didn't notice any pauses during 8 threads.

I"m seeing a lot more CPU Usage for the 1st thread than previous tests --
perhaps we've shortened the queue too much and it's throttling the read?
Why would CPU usage go up and I/O go down?
Here's a previous test (only 1 thread as 2 threads became unusable).
         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  66.69 53.6% 0.829 1.43% 27.64 41.6% 1.287 0.74%

----- Original Message -----
From: "Linus Torvalds" <torvalds@transmeta.com>
To: "Ben LaHaise" <bcrl@redhat.com>
Cc: "Daniel Phillips" <phillips@bonn-fries.net>; "Rik van Riel"
<riel@conectiva.com.br>; <linux-kernel@vger.kernel.org>;
<linux-mm@kvack.org>
Sent: Saturday, August 04, 2001 2:37 AM
Subject: Re: [RFC][DATA] re "ongoing vm suckage"


>
> Well, I've made a 2.4.8-pre4.
>
> This one has marcelo's zone fixes, and my request suggestions. I'm writing
> email right now with the 8GB write in the background, and unpacked and
> patched a kernel. It's certainly not _fast_, but it's not too painful to
> use either.  The 8GB file took 7:25 to write (including the sync), which
> averages out to 18+MB/s. Which is, as far as I can tell, about the best I
> can get on this 5400RPM 80GB drive with the current IDE driver (the
> experimental IDE driver is supposed to do better, but that's not for
> 2.4.x)
>


