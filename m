Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281460AbRKTWri>; Tue, 20 Nov 2001 17:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281459AbRKTWr2>; Tue, 20 Nov 2001 17:47:28 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:35783 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S281453AbRKTWrM>; Tue, 20 Nov 2001 17:47:12 -0500
Message-ID: <03bb01c17213$887ccd30$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Rik van Riel" <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0111202019170.4079-100000@imladris.surriel.com>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 17:34:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uhhhh, read his original mail.  When using mmap() he had
> problems with the VM doing bad page replacement, while
> read() was smooth.

I should add that I did experiment with madvise(MADV_SEQUENTIAL) on the
mapping, and with madvise(MADV_WILLNEED) on pages about to be needed. These
had no effect. What *did* help with underruns was pre-touching each page in
a large block (120KB), before sending that block to the output device. At
that point I thought the mmap() code was getting to be more complicated that
it was worth so I just dropped back to read()...

The other day I recorded and played a seven-minute animation (1.6GB) on my
512MB machine, with only 240KB of buffering. Much to my surprise and
delight, there were no underruns, and the large sequential passes through
the file hadn't pushed anything else out of RAM.

BTW, all of the above pertains to one large mapping of the entire file to be
played. I didn't try mmap()/munmap() on a sliding window... I seem to
remember an MP3 player doing that. (I just tried looking at XMMS and
Freeamp - I *think* they are using read(), but strace seems to do bad things
with threaded programs, argh...)

Regards,
Dan

