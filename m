Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262535AbTCMUrH>; Thu, 13 Mar 2003 15:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbTCMUrH>; Thu, 13 Mar 2003 15:47:07 -0500
Received: from comtv.ru ([217.10.32.4]:18427 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S262535AbTCMUrG>;
	Thu, 13 Mar 2003 15:47:06 -0500
X-Comment-To: sridhar vaidyanathan
To: sridhar vaidyanathan <sridharv@ufl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmaping /dev/mem
References: <1047515807.3e6fd29f92939@webmail.health.ufl.edu>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 13 Mar 2003 23:49:59 +0300
In-Reply-To: <1047515807.3e6fd29f92939@webmail.health.ufl.edu>
Message-ID: <m3bs0fat54.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> sridhar vaidyanathan (sv) writes:

 sv> I have a problem mmaping /dev/mem on some address in RAM. I am
 sv> aware of caveats,but I am trying to mmap a region which I am sure
 sv> is not in use by the kernel(some additional code does this and
 sv> returns a physical address which is what I use for mmap). The
 sv> mmap call itself succeeds and /proc/pid/maps also shows that
 sv> region, but I am unable to see what I write in target memory.I
 sv> also tried with the O_SYNC flag as I was wondering is caching had
 sv> anything to do with the results that I was seeing.No effect.
 sv> This however works with a mem= option and when the mmap region
 sv> falls out of the mem= boundary.  any clues?  Please cc as I am
 sv> not subscribed sridhar

look at mm/memory.c:remap_pte_range():

		if ((!VALID_PAGE(page)) || PageReserved(page))
 			set_pte(pte, mk_pte_phys(phys_addr, prot));

so, your pages aren't mapped at all and pte'es contain zero ...

