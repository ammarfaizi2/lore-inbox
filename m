Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267668AbTAaH2O>; Fri, 31 Jan 2003 02:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTAaH2O>; Fri, 31 Jan 2003 02:28:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:47057 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267668AbTAaH2N>;
	Fri, 31 Jan 2003 02:28:13 -0500
Date: Thu, 30 Jan 2003 23:38:15 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: [BENCHMARK] 2.5.59-mm6 with contest
Message-Id: <20030130233815.5b046799.akpm@digeo.com>
In-Reply-To: <200301311652.47715.conman@kolivas.net>
References: <200301311652.47715.conman@kolivas.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 07:37:33.0150 (UTC) FILETIME=[9DE9FFE0:01C2C8FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <conman@kolivas.net> wrote:
>
> I do believe these show that sequential reads are indeed scheduled before 
> writes with this kernel.  The question is, how long should they be scheduled 
> for?

No, Nick has some logic in there which remembers the last-submitted sector
and treats that as an insertion candidate as well.  That's unrelated to
the anticipatory code.

Which is all fine, but it needs some taming to prevent the obvious starvation
which can happen.

I'm going to nobble that for now.  There have been enormous gyrations in the
behaviour of the IO scheduler in recent months and I wish to get it settled
down to good all-round behaviour _without_ the anticipatory scheduler in
place.  Because there are fairly hairy issues surrounding the anticipatory
scheduler and device drivers - anticipatory scheduling may not get there.

I have spent some time this week tuning up and fixing the non-anticipatory
I/O scheduler and I'd like to stabilise that code for a while, to provide a
decent baseline against which to continue the anticipatory development.

In fact, the tuned-up scheduler performs respectably against the anticipatory
code.  Which isn't theoretically correct, and indicates that the anticipatory
code can be optimised further.


