Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282530AbRLONeZ>; Sat, 15 Dec 2001 08:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRLONeP>; Sat, 15 Dec 2001 08:34:15 -0500
Received: from holomorphy.com ([216.36.33.161]:12675 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S282530AbRLONd6>;
	Sat, 15 Dec 2001 08:33:58 -0500
Date: Sat, 15 Dec 2001 05:27:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] bootmem for 2.5
Message-ID: <20011215052755.A1047@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com> <Pine.LNX.4.33.0112150701180.22884-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0112150701180.22884-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Dec 15, 2001 at 07:05:45AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, William Irwin wrote:
>> [...] According to testing, this patch appears to save somewhere
>> between 8KB and 2MB on i386 PC's versus the bitmap-based bootmem
>> allocator.

On Sat, Dec 15, 2001 at 07:05:45AM +0100, Ingo Molnar wrote:
> exactly where do these savings come from? The bootmem allocator frees its
> bitmaps in free_all_bootmem().

I'm not entirely sure of the reason for the 2MB report, but it is the
highest of the numbers that came back from #kernelnewbies testers.

In the common (i386) case, it's microscopic, and it's always a direct
result of tracking allocations at address granularity as opposed to page
granularity. The mainline bootmem (which I'm sure you yourself are quite
familiar with =) tracks allocations at page granularity and maintains
additional state for the last allocation in order to merge successive
small allocations. There are other architectures (IA64) where larger
differences are seen. The small memory savings are a nice side effect,
but the primary benefit is intended to be less work being needed to
initialize the allocator.

As a side note, I'm interested in your general opinion regarding the
code, especially given your prior involvement with this subsystem.


Thanks,
Bill
