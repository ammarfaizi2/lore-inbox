Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSGAMMb>; Mon, 1 Jul 2002 08:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSGAMMa>; Mon, 1 Jul 2002 08:12:30 -0400
Received: from mons.uio.no ([129.240.130.14]:2971 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S315487AbSGAMM3>;
	Mon, 1 Jul 2002 08:12:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: Fragment flooding in 2.4.x/2.5.x
Date: Mon, 1 Jul 2002 14:14:50 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200206281821.WAA00420@mops.inr.ac.ru>
In-Reply-To: <200206281821.WAA00420@mops.inr.ac.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207011414.50465.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 June 2002 20:21, Alexey Kuznetsov wrote:
> Hello!
>
> > suddenly jump to ~4.5MB/s (peak was 5MB/s).
>
> Hmm.. it is funny that you were satisfied with previous value
> and it is funny that it still does not saturate link.

It is only recently that we have come far enough with implementing things like 
round trip timing, congestion control, etc. to really start noticing these 
effects. Without the RTT scheme on the UDP link, you simply don't see it (you 
only notice a large difference with TCP).

Note that this covers the discrepancy between NFS over TCP and NFS over UDP 
against that particular machine, so I do not expect further improvements.
The main reason why I don't expect to saturate the link is that these are NFS 
*writes*, hence random things like file semaphore contentions, disk access 
and write speeds etc. on the server, pop up.

> Of course. If you noticed this year or two or three ago, it would be even
> an urgent problem. But until now it was problem with status of "well-known
> bogosity which requires some sane solution but can wait for some good idea
> for infinite time because of absence of any real applications sensing it"
> :-)

I've now got the application and a demonstration of what kind of fix is 
needed. I hope you and Dave can work out a better patch in for 2.4.20-pre  
;-)...

Cheers,
   Trond
