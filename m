Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273059AbRIIVZu>; Sun, 9 Sep 2001 17:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273060AbRIIVZk>; Sun, 9 Sep 2001 17:25:40 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:13624 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273059AbRIIVZ2>; Sun, 9 Sep 2001 17:25:28 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109092245240.3676-100000@sjoerd.sjoerdnet>
In-Reply-To: <Pine.LNX.4.33.0109092245240.3676-100000@sjoerd.sjoerdnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 09 Sep 2001 17:26:08 -0400
Message-Id: <1000070771.16805.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-09 at 17:07, Arjan Filius wrote:
> I tried 2.4.10-pre4+preempt+this-patch.
> Just booted up, and don't notice anything unusual.

very good so far...

> I found i do anly have a '#define HIGHMEM_DEBUG 1' in
> ./include/asm/highmem.h, which is default in 2.4.10-pre4.

OK, then no problem there.

> Booting up, X, compiling kernel.. no problems.

good...

> For speed, i DO notice other processes seem not to wait on that one
> programm which has much disk-access, so the (real) sluggish feeling has
> gone. This is however with the preempt patch, and the ctx_sw_ patch below
> seems only to affect stability in positive sense.

_GREAT_ ... now, the reason I asked if you notice any new slowdowns is
exactly what you seem to realize: I feared the ctx_sw patch may cause
obvious slowdown.  This could be because the ctw_on/offs are in the
wrong place, and causing much to much locking.

It seems like you notice no problems, and I am happy.

I am glad to hear this news, I am going to take a look at highmem's code
and then integrate a final solution into the preemption patch.

> Can you advice what and how to test performance/latency?
> The grafics/statistics on the websites you named are impressive..

Sure, you can run dbench <ftp://samba.org/pub/tridge/dbench/> try it
with around 16 threads (dbench -16).  You might also want to try playing
an mp3 in the background during this.  Notice it should not have large
skips (one user reporting 3s skipps dropping to 0.5s and 0s).

You can run the audio latency test
<http://www.gardena.net/benno/linux/latencytest-0.42.tar.gz>, although I
heard there are problems compiling it from some other preemption users.

Finally, simply time a kernel compile `time make dep clean bzImage' ...

We can use these for preemption enabled and disabled, highmem enabled
and disabled, etc...

Thank you for your help, 

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

