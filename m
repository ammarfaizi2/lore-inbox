Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271803AbRICU1V>; Mon, 3 Sep 2001 16:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271805AbRICU1L>; Mon, 3 Sep 2001 16:27:11 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:15575 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S271803AbRICU1F>;
	Mon, 3 Sep 2001 16:27:05 -0400
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15251.59286.154267.431231@napali.hpl.hp.com>
Date: Mon, 3 Sep 2001 13:27:02 -0700
To: Richard Henderson <rth@twiddle.net>
Cc: Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, davem@redhat.com, davidm@hpl.hp.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
In-Reply-To: <20010903131436.A16069@twiddle.net>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
	<20010903131436.A16069@twiddle.net>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 3 Sep 2001 13:14:36 -0700, Richard Henderson <rth@twiddle.net> said:

  Richard> On Fri, Aug 31, 2001 at 09:18:50PM +1000, Paul Mackerras wrote:
  >> +		if (!test_bit(PG_arch_1, &page->flags)) {
  >> +			__flush_dcache_icache((unsigned long)kmap(page));
  >> +			kunmap(page);
  >> +			set_bit(PG_arch_1, &page->flags);

  Richard> Race.  Use test_and_set_bit.

Nope, the old code is correct: you must turn on PG_arch_1 *after*
flushing the cache.  Yes, you might sometimes double flush, but that's
both safe and rare.

	--david
