Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbSJGRm4>; Mon, 7 Oct 2002 13:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262264AbSJGRm4>; Mon, 7 Oct 2002 13:42:56 -0400
Received: from dsl-213-023-021-129.arcor-ip.net ([213.23.21.129]:42410 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262012AbSJGRmx>;
	Mon, 7 Oct 2002 13:42:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Oliver Neukum <oliver@neukum.name>,
       Andrew Morton <akpm@digeo.com>, Rob Landley <landley@trommello.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Mon, 7 Oct 2002 19:43:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]>
In-Reply-To: <1281002684.1033892373@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ybuZ-0003tz-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 October 2002 17:19, Martin J. Bligh wrote:
> > Then there's the issue of application startup. There's not enough
> > read ahead. This is especially sad, as the order of page faults is 
> > at least partially predictable.
> 
> Is the problem really, fundamentally a lack of readahead in the
> kernel? Or is it that your application is huge bloated pig? 

Readahead isn't the only problem, but it is a huge problem.  The current 
readahead model is per-inode, which is very little help with lots of small 
files, especially if they are fragmented or out of order.  There are various 
ways to fix this; they are all difficult[1].  Fortunately, we can call this 
"tuning work" so it can be done during the stable series.

[1] We could teach each filesystem how to read ahead across directories, or 
we could teach the vfs how to do physical readahead.  Choose your poison.

-- 
Daniel
