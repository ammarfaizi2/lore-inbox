Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281030AbRKCT7k>; Sat, 3 Nov 2001 14:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281031AbRKCT7a>; Sat, 3 Nov 2001 14:59:30 -0500
Received: from holomorphy.com ([216.36.33.161]:33210 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281030AbRKCT7W>;
	Sat, 3 Nov 2001 14:59:22 -0500
Date: Sat, 3 Nov 2001 11:58:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] bootmem for 2.5
Message-ID: <20011103115807.A26577@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com> <20011102214308.A8217@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011102214308.A8217@kroah.com>; from greg@kroah.com on Fri, Nov 02, 2001 at 09:43:08PM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 02:02:07PM -0800, William Irwin wrote:
>> The following patch features space usage proportional only to the number
>> of distinct fragments of memory, tracking available memory at address
>> granularity up until the point of initializing per-page data structures,
>> and the use of segment trees in order to support efficient searches on
>> those rare machines where this is an issue. According to testing, this
>> patch appears to save somewhere between 8KB and 2MB on i386 PC's versus
>> the bitmap-based bootmem allocator.

On Fri, Nov 02, 2001 at 09:43:08PM -0800, Greg KH wrote:
> How will I see the difference in memory available between your patch and
> the in kernel version?  Can it be seen by merely comparing free(1)
> values?

Not sure what ate my original reply, so here I go again.

Yes, it will be visible in free(1) and dmesg. The amount of available
physical memory will be increased. For the most part because of the
ability of the stock bootmem to merge sub-page allocations while
otherwise tracking things at page granularity (using bdata->last_offset)
is limited. On the other hand, I track things at address granularity and
so achieve a "tightest packing" regardless of the order in which
allocations are done.


Cheers,
Bill
