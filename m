Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278492AbRJ3Wlo>; Tue, 30 Oct 2001 17:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278489AbRJ3Wle>; Tue, 30 Oct 2001 17:41:34 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:65031 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S278511AbRJ3Wl3>;
	Tue, 30 Oct 2001 17:41:29 -0500
Date: Tue, 30 Oct 2001 15:36:21 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030153621.A19983@hq2>
In-Reply-To: <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com> <20011030095757.A9956@hq2> <15327.7716.638079.235753@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15327.7716.638079.235753@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 08:39:48AM +1100, Paul Mackerras wrote:
> Victor Yodaiken writes:
> 
> > You can't turn off hardware hash-chains on anything past 603, sadly enough.
> > So all Macs, many embedded boards, ...
> 
> All the 4xx, 8xx, and 82xx embedded PPC cpus use software TLB
> loading.  The 7450 has a mode bit to say whether to use a hash table
> or software TLB loading.  And the new "Book E" specification also
> mandates software-loaded TLBs.
> 
> That still leaves almost all of the current Macs and RS/6000s using a
> hash table, of course.  It does sound like providing at least the
> option to use software TLB loading is becoming common in new PPC
> designs.

But, as I understand it, not in PPC64 or in the mainline PC series.

What's really cool about the hashtable design is that each bucket will
have at most one useful piece of information but still fill an entire
cache line. 



> (And BTW they are not hash *chains*, there is no chaining involved.
> There is a primary bucket and a secondary bucket for any given
> address, each of which can hold 8 ptes.)

Which are almost certain to be unrelated, so two consecutive TLB misses
will almost certainly require two  fetches from main memory.
And, reusing a context requires a scrub of the hash table ..
Once you start down this slope, all sorts ofother disadvantages appear
for free.




> 
> Paul.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
