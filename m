Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTBFWGC>; Thu, 6 Feb 2003 17:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbTBFWGC>; Thu, 6 Feb 2003 17:06:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60940 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267628AbTBFWGA>; Thu, 6 Feb 2003 17:06:00 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: gcc -O2 vs gcc -Os performance
Date: Thu, 6 Feb 2003 22:12:51 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b1uml3$2af$1@penguin.transmeta.com>
References: <336780000.1044313506@flay> <224770000.1044546145@[10.10.2.4]> <1044553691.10374.20.camel@irongate.swansea.linux.org.uk> <263740000.1044563891@[10.10.2.4]>
X-Trace: palladium.transmeta.com 1044569721 16719 127.0.0.1 (6 Feb 2003 22:15:21 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Feb 2003 22:15:21 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <263740000.1044563891@[10.10.2.4]>,
Martin J. Bligh <mbligh@aracnet.com> wrote:
>>> All done with gcc-2.95.4 (Debian Woody). These machines (16x NUMA-Q) have 
>>> 700MHz P3 Xeons with 2Mb L2 cache ... -Os might fare better on celeron 
>>> with a puny cache if someone wants to try that out
>> 
>> gcc 3.2 is a lot smarter about -Os and it makes a very big size
>> difference according to the numbers the from the ACPI guys.
>> 
>> Im not sure testing with a gcc from the last millenium is useful 8)
>
>Still no use.
>/me throws gcc-3.2 in the trash can.
>
>2901299 vmlinux.O2
>2667827 vmlinux.Os

Well, Os is certainly smaller.  One thing to look out for is that
microbenchmarks for kernels are usually the _worst_ things to test with
Os.

That's since a large part of the premise of the -Os speed advantage is
that it is better for icache (usually not an issue for microbenchmarks)
and that it is better for load/startup times (generally not a huge issue
for kernels, since the real startup costs of kernels tend to be entirely
elsewhere).

So I suspect -Os tends to be more appropriate for user-mode code, and
especially code with low repeat rates.  Possibly the "low repeat rate"
thing ends up being true of certain kernel subsystems too.

Think of it this way: if you win 10% in size, you're likely to map and
load 10% less code pages at run-time. Which is not a big issue for
traditional data-centric loads, but can be a _huge_ deal for things like
GUI programs etc where there is often more code than data.

			Linus
