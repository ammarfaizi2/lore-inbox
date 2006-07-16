Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946079AbWGPB4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946079AbWGPB4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 21:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946080AbWGPB4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 21:56:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5555 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1946079AbWGPB4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 21:56:48 -0400
Date: Sun, 16 Jul 2006 03:56:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Joachim Deguara <joachim.deguara@amd.com>
Cc: "shin, jacob" <jacob.shin@amd.com>, Andi Kleen <ak@suse.de>,
       "Langsdorf, Mark" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Message-ID: <20060716015636.GC21162@atrey.karlin.mff.cuni.cz>
References: <B3870AD84389624BAF87A3C7B831499302935A76@SAUSEXMB2.amd.com> <20060713130604.GC8230@ucw.cz> <1152801132.4519.10.camel@lapdog.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152801132.4519.10.camel@lapdog.site>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2006-07-13 at 13:06 +0000, Pavel Machek wrote:
> > Can you run two such tests *in parallel*? That seemed to break it
> > really quickly.
> parallel sounds fun, but I don't get it.  Two machine or trying to go
> online and offline at the same time?  Firestorming two busy parallel

Trying to online and offline at the same time.

> while loops, one turning the core offline and the other online, did not
> bring an oops so I guess this kernel is in the clear in that regard.

Better run two tight loops, each doing online; offline. I got reports
it crashed machines before, but maybe it is solved.

> I can't get it to crash again and I am afraid that it crashed under an
> old devel kernel.  After another ~20 hour test with heavy freq changes
> with the tscsync patch
> 
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff 4 cycles, maxerr 499
> cycles)
> ...
> CPU 2: Syncing TSC to CPU 0.
> CPU 2: synchronized TSC with CPU 0 (last diff -105 cycles, maxerr 600
> cycles)
> ...
> CPU 3: Syncing TSC to CPU 0.
> CPU 3: synchronized TSC with CPU 0 (last diff -122 cycles, maxerr 1126
> cycles)
> 
> 
> after 5 hours of no PowerNow!
> 
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff -3 cycles, maxerr 598
> cycles)
> ...
> CPU 2: Syncing TSC to CPU 0.
> CPU 2: synchronized TSC with CPU 0 (last diff -124 cycles, maxerr 1129
> cycles)
> ...
> CPU 3: Syncing TSC to CPU 0.
> CPU 3: synchronized TSC with CPU 0 (last diff -124 cycles, maxerr 1127
> cycles)
> 
> 
> huh?? I don't understand but it does not matter what I do or how long I
> do it, the difference looks to always be about the same.  
> 
> -joachim
> 
> 
> 

-- 
Thanks, Sharp!
