Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRKTVj4>; Tue, 20 Nov 2001 16:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281016AbRKTVji>; Tue, 20 Nov 2001 16:39:38 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:14519 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S281059AbRKTVjY>; Tue, 20 Nov 2001 16:39:24 -0500
Message-ID: <037701c1720a$159ee9a0$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.kmf405v.j74f21@ifi.uio.no> <fa.ns5ugpv.q02sbg@ifi.uio.no>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 16:26:57 -0500
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

> I bet they're getting mmap()d, like all mp3 programs seem to do

Just a note here - I see much fewer buffer underruns and more consistent
read-ahead/drop-behind behavior (i.e. no paging of other programs) when
using plain read(), as opposed to mmap(). This is in a video playback
program that pumps 3.6MB/sec!

MP3 datarates are less than 50KB/sec, so I don't really see why they stand
to benefit from mmap()... With mmap() you pay the extra cost of setting
up/tearing down the mapping, and the kernel->user copy is virtually
insignificant anyway (you already are paying for a single copy plus cache
pollution when moving the data from filesystem buffer to sound card DMA
buffer, so a second copy isn't a big deal)...

Regards,
Dan

