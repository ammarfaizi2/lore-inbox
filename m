Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292631AbSCRTpG>; Mon, 18 Mar 2002 14:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292617AbSCRTn4>; Mon, 18 Mar 2002 14:43:56 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:16388 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S292631AbSCRTnw>;
	Mon, 18 Mar 2002 14:43:52 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 18 Mar 2002 12:42:15 -0700
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020318124215.C4155@host110.fsmlabs.com>
In-Reply-To: <15507.9919.92453.811733@argo.ozlabs.ibm.com> <Pine.LNX.4.33.0203161020230.31850-100000@penguin.transmeta.com> <15507.63649.587641.538009@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a counter-proposal.  How about a hardware tlb load (if we must have
one) that does the right thing?  I don't think the PPC is a good example of
a hardware well-managed TLB load process.  Software loads show up so well
on the PPC because it does some very very foolish things I suspect.  I've
had some conversations with Moto engineers who have suggested that my
suspicion that the TLB loads are actually cached when the hardware does
them so that we waste cache space with an line that we better darn well not
be loading again (otherwise we've thrown out our tlb way too early).

I still think there are some clever tricks one could do with the VSID's to
get a much saner system that the current hash table.  It would take some
serious work I think but the results could be worthwhile.  By carefully
choosing the VSID scatter algorithm and the size of the hash table I think
one could get a much better access method.

} However, one good argument against software TLB loading that I have
} heard (and which you mentioned in another message) is that loading a
} TLB entry in software requires taking an exception, which requires
} synchronizing the pipeline, which is expensive.  With hardware TLB
} reload you can just freeze the pipeline while the hardware does a
} couple of fetches from memory.  And PPC64 remains the only
} architecture I know of that supports a full 64-bit virtual address
} space _and_ can do hardware TLB reload.
} 
} I would be interested to see measurements of how many cache misses on
} average each hardware TLB reload takes; for a hash table I expect it
} would be about 1, for a 3-level tree I expect it would be very
} dependent on access pattern but I wouldn't be surprised if it averaged
} about 1 also on real workloads.
} 
} But this is all a bit academic, the real question is how do we deal
} most efficiently with the real hardware that is out there.  And if you
} want a 7.5 second kernel compile the only option currently available
} is a machine whose MMU uses a hash table. :)
} 
} Paul.
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
