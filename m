Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUCDRft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUCDRft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:35:49 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:46038 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262040AbUCDRfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:35:47 -0500
Date: Thu, 04 Mar 2004 09:35:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Peter Zaitsev <peter@mysql.com>
cc: andrea@suse.de, riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <132310000.1078421713@flay>
In-Reply-To: <20040303200704.17d81bda.akpm@osdl.org>
References: <20040228072926.GR8834@dualathlon.random><Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com><20040229014357.GW8834@dualathlon.random><1078370073.3403.759.camel@abyss.local><20040303193343.52226603.akpm@osdl.org><1078371876.3403.810.camel@abyss.local> <20040303200704.17d81bda.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Peter Zaitsev <peter@mysql.com> wrote:
>> 
>> Sorry if I was unclear.  These are suffexes from RH AS 3.0 kernel
>>  namings.  "SMP" corresponds to normal SMP kernel they have,  "hugemem"
>>  is kernel with 4G/4G split.
>> 
>>  > 
>>  > > For CPU bound load (10 Warehouses) I got 7000TPM instead of 4500TPM,
>>  > > which is over 35% slowdown.
>>  > 
>>  > Well no, it is a 56% speedup.   Please clarify.  Lots.
>> 
>>  Huh. The numbers shall be other way around of course :)   "smp" kernel
>>  had better performance of some 7000TPM, compared to  4500TPM with
>>  HugeMem kernel. 
> 
> That's a larger difference than I expected.  But then, everyone has been
> mysteriously quiet with the 4g/4g benchmarking.
> 
> A kernel profile would be interesting.  As would an optimisation effort,
> which, as far as I know, has never been undertaken.

In particular:

1. a diffprofile between the two would be interesting (assuming it's
at least partly increase in kernel time), or any other way to see exactly
why it's slower (well, TLB flushes, obviously, but what's causing them).

2. If it's gettimeofday hammering it (which it probably is, from previous
comments by others, and my own experience), then vsyscall gettimeofday
(John's patch) may well fix it up.

3. Are you using the extra user address space? Otherwise yes, it'll be 
all downside. And 4/4 vs 3/1 isn't really a fair comparison ... 4/4 is
designed for bigboxen, so 4/4 vs 2/2 would be better, IMHO. People have
said before that DB performance can increase linearly with shared area
sizes (for some workloads), so that'd bring you a 100% or so increase
in performance for 4/4 to counter the loss.

M.
