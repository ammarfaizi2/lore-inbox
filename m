Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423049AbWAMWe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423049AbWAMWe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423048AbWAMWe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:34:57 -0500
Received: from amdext4.amd.com ([163.181.251.6]:43216 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1423049AbWAMWe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:34:56 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Brian Twichell" <tbrian@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Fri, 13 Jan 2006 16:34:23 -0600
User-Agent: KMail/1.8
cc: "Dave McCracken" <dmccr@us.ibm.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>, slpratt@us.ibm.com
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <43C73767.5060506@us.ibm.com>
In-Reply-To: <43C73767.5060506@us.ibm.com>
MIME-Version: 1.0
Message-ID: <200601131634.24913.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 13 Jan 2006 22:34:21.0599 (UTC)
 FILETIME=[7F8E3AF0:01C61891]
X-WSS-ID: 6FD6F5653983469381-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 23:15, Brian Twichell wrote:

> Hi,
>
> We evaluated page table sharing on x86_64 and ppc64 setups, using a
> database OLTP workload.  In both cases, 4-way systems with 64 GB of memory
> were used.
>
> On the x86_64 setup, page table sharing provided a 25% increase in
> performance,
> when the database buffers were in small (4 KB) pages.  In this case,
> over 14 GB
> of memory was freed, that had previously been taken up by page tables.
> In the
> case that the database buffers were in huge (2 MB) pages, page table
> sharing provided a 4% increase in performance.
>

Brian,

Is that 25%-50% percent of overall performance (e. g. transaction throughput), 
or is this a measurement of, say, DB process startup times, or what?   It 
seems to me that the impact of the shared page table patch would mostly be 
noticed at address space construction/destruction times, and for a big OLTP 
workload, the processes are probably built once and stay around forever, no?

If the performance improvement is in overall throughput, do you understand why 
the impact would be so large?   TLB reloads?   I don't understand why one 
would see that kind of overall performance improvement, but I could be 
overlooking something.   (Could very likely be overlooking something...:-) )

Oh, and yeah, was this an AMD x86_64 box or what?
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

