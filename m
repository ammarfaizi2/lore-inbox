Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274832AbRJFBlO>; Fri, 5 Oct 2001 21:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274833AbRJFBlE>; Fri, 5 Oct 2001 21:41:04 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:62214 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S274832AbRJFBkz>;
	Fri, 5 Oct 2001 21:40:55 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15294.24873.866942.423260@cargo.ozlabs.ibm.com>
Date: Sat, 6 Oct 2001 11:40:57 +1000 (EST)
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Peter Rival <frival@zk3.dec.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, benh@kernel.crashing.org
Subject: Re: [PATCH] change name of rep_nop
In-Reply-To: <1573466920.1002300846@mbligh.des.sequent.com>
In-Reply-To: <15294.16913.2117.383987@cargo.ozlabs.ibm.com>
	<1573466920.1002300846@mbligh.des.sequent.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh writes:

> There *is* a race on x86 - the problem is that the primary cpu can 
> get to reschedule_idle before the secondarys have done init_idle.
> I'm not claiming the way I fixed it is beautiful, but the race definitely
> exists (I hit it) and the patch makes the problem go away. 

I meant that there isn't a race on x86 in pre4, now that we are using
your patch.  I didn't mean to say that there wasn't a race on x86
before your patch went in.

There is a race on PPC with your patch, but I can fix that by removing
the init_idle() call from smp_callin() in arch/ppc/kernel/smp.c.
At a quick glance it looks like alpha and sparc (sun4m) may have the
same problem since they also call init_idle before waiting for
smp_commence() (or smp_threads_ready != 0).

> Sounds like rep_nop was the wrong way to spin - aplogies.

Well it was just that the name was a bit x86-centric, and a bit
non-obvious, even to people who know a bit of x86 assembly (one could
be forgiven for thinking that rep nop was a slow way to set CX to 0).

Paul.
