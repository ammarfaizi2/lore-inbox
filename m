Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUDEWEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUDEWDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:03:16 -0400
Received: from webmail.sub.ru ([213.247.139.22]:19468 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S263484AbUDEWAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:00:18 -0400
Subject: 2.6.5-rc3-mm4 eats more CPU on disk i/o than 2.4 line (VIA chipset)
From: Mikhail Ramendik <mr@ramendik.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081202409.1036.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Tue, 06 Apr 2004 02:00:10 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After discussions in the "100% cpu use" thread, I have done some careful
testing, and updated the tools to see the difference between "system"
and "iowait" time. And I still see that the 2.6 line eats more CPU time
on disk I/O than the 2.4 line, albeit it also has better system
performance.

I have a system with a Duron 650 CPU, KT133 chipset, 256 MB RAM, Seagate
Barracuda 7200.7 HDD.

The testing procedure is as follows. I run an endless loop of copying a
file to the same directory (on ext3fs). In another window I run ubench
(http://www.phystech.com/download/ubench.html), a CPU benchmark (it also
can benchmark memory but I look at the CPU results; the memory footprint
is quite small at about 1.5MB, so I don't think swapping is a part of
the picture).

In a third window I look at top, running it as root to make sure I see
everything.

I used kernel 2.6.5-rc3-mm4. I tried running it with usual options and
with the deadline elevator. I also did the sate test under stock distro
(RH9-based) kernel 2.4.20, for comparison.

In 2.6.5-rc3-mm4, the 100% cpu use on copying  breaks down into "system"
and "iowait"; these two values vary over time but stay within some
bounds. When I run the benchmark, iowait falls to zero, apparently it
gets given over to the benchmark; the "system" is either unchanged or
climbs up about 5%.

The "system" CPU use varied over time. Without the deadline elevator, it
was jumping up and down within the range of 25% to 40%, occasionally
more; with the deadline elevator, significantly lower, at 20% to 25%.

In 2.4.20 iowait was shown as zero. The "system" CPU use was at 10% to
20%, and stayed within these borders when the benchmark was run.

And of course, the more "system" CPU usage there is, the less are the
results given by the benchmark. Therefore the results were highest on
2.4.20, and lowest on 2.6.4-rc3-mm4 without the deadline elevator. (The
proportion is quite simple so I don't include benchmark values here).

So, the 2.6.5-rc3-mm4 kernel took more CPU away for disk operation than
the 2.4.20 kernel. But on the other hand, disk performance is increased
(especially without the deadline evelator - and there the CPU usage is
highest too).

I am ready to do more benchmarking if and when necessary, to whatever
specs necessary. Just tell me what to try (no trojans ;)

I'm not sure if this is a genuine problem, or a valid trade-off of CPU
time for disk performance. The 2.6 line does seem more responsive when
disk operations are going on.

The final word here, of course, is with the developers. 

Yours, Mikhail Ramendik



