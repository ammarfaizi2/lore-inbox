Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280556AbRKNMsJ>; Wed, 14 Nov 2001 07:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280583AbRKNMru>; Wed, 14 Nov 2001 07:47:50 -0500
Received: from picard.csihq.com ([204.17.222.1]:18583 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S280577AbRKNMrj>;
	Wed, 14 Nov 2001 07:47:39 -0500
Message-ID: <041101c16d0a$703c8700$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Odd meminfo 2.4.14
Date: Wed, 14 Nov 2001 07:46:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.4.14 (upgraded from 2.4.10) first time I've seen this (I run vmstat all
the time).

        total:    used:    free:  shared: buffers:  cached:
Mem:  526016512 519815168  6201344        0 653324288 18446744073256501248
Swap: 524279808 68616192 455663616
MemTotal:       513688 kB
MemFree:          6056 kB
MemShared:           0 kB
Buffers:        638012 kB
Cached:       4294515120 kB
SwapCached:       9744 kB
Active:          61300 kB
Inactive:       143752 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513688 kB
LowFree:          6056 kB
SwapTotal:      511992 kB
SwapFree:       444984 kB

I've got this exact same kernel on two other machines and they don't show
the funky cache #'s (yet).

I see in proc_misc.c that cache is printed with B(pg_size) in the first line
whereas it's printed with K(pg_size - swapper_space.nrpages) on the
"Cached:" line.
Both of them are wrong so it looks like pg_size is hosed somehow.

Also...pg_size is:
pg_size = atomic_read(&page_cache_size) - i.bufferram ;

What does pg_size have to do with bufferram????

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

