Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263171AbVFXVDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbVFXVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVFXU77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:59:59 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57277 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263247AbVFXU4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:56:15 -0400
Date: Fri, 24 Jun 2005 13:56:12 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <344410000.1119646572@flay>
In-Reply-To: <20050624195248.GA9663@elte.hu>
References: <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu> <320710000.1119632967@flay> <20050624195248.GA9663@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Friday, June 24, 2005 21:52:48 +0200 Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Martin J. Bligh <mbligh@mbligh.org> wrote:
> 
>> > -	/*
>> > -	 * In the NUMA case we dont use the TSC as they are not
>> > -	 * synchronized across all CPUs.
>> > -	 */
>> > -#ifndef CONFIG_NUMA
>> > -	if (!use_tsc)
>> > -#endif
>> > +	if (!cpu_has_tsc)
>> >  		/* no locking but a rare wrong value is not a big deal */
>> >  		return jiffies_64 * (1000000000 / HZ);
>> 
>> Humpf. That does look dangerous on a NUMA-Q. The TSCs aren't synced, 
>> and we can't use them .... have to use PIT, whether the CPUs have TSC 
>> or not.
> 
> is the only problem the unsyncedness? That should be fine as far as the 
> scheduler is concerned. (we compensate for per-CPU drifts)

Well, I think so. But I don't see how you're going to compensate for
large-scale unsynced-ness safely. I've always completely avoided the
TSC altogether on NUMA-Q ... would prefer to keep it that way. We got
lots of wierd random crashes, panics, hangs, and -ve time offsets 
returned from userspace time commands last time I tried it.

M.

