Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312855AbSDBRQD>; Tue, 2 Apr 2002 12:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312858AbSDBRPx>; Tue, 2 Apr 2002 12:15:53 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:53405 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S312855AbSDBRPp>; Tue, 2 Apr 2002 12:15:45 -0500
Subject: some more nifty benchmarks
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 Apr 2002 12:15:40 -0500
Message-Id: <1017767745.464.32.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

benchmark url: http://www.gardena.net/benno/linux/audio/

The jam2 patch: http://giga.cps.unizar.es/~magallon/linux/kernel/

command used:  ./do_tests none 3 256 0 1400000000

System ram: Mem:  661925888

both kernels use the same config on the same system run with the same
apps open at the time of the test.  

Only one real issue is present.  Patching preempt to jam2 had big issues
with the new schedular, i had to remove all the preempting in sched.c. 
This sounds like it would disable preemption altogether but i did it
anyway in hopes that something still preempts.  Either way it didn't
hurt anything and worst case scenario is that it acts just like jam2
without any preempt patch applied.  

The results are quite interesting.
http://safemode.homeip.net/2.4.19-pre4-ac3-preempt/3x256.html

http://safemode.homeip.net/2.4.19-pre5-jam2-preempt/3x256.html

Max Latency:

As you can see, procfs latency has increased 2x with the jam2 patch.  
The jam2 patch uses AA's new vm patches and low latency patches. With
mostly schedular and vm changes in AA's patches, it seems more likely
something with pre5 hurting procfs performance, Although the changelog
is so cluttered with email addresses of every single submission
included, it's difficult to glance and see if any fs/procfs changes were
made.  

Anyway besides that anomoly we see expected improvements over non-low
latency kernels with the jam2 patch.  696ms goes to 80ms max latency. 
That's quite amazing, especially on a ext3fs that creates even more
overhead.

Disk copy also shows nearly a 3x improvement with the low latency
patches found in jam2.  

Probably the one everyone already expects to be the best.  The
read-lowlatency-2 patch takes 738ms down to 16.3ms.  

Basically this benchmark tells us nothing surprising or that wasn't
already expected except for the procfs slowdown.  Perhaps it was just a
fluke the couple times i ran it and i'll run it again.  Can anyone
comment on this change?  


Avg. Latency: 

We usually only care about max latency because that's what causes
noticable latency with users.  

What we see with average latency is that across the board, the
pre4-ac3-preempt kernel has a higher average of +/- 1ms latency than the
pre5-jam2-preempt kernel.  So even though the ac3 kernel has a higher
peak than the jam2 kernel in most places, it has a smaller deviation
from +/- 1ms latency than jam2.  Obviously those needing realtime only
care about their max latency but there has to be something to be said
about most of the time being spent between +/- 1ms on the non-low
latency kernel than on the low latency kernel.  



