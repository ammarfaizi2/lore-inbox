Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVLVSj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVLVSj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVLVSj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:39:56 -0500
Received: from jade.aracnet.com ([216.99.193.136]:49370 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S965012AbVLVSjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:39:55 -0500
Message-ID: <43AAF21E.5040800@BitWagon.com>
Date: Thu, 22 Dec 2005 10:36:14 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: William Cohen <wcohen@redhat.com>, Stephane Eranian <eranian@hpl.hp.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: quick overview of the perfmon2 interface
References: <20051219113140.GC2690@frankl.hpl.hp.com> <20051220025156.a86b418f.akpm@osdl.org> <20051222115632.GA8773@frankl.hpl.hp.com> <20051222120558.GA31303@infradead.org> <43AAC854.6020608@redhat.com> <20051222172303.GC6038@infradead.org>
In-Reply-To: <20051222172303.GC6038@infradead.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Dec 22, 2005 at 10:37:56AM -0500, William Cohen wrote:
> 
>>Both OProfile and PAPI are open source and could use such an performance 
>>monitoring interface.
>>
>>One of the problems right now is there is a patchwork of performance 
>>monitoring support. Each instrumentation system has its own set of 
>>drivers/patches. Few have support integrated into the kernel, e.g. 
>>OProfile. However, the OProfile driver provides only a subset of the 
>>performance monitoring support, system-wide sampling. The OProfile 
>>driver doesn't allow per-thread monitoring or stopwatch style 
>>measurement, which can be very useful for some performance monitoring 
>>applications.
> 
> 
> What about improving oprofile then?  Unlike the vtune or perfoman people
> the oprofile authors have shown they actually are able to design sensible
> interfaces, and oprofile has broad plattform support over most support
> architectures.

Oprofile cannot be improved to provide stopwatch timing.
It is impossible because oprofile is sampling, not direct measurement.
Perfmon2, or anything which requires a system call to read a meter
[counter] of nanoseconds [per-thread virtualized cycle counter]
often adds unreasonably high overhead: hundreds of cycles or more,
instead of tens or less.  CPU manufacturers are making life
difficult for users of perfctr, by muddying the meaning of
their user-readable cycle counters (see x86 RDTSC) or by omitting
user-readable cycle counters entirely (whether in the name of lower cost,
reducing "side channel" system information leaks, or otherwise.)

-- 
