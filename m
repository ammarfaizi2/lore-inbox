Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbUALSwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 13:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUALSwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 13:52:16 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:24092 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265597AbUALSwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 13:52:13 -0500
Date: Mon, 12 Jan 2004 10:52:03 -0800
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, jamagallon@able.es
Subject: Re: /proc/kcore size
Message-ID: <20040112185203.GA11768@sgi.com>
Mail-Followup-To: "Luck, Tony" <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, jamagallon@able.es
References: <B8E391BBE9FE384DAA4C5C003888BE6F4FB05C@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F4FB05C@scsmsx401.sc.intel.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2.4:
	[jbarnes@tomahawk 999-jb.patch]$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
	Mem:  32657883136 31249809408 1408073728        0        0 10380558336
	Swap: 10485727232 67059712 10418667520
	MemTotal:     31892464 kB
	MemFree:       1375072 kB
	MemShared:           0 kB
	Buffers:             0 kB
	Cached:       10112928 kB
	SwapCached:      24336 kB
	Active:        7169808 kB
	Inactive:      3035504 kB
	HighTotal:           0 kB
	HighFree:            0 kB
	LowTotal:     31892464 kB
	LowFree:       1375072 kB
	SwapTotal:    10239968 kB
	SwapFree:     10174480 kB
	HugePages_Total:     0
	HugePages_Free:      0
	Hugepagesize:    262144 kB
	[jbarnes@tomahawk 999-jb.patch]$ ls -l /proc/kcore
	-r--------    1 root     root     1909045870592 Jan 12 10:39 /proc/kcore

and from 2.6:
	[root@morale root]# cat /proc/meminfo
	MemTotal:      7583600 kB
	MemFree:       7432864 kB
	Buffers:          7952 kB
	Cached:          41248 kB
	SwapCached:          0 kB
	Active:          52592 kB
	Inactive:        34736 kB
	HighTotal:           0 kB
	HighFree:            0 kB
	LowTotal:      7583600 kB
	LowFree:       7432864 kB
	SwapTotal:           0 kB
	SwapFree:            0 kB
	Dirty:             256 kB
	Writeback:           0 kB
	Mapped:          33392 kB
	Slab:            17376 kB
	Committed_AS:    27312 kB
	PageTables:       2112 kB
	VmallocTotal: 137426709824 kB
	VmallocUsed:       128 kB
	VmallocChunk: 137426709696 kB
	[root@morale root]# ls -l /proc/kcore
	-r--------    1 root     root     808460500992 Jan 12 10:51 /proc/kcore



On Mon, Jan 12, 2004 at 10:00:19AM -0800, Luck, Tony wrote:
> > Problem: it detects the memory amount in the box by stat'ing /proc/kcore.
> > Thats not the problem, but that the box has 1Gb of memory, and kcore is just
> > 896Mb big.
> 
> It may not be the specific problem that you have now, but it is a
> problem in general.  The size of /proc/kcore may be a good
> approximation for the amount of memory on machines that have
> contiguous physical memory starting at a base physical address
> of 0x0, but on an increasing number of machines it may give
> a grossly inflated value (perhaps an SGI Altix user will post
> the output from "ls -l /proc/kcore").
> 
> -Tony Luck  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
