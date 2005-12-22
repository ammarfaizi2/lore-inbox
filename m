Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVLVIDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVLVIDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVLVIDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:03:42 -0500
Received: from smtp103.plus.mail.mud.yahoo.com ([68.142.206.236]:27730 "HELO
	smtp103.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965123AbVLVIDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:03:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Udf2hm4gxayh3AsExt/8vNsQKeUG3OLyIoWerHTEwCWr6iaAxjfm0dXGsf05x8pbEKkR7S/4IJmJzGvV7rVlep7YJzd71D6TEW6/TCHz/EsCdjGaVAevhIX5N0Sg1OQfmTCs5a0J2WtpSELr+SezrfIqCmX4wF48h+slFJ2fYUQ=  ;
Message-ID: <43AA5DD4.1040606@yahoo.com.au>
Date: Thu, 22 Dec 2005 19:03:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2/5] mutex subsystem: add architecture specific mutex
 primitives
References: <20051221155411.GA7243@elte.hu> <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain> <20051221231218.GA6747@elte.hu> <Pine.LNX.4.64.0512220121440.26663@localhost.localdomain> <43AA5978.1060705@yahoo.com.au>
In-Reply-To: <43AA5978.1060705@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> I think ARMv6 has a decent atomic_cmpxchg implementation but does
> not define __HAVE_ARCH_CMPXCHG. It might be useful to try to use this
> for ARMv6 SMP for a slightly better trylock.
> 

And on UP builds, it may simply be best to open code an interrupt unsafe
cmpxchg and use atomic_cmpxchg unconditionally on SMP builds (which I
think generates half decent code on all SMP architectures).

Just something to think about. Of course this will require the dreaded
preempt_disable() which might make it a showstopper.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
