Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316097AbSETQXJ>; Mon, 20 May 2002 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316098AbSETQXI>; Mon, 20 May 2002 12:23:08 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:13270 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S316097AbSETQXI>; Mon, 20 May 2002 12:23:08 -0400
Date: Mon, 20 May 2002 09:22:35 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
Message-ID: <1232903251.1021886554@[10.10.2.3]>
In-Reply-To: <3CE887CE.80E08048@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I expect this is a compound bug: sure, ZONE_NORMAL is clogged with
> inodes.  But I bet it's also clogged with buffer_heads.  If the
> buffer_head problem was fixed then the inode problem would occur
> much later. - more highmem, more/smaller files.

This should be easy to see from slabinfo. Note that the problem is
worse on a P4 - alignment takes us from 96 to 128 bytes.
 
> I've seen a vague report from the IBM team which indicates that 
> -aa VM does not solve the ZONE_NORMAL-full-of-buffer_heads lockup.  
> The workload was specweb on a 16 gig machine, I believe.

I haven't been very clear on this, mea culpa. We have two different
machines, each with 4 procs & 16Gb (at least). Both are exhausting
memory through buffer_heads. 

1) Running Oracle apps, doing raw IO. We are running an -aa kernel
on this machine, and it doesn't help. I believe that's just because
it's raw IO, though. We have some patches we did for TPC-H to fix
the raw IO problems with buffer_heads, and we'll be trying those
out this week.

2) Running specweb, doing non-raw IO. This is the machine we tried
Andrew's patch on and it worked a treat. We haven't tried the -aa
fix for this yet, I'll see if I can get that done this week.

So, we haven't really given Andrea's patch a fair test yet. If you
guys can agree which the better approach is by just discussing it,
great. If not, we'll benchmark the hell out of it, and decide things
that way ;-)

M
