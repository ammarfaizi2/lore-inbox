Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317626AbSFRVUM>; Tue, 18 Jun 2002 17:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSFRVUM>; Tue, 18 Jun 2002 17:20:12 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:44551 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S317626AbSFRVUL>;
	Tue, 18 Jun 2002 17:20:11 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Tue, 18 Jun 2002 15:08:40 -0600
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020618150840.Q13770@host110.fsmlabs.com>
References: <E17KPdj-0004EP-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0206181334500.981-100000@home.transmeta.com> <20020618171200.G16091@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020618171200.G16091@redhat.com>; from bcrl@redhat.com on Tue, Jun 18, 2002 at 05:12:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with you there.  It's not easy, and I'd claim it's not possible
given that no-one has done it yet, to have a select() call that is speedy
for both 0-10 and 1k file descriptors.


} I take issue with the statement that select scales fine to thousands of 
} file descriptors.  It doesn't.  For fairly trivial workloads it degrades 
} to 0 operations per second with more than a few dozen filedescriptors in 
} the array, but only one descriptor being active.  To sustain decent 
} throughput, select needs something like 50% of the filedescriptors in an 
} array to be active at every select() call, which makes in unsuitable for 
} things like LDAP servers, or HTTP/FTP where the clients are behind slow 
} connections or interactive (like in the real world).  I've benchmarked 
} it -- we should really include something like /dev/epoll in the kernel 
} to improve this case.
} 
} Still, I think the bitmap approach in this case is useful, as having 
} affinity to multiple CPUs can be needed, and it is not a frequently 
} occuring operation (unlike select()).
} 
} 		-ben
} -- 
} "You will be reincarnated as a toad; and you will be much happier."
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
