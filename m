Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTAaWMr>; Fri, 31 Jan 2003 17:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTAaWMq>; Fri, 31 Jan 2003 17:12:46 -0500
Received: from mail009.syd.optusnet.com.au ([210.49.20.137]:38830 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S262604AbTAaWMp> convert rfc822-to-8bit; Fri, 31 Jan 2003 17:12:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Date: Sat, 1 Feb 2003 09:21:59 +1100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Alexander Zarochentcev <zam@namesys.com>
References: <200302010020.34119.conman@kolivas.net> <20030131110417.0b70858a.akpm@digeo.com> <3E3ACEA8.8070504@namesys.com>
In-Reply-To: <3E3ACEA8.8070504@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302010921.59861.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 Feb 2003 6:29 am, Hans Reiser wrote:
> Andrew Morton wrote:
> >Hans Reiser <reiser@namesys.com> wrote:
> >>compilation is not an effective benchmark anymore, not for Linux
> >>filesystems, they are all just too fast (or is it that the compilers are
> >>too slow?....)
> >
> >The point of this test is to measure interactions, and fairness.
> >
> >It answers the question "how much impact does heavy filesystem I/O have
> > upon other system activity?".
> >
> >The "other system activity" in this test is a kernel compile.  That is a
> >fairly reasonable metric, because it is sensitive to latencies in
> > servicing reads and it is sensitive to inappropriate page replacement
> > decisions.
> >
> >A more appropriate foreground load might be opening a word processor and
> >composing a short letter to Aunt Nellie, but that's harder to automate. 
> > We expect that reduced kernel compilation time will correlate with
> > lower-latency letter writing.
>
> I think the result of the test was that this was not a compelling reason
> for users selecting a particular one of the filesystems because they all
> did well enough at it.  Perhaps because of your code.:)
>
> However,  it is rather interesting for all the reasons you mention.
> There is indeed a tendency for benchmarks to discount the importance of
> latency, and this benchmark does not do that, which is good.  It is
> annoying to be unable to work while a big tar is running in the
> background, but few benchmarks capture that.
>
> We should test reiser4 against this next month, it would be
> interesting.  (It seems we finally fixed the Reiser4 performance problem
> that we hit in August, and now we just need to tweak the CPU usage a bit
> and we'll have something performing pretty decently in our next
> release....)

Actually the most "felt" of these loads is io_load and based on these results:
io_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext3        3       109     68.8    4       10.1    1.40
2559jfs         3       138     54.3    11      13.8    1.77
2559reiser      3       98      76.5    2       9.2     1.24
2559xfs         3       124     60.5    6       8.0     1.57

I'd say barring any concern about throughput which this doesnt claim to 
measure accurately reiserfs causes the least slowdown of the system  ;-)

I do have one more load which may be useful. dbench_load continually runs 
dbench in the background. I could throw that at it also.

Ext2 was left out for clarity because it wasn't a journalling fs but it's 
results are quite different to the journalled fss.

Con
