Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284181AbRLFUVv>; Thu, 6 Dec 2001 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284182AbRLFUVX>; Thu, 6 Dec 2001 15:21:23 -0500
Received: from bitmover.com ([192.132.92.2]:9859 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284181AbRLFUVR>;
	Thu, 6 Dec 2001 15:21:17 -0500
Date: Thu, 6 Dec 2001 12:21:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206122116.H27589@work.bitmover.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
	phillips@bonn-fries.net, davidel@xmailserver.org,
	rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com,
	riel@conectiva.com.br, lars.spam@nocrew.org,
	alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206115338.E27589@work.bitmover.com> <E16C4r8-0000r0-00@starship.berlin> <20011206121004.F27589@work.bitmover.com> <20011206.121554.106436207.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011206.121554.106436207.davem@redhat.com>; from davem@redhat.com on Thu, Dec 06, 2001 at 12:15:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 12:15:54PM -0800, David S. Miller wrote:
>    From: Larry McVoy <lm@bitmover.com>
>    Date: Thu, 6 Dec 2001 12:10:04 -0800
> 
>    Huh?  Of course not, they'd use mutexes in a mmap-ed file, which uses
>    the hardware's coherency.  No locks in the vfs or fs, that's all done
>    in the mmap/page fault path for sure, but once the data is mapped you
>    aren't dealing with the file system at all.
> 
> We're talking about two things.
> 
> Once the data is MMAP'd, sure things are coherent just like on any
> other SMP, for the user.
> 
> But HOW DID YOU GET THERE?  That is the question you are avoiding.
> How do I look up "/etc/passwd" in the filesystem on a ccCluster?
> How does OS image 1 see the same "/etc/passwd" as OS image 2?
> 
> If you aren't getting rid of this locking, what is the point?
> That is what we are trying to talk about.

The points are:

a) you have to thread the entire kernel, every data structure which is a
   problem.  Scheduler, networking, device drivers, everything.  That's
   thousands of locks and uncountable bugs, not to mention the impact on
   uniprocessor performance.

b) I have to thread a file system.

So I'm not saying that I'll thread less in the file system (actually I am,
but let's skip that for now and assume I have to do everything you have
to do).  All I'm saying is that I don't have to worry about the rest of
the kernel which is a huge savings.

You tell me - which is easier, multithreading the networking stack to 
64 way SMP or running 64 distinct networking stacks?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
