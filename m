Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280027AbRJ3RAf>; Tue, 30 Oct 2001 12:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280023AbRJ3RAP>; Tue, 30 Oct 2001 12:00:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19728 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280030AbRJ3RAH>; Tue, 30 Oct 2001 12:00:07 -0500
Date: Tue, 30 Oct 2001 18:00:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030180023.L1340@athlon.random>
In-Reply-To: <20011030162008.G1340@athlon.random> <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com> <20011030165119.I1340@athlon.random> <20011030113410.A29266@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011030113410.A29266@redhat.com>; from bcrl@redhat.com on Tue, Oct 30, 2001 at 11:34:10AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 11:34:10AM -0500, Benjamin LaHaise wrote:
> I'm contending is that the Real World difference between the correct 
> version of the optimization will have no significant performance effects 
> compared to the incorrect version that you and davem are so gleefully 
> advocating.  This means not running through "bullshit" benchmarks that 
> test one and only one thing, but running apps that actually put memory 
> pressure on the system (Oracle does so quite nicely using a filesystem 
> without O_DIRECT) which in turn causes page scanning (aka the clearing 
> of the referenced bit which is *THE* code that is being contested) but 
> should not cause swap out.  To me, this is just part of the methodology 
> of being thorough in testing the effects of changes to the VM subsystem.

There should be no relevant pagetable scanning during those tests, and
the few bits that can get unmapped have lots of time to get mapped in
again from the cache with a minor fault, IMHO there's no way such tlb
flush removal can make a difference in a DBMS workload on a sanely setup
machine, I'm amazed you think it can make a difference.

Andrea
