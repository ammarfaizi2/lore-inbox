Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310502AbSCGUSt>; Thu, 7 Mar 2002 15:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310504AbSCGUSj>; Thu, 7 Mar 2002 15:18:39 -0500
Received: from holomorphy.com ([216.36.33.161]:3470 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S310502AbSCGUS2>;
	Thu, 7 Mar 2002 15:18:28 -0500
Date: Thu, 7 Mar 2002 12:18:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020307201819.GF786@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	riel@surriel.com, hch@infradead.org, phillips@bonn-fries.net
In-Reply-To: <20020307092119.A25470@dualathlon.random> <20020307104942.GC786@holomorphy.com> <20020307180300.B25470@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020307180300.B25470@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 06:03:00PM +0100, Andrea Arcangeli wrote:
> For the other points I think you shouldn't really complain (both at
> runtime and in code style as well, please see how clean it is with the
> wait_table_t thing), I made a definitive improvement to your code, the
> only not obvious part is the hashfn but I really cannot see yours
> beating mine because of the total random input, infact it could be the
> other way around due the fact if something there's the probability the
> pages are physically consecutive and I take care of that fine.


I don't know whose definition of clean code this is:

+static inline wait_queue_head_t * wait_table_hashfn(struct page * page, wait_table_t * wait_table)
+{
+#define i (((unsigned long) page)/(sizeof(struct page) & ~ (sizeof(struct page) - 1)))
+#define s(x) ((x)+((x)>>wait_table->shift))
+	return wait_table->head + (s(i) & (wait_table->size-1));
+#undef i
+#undef s
+}


I'm not sure I want to find out.


Bill
