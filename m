Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133055AbRDZByd>; Wed, 25 Apr 2001 21:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133056AbRDZByY>; Wed, 25 Apr 2001 21:54:24 -0400
Received: from mailout4-1.nyroc.rr.com ([24.92.226.166]:12948 "EHLO
	mailout4-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S133055AbRDZByQ>; Wed, 25 Apr 2001 21:54:16 -0400
Message-ID: <004f01c0cdf4$f17f4ce0$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Michael Rothwell" <rothwell@holly-springs.nc.us>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.gh4u8sv.17i1q6@ifi.uio.no>
Subject: Re: #define HZ 1024 -- negative effects?
Date: Wed, 25 Apr 2001 22:02:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there any negative effects of editing include/asm/param.h to change
> HZ from 100 to 1024? Or any other number? This has been suggested as a
> way to improve the responsiveness of the GUI on a Linux system.

I have also played around with HZ=1024 and wondered how it affects
interactivity. I don't quite understand why it could help - one thing I've
learned looking at kernel traces (LTT) is that interactive processes very,
very rarely eat up their whole timeslice (even hogs like X). So more
frequent timer interrupts shouldn't have much of an effect...

If you are burning CPU doing stuff like long compiles, then the increased HZ
might make the system appear more responsive because the CPU hog gets
pre-empted more often. However, you could get the same result just by
running the task 'nice'ly...

The only other possibility I can think of is a scheduler anomaly. A thread
arose on this list recently about strange scheduling behavior of processes
using local IPC - even though one process had readable data pending, the
kernel would still go idle until the next timer interrupt. If this is the
case, then HZ=1024 would kick the system back into action more quickly...

Of course, the appearance of better interactivity could just be a placebo
effect. Double-blind trials, anyone? =)

Regards,
Dan

