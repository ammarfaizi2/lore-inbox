Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280011AbRJ3Qdz>; Tue, 30 Oct 2001 11:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280010AbRJ3Qdp>; Tue, 30 Oct 2001 11:33:45 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:32243 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280009AbRJ3Qde>; Tue, 30 Oct 2001 11:33:34 -0500
Date: Tue, 30 Oct 2001 11:34:10 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030113410.A29266@redhat.com>
In-Reply-To: <20011030162008.G1340@athlon.random> <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com> <20011030165119.I1340@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030165119.I1340@athlon.random>; from andrea@suse.de on Tue, Oct 30, 2001 at 04:51:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 04:51:19PM +0100, Andrea Arcangeli wrote:
> Anwyays this have _nothing_ to do at the very least with stability
> unlike the above subliminal messages are implying, see above, it can
> only potentially be less responsive under very heavy swap on ia64 and
> ppc (dunno sparc64?), period. mentioning real life workloads like Oracle
> and RHDB in relation to the tlb flush for the accessed bit is further
> subliminal bullshit, Oracle definitely isn't supposed to swap heavily
> during the benchmarks, and I'm sure it's not the case for mainline
> postrgres either (dunno about RHDB).

It has nothing to do with subliminal effects, but rather what kind of 
effect this microoptimization is going to have in the Big Picture.  What 
I'm contending is that the Real World difference between the correct 
version of the optimization will have no significant performance effects 
compared to the incorrect version that you and davem are so gleefully 
advocating.  This means not running through "bullshit" benchmarks that 
test one and only one thing, but running apps that actually put memory 
pressure on the system (Oracle does so quite nicely using a filesystem 
without O_DIRECT) which in turn causes page scanning (aka the clearing 
of the referenced bit which is *THE* code that is being contested) but 
should not cause swap out.  To me, this is just part of the methodology 
of being thorough in testing the effects of changes to the VM subsystem.

Frankly, I'm suitable unimpressed with the thoroughness of consideration 
and testing to the changes currently being pushed into the base tree.  
Again, this is why I'm not bothering to run base kernels.

		-ben
-- 
Fish.
