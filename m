Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbVLVHpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbVLVHpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 02:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVLVHpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 02:45:05 -0500
Received: from smtp102.plus.mail.mud.yahoo.com ([68.142.206.235]:55391 "HELO
	smtp102.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965117AbVLVHpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 02:45:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=w/pexBkQ/xDuEv9UhZVYuBQB/+OL1SkxprdLSHjL5St0sdQs0aRCZElC4jUprCD/CA0Ii+HX+rWAovKU2GfhVAMcjLlsIMHM3ThMpRwNXjbBBVjvGii77k1uQVM9CDnPN2R0xGXFguChdTWFHoLudwyQssT1edbtNNiNNuGAvi4=  ;
Message-ID: <43AA5978.1060705@yahoo.com.au>
Date: Thu, 22 Dec 2005 18:44:56 +1100
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
References: <20051221155411.GA7243@elte.hu> <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain> <20051221231218.GA6747@elte.hu> <Pine.LNX.4.64.0512220121440.26663@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0512220121440.26663@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you now simply remove the meddling with the atomic.h headers?

i386 can directly implement arch_mutex_fast_lock instead of
atomic_dec_call_if_negative.

Not sure what the policy is with naming, but I prefer mutex_arch_xxx
or __mutex_xxx for the arch specific names.

I think ARMv6 has a decent atomic_cmpxchg implementation but does
not define __HAVE_ARCH_CMPXCHG. It might be useful to try to use this
for ARMv6 SMP for a slightly better trylock.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
