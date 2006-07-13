Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWGMOdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWGMOdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWGMOdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:33:44 -0400
Received: from outbound-haw.frontbridge.com ([12.129.219.97]:59341 "EHLO
	outbound5-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751545AbWGMOdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:33:43 -0400
X-BigFish: V
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
From: "Joachim Deguara" <joachim.deguara@amd.com>
To: "Pavel Machek" <pavel@suse.cz>
cc: "shin, jacob" <jacob.shin@amd.com>, "Andi Kleen" <ak@suse.de>,
       "Langsdorf, Mark" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
In-Reply-To: <20060713130604.GC8230@ucw.cz>
References: <B3870AD84389624BAF87A3C7B831499302935A76@SAUSEXMB2.amd.com>
 <20060713130604.GC8230@ucw.cz>
Date: Thu, 13 Jul 2006 16:32:12 +0200
Message-ID: <1152801132.4519.10.camel@lapdog.site>
MIME-Version: 1.0
X-Mailer: Evolution 2.6.0
X-OriginalArrivalTime: 13 Jul 2006 14:32:42.0077 (UTC)
 FILETIME=[32DDE0D0:01C6A689]
X-WSS-ID: 68A8860740W16587466-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 13:06 +0000, Pavel Machek wrote:
> Can you run two such tests *in parallel*? That seemed to break it
> really quickly.
parallel sounds fun, but I don't get it.  Two machine or trying to go
online and offline at the same time?  Firestorming two busy parallel
while loops, one turning the core offline and the other online, did not
bring an oops so I guess this kernel is in the clear in that regard.

I can't get it to crash again and I am afraid that it crashed under an
old devel kernel.  After another ~20 hour test with heavy freq changes
with the tscsync patch

CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 4 cycles, maxerr 499
cycles)
...
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -105 cycles, maxerr 600
cycles)
...
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -122 cycles, maxerr 1126
cycles)


after 5 hours of no PowerNow!

CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -3 cycles, maxerr 598
cycles)
...
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -124 cycles, maxerr 1129
cycles)
...
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -124 cycles, maxerr 1127
cycles)


huh?? I don't understand but it does not matter what I do or how long I
do it, the difference looks to always be about the same.  

-joachim



