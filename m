Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSHBPf5>; Fri, 2 Aug 2002 11:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHBPf5>; Fri, 2 Aug 2002 11:35:57 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:37062 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315214AbSHBPf4>;
	Fri, 2 Aug 2002 11:35:56 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.42924.410428.28956@napali.hpl.hp.com>
Date: Fri, 2 Aug 2002 08:39:24 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: adjust prefetch in free_one_pgd()
In-Reply-To: <1028293461.18309.53.camel@irongate.swansea.linux.org.uk>
References: <200208020012.g720CdeJ017016@napali.hpl.hp.com>
	<1028293461.18309.53.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 02 Aug 2002 14:04:21 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> It isnt a case of PREFETCH_STRIDE - thats the optimal
  Alan> fetchahead. You must never prefetch an address beyond the end
  Alan> of an object. So you actually need two loops one prefetching,
  Alan> then one to finish the job off which does not prefetch.

  Alan> Otherwise one day your page ends up against the ISA or PCI
  Alan> address space or something else undesirable and on some cpus
  Alan> the prefetch then variously confuses the PCI device or
  Alan> corrupts the cache.

I thought the prefetches API intended this to be a safe operation?
It's definitely not an issue on ia64: there, prefetches against
uncached memory translations are automatically canceled.

Note that there are many other prefetches in the kernel which may end
up prefetch "invalid" addresses (though it may often be address 0
that's being prefetched; perhaps that OK even on arches where you may
not prefetch against ISA or PCI addresses).

  Alan> Prefetching stuff you don't need is bad manners anyway 8)

That would work for me (though it would increase code size).  My patch
was intended as a minimal fix for a rather obvious typo (or perhaps it
was a thinko... ;-).

	--david
