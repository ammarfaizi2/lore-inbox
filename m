Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285288AbRLFXdU>; Thu, 6 Dec 2001 18:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285309AbRLFXdL>; Thu, 6 Dec 2001 18:33:11 -0500
Received: from bitmover.com ([192.132.92.2]:390 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285308AbRLFXc6>;
	Thu, 6 Dec 2001 18:32:58 -0500
Date: Thu, 6 Dec 2001 15:32:57 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net,
        davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206153257.T27589@work.bitmover.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
	alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net,
	davidel@xmailserver.org, rusty@rustcorp.com.au,
	Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
	lars.spam@nocrew.org, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206143218.O27589@work.bitmover.com> <E16C7QX-0003PC-00@the-village.bc.nu> <20011206151504.R27589@work.bitmover.com> <20011206.151945.57439059.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011206.151945.57439059.davem@redhat.com>; from davem@redhat.com on Thu, Dec 06, 2001 at 03:19:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 03:19:45PM -0800, David S. Miller wrote:
>    From: Larry McVoy <lm@bitmover.com>
>    Date: Thu, 6 Dec 2001 15:15:04 -0800
>    
>    Wait a second, you're missing something.  If you are going to make a single
>    OS image work on a 64 way (or whatever) SMP, you have all of these issues,
>    right?  I'm not introducing additional locking problems with the design.
> 
> And you're not taking any of them away from the VFS layer.  That is
> where all the real fundamental current scaling problems are in the
> Linux kernel.

Sure I am, but I haven't told you how.  Suppose that your current
VFS can handle N cpus byt you have N*M cpus.  Take a look at
http://bitmover.com/lm/papers/bigfoot.ps and imagine applying that
technique here.  To summarize what I'm proposing, the locking problems are
because too many cpus want at the same data structures at the same time.
One way to solve that is to fine grain thread the data structures, and
that is a pain in the ass.  Another way to solve it may be to "stripe"
the file "servers".  Imagine each CPU serving up a part of a bigfoot
file system.  I've just reduced the scaling problems by a factor of M.

And, the ccCluster approach moves most of the nasty locking
problems into a ccCluster specific filesystem rather than buggering up
the generic paths.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
