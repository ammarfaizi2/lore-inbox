Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbSLSKpn>; Thu, 19 Dec 2002 05:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSLSKpf>; Thu, 19 Dec 2002 05:45:35 -0500
Received: from holomorphy.com ([66.224.33.161]:50624 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267635AbSLSKn5>;
	Thu, 19 Dec 2002 05:43:57 -0500
Date: Thu, 19 Dec 2002 02:51:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.52-mm2
Message-ID: <20021219105125.GL1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3E015ECE.9E3BD19@digeo.com> <20021219085426.GJ1922@holomorphy.com> <20021219092853.GK1922@holomorphy.com> <20021219101219.GS31800@holomorphy.com> <3E01A004.58F2B880@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E01A004.58F2B880@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> c014f9e9 502737   1.64565     .text.lock.file_table
>> c01b1890 719105   2.35391     __copy_to_user
>> c0135768 911894   2.98498     __get_page_state
>> c013ee50 952823   3.11895     do_anonymous_page
>> c01436d0 1079864  3.53481     page_add_rmap
>> c01438cc 1186938  3.8853      page_remove_rmap
>> c0106f38 17763755 58.1476     poll_idle

On Thu, Dec 19, 2002 at 02:31:32AM -0800, Andrew Morton wrote:
> Is that improved?

Only in the qualitative sense. No statistically significant differences
in running times are observable.


William Lee Irwin III wrote:
>> pfn_to_nid() got lots of icache misses. Try using a macro.

On Thu, Dec 19, 2002 at 02:31:32AM -0800, Andrew Morton wrote:
> What's the callsite?

I was not able to collect this information and would be much obliged
to hear of how to do so for instruction cache profiling.


On Thu, Dec 19, 2002 at 02:31:32AM -0800, Andrew Morton wrote:
> Actually, just looking at mmzone.h, I have to say "ick".  The
> non-NUMA case seems unnecessarily overdone.  eg:
> #define page_to_pfn(page)
> 	((page - page_zone(page)->zone_mem_map) + page_zone(page)->zone_start_pfn)
> Ouch.  Why can't we have the good old `page - mem_map' here?

There is no reason why it could not be re-established for the Pee Cee
case. IMHO It would be excellent to have the proper architecture
discrimination defines in place so that Pee Cees could utilize the vastly
simpler calculation. So long as this is devolved to arch code there is no
danger of page->virtual being required by arch-independent code.


Thanks,
Bill
