Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271964AbRHVIsu>; Wed, 22 Aug 2001 04:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271965AbRHVIsl>; Wed, 22 Aug 2001 04:48:41 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:14596 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S271963AbRHVIs2>;
	Wed, 22 Aug 2001 04:48:28 -0400
Message-Id: <200108220848.f7M8mVh00441@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: i810 audio doesn't work with 2.4.9
Date: Wed, 22 Aug 2001 11:48:31 +0300
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15ZGQv-0008Qb-00@the-village.bc.nu>
In-Reply-To: <E15ZGQv-0008Qb-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 August 2001 21:39, Alan Cox wrote:
> > seems that i810_audio.c  from 2.4.7 and 2.4.8 works, but both from 2.4.9
> > and 2.4.8-ac8 does not ("suceeded" not to copy right version of this file
> > when testing previous time, so had one from 2.4.7 twice)
>
> Ok I'll take a glance at that. An strace of artsd failing would be useful

I'm including that at end of this message (a small fragment only):

Some other info:

Got incremental diffs between ac versions since 2.4.5.
Applied all diffs to 2.4.5 version of i810_audio.c except one between 2.4.6-ac1 and 2.4.6-ac2
As result i810 audio seems to work

So it seems that update of i810_audio.c between 2.4.6-ac1 and ac2 breaks it (at least for me).
But I think it still eating too much time (about 2-3% on PIII 700) when I'm not doing anything 
with sound but no more up to 90% as with unmodified version from 2.4.9 (maybe it's a problem
of artsd , I don't know)

Andris

---------------------------- i810_audio.c from 2.4.9  ----------------------------------------------------

09:22:28.328650 select(9, [4 6], [8], [6 8], {0, 119135}) = 1 (out [8], left {0, 120000})
09:22:28.328935 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff5ec) = 0
09:22:28.328984 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 608) = 96
09:22:28.329071 gettimeofday({998374948, 329087}, NULL) = 0
09:22:28.329116 gettimeofday({998374948, 329132}, NULL) = 0
09:22:28.329161 select(9, [4 6], [8], [6 8], {0, 118624}) = 1 (out [8], left {0, 120000})
09:22:28.329401 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff5ec) = 0
09:22:28.329450 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 592) = 80
09:22:28.329537 gettimeofday({998374948, 329553}, NULL) = 0
09:22:28.329582 gettimeofday({998374948, 329599}, NULL) = 0
09:22:28.329628 select(9, [4 6], [8], [6 8], {0, 118157}) = 1 (out [8], left {0, 120000})
09:22:28.329912 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff5ec) = 0
09:22:28.329964 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 608) = 96
09:22:28.330051 gettimeofday({998374948, 330067}, NULL) = 0
09:22:28.330096 gettimeofday({998374948, 330113}, NULL) = 0
09:22:28.330142 select(9, [4 6], [8], [6 8], {0, 117643}) = 1 (out [8], left {0, 120000})
09:22:28.330428 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff5ec) = 0
09:22:28.330476 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 600) = 88
09:22:28.330562 gettimeofday({998374948, 330579}, NULL) = 0
09:22:28.330607 gettimeofday({998374948, 330624}, NULL) = 0

------------------------   2.4.9 with i810_audio.c without patch between 2.4.6-ac1 to ac2  ------------------------------
 
11:38:04.550692 select(9, [4 6], [8], [6 8], {0, 87578}) = 1 (out [8], left {0, 90000})
11:38:04.550973 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff41c) = 0
11:38:04.551025 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
11:38:04.551116 gettimeofday({998469484, 551134}, NULL) = 0
11:38:04.551162 gettimeofday({998469484, 551180}, NULL) = 0
11:38:04.551207 select(9, [4 6], [8], [6 8], {0, 87062}) = 1 (out [8], left {0, 90000})
11:38:04.551488 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff41c) = 0
11:38:04.551540 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
11:38:04.551631 gettimeofday({998469484, 551648}, NULL) = 0
11:38:04.551676 gettimeofday({998469484, 551694}, NULL) = 0
11:38:04.551722 select(9, [4 6], [8], [6 8], {0, 86548}) = 1 (out [8], left {0, 90000})
11:38:04.552003 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff41c) = 0
11:38:04.552054 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
11:38:04.552146 gettimeofday({998469484, 552163}, NULL) = 0
11:38:04.552191 gettimeofday({998469484, 552209}, NULL) = 0
11:38:04.552236 select(9, [4 6], [8], [6 8], {0, 86033}) = 1 (out [8], left {0, 90000})
11:38:04.552518 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff41c) = 0
11:38:04.552569 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
11:38:04.552658 gettimeofday({998469484, 552676}, NULL) = 0
11:38:04.552703 gettimeofday({998469484, 552721}, NULL) = 0
11:38:04.552749 select(9, [4 6], [8], [6 8], {0, 85521}) = 1 (out [8], left {0, 90000})
11:38:04.553030 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff41c) = 0
11:38:04.553078 write(8, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 560) = 560
11:38:04.553166 gettimeofday({998469484, 553184}, NULL) = 0
11:38:04.553212 gettimeofday({998469484, 553230}, NULL) = 0
11:38:04.553258 select(9, [4 6], [8], [6 8], {0, 85012}) = 1 (out [8], left {0, 80000})
