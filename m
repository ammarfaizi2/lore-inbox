Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRICUOj>; Mon, 3 Sep 2001 16:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271802AbRICUOa>; Mon, 3 Sep 2001 16:14:30 -0400
Received: from are.twiddle.net ([64.81.246.98]:36484 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S271798AbRICUOT>;
	Mon, 3 Sep 2001 16:14:19 -0400
Date: Mon, 3 Sep 2001 13:14:36 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com,
        davidm@hpl.hp.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
Message-ID: <20010903131436.A16069@twiddle.net>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, davem@redhat.com, davidm@hpl.hp.com
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Aug 31, 2001 at 09:18:50PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2001 at 09:18:50PM +1000, Paul Mackerras wrote:
> +		if (!test_bit(PG_arch_1, &page->flags)) {
> +			__flush_dcache_icache((unsigned long)kmap(page));
> +			kunmap(page);
> +			set_bit(PG_arch_1, &page->flags);

Race.  Use test_and_set_bit.

As for Alpha, all we have is "flush entire icache", so there's not
much interesting we can do by way of optimization I don't think.


r~
