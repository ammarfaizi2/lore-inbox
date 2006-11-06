Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423620AbWKFIsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423620AbWKFIsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 03:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423622AbWKFIsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 03:48:47 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:42962 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1423620AbWKFIsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 03:48:47 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
Date: Mon, 6 Nov 2006 09:48:42 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com> <454EE580.5040506@cosmosbay.com> <f55850a70611060010q3ce9d6d2h4026259d688c6db1@mail.gmail.com>
In-Reply-To: <f55850a70611060010q3ce9d6d2h4026259d688c6db1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611060948.43918.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 November 2006 09:10, Zhao Xiaoming wrote:
>
> Thanks for the answer. I know it's more likely relats to netdev.
> However, it's always a strange thing to have 400~500M bytes LOWMEM
> 'gone' while it's not reported to be occupied by slab. Both meminfo
> and buddyinfo tell the same.
>
> with traffics of 2000 concurrent sessions:

Slab:           293952 kB
So 292 MB used by slab for 2000 sessions.

Expect 600 MB used by slab for 4000 sessions.

So your precious LOWMEM is not gone at all. It *IS* used by SLAB.

You forgot to send 
cat /proc/slabinfo

>
> cat /proc/meminfo
> MemTotal:      4136580 kB
> MemFree:       3298460 kB
> Buffers:          4096 kB
> Cached:          21124 kB
> SwapCached:          0 kB
> Active:          47416 kB
> Inactive:        12532 kB
> HighTotal:     3276160 kB
> HighFree:      3214592 kB
> LowTotal:       860420 kB
> LowFree:         83868 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:              12 kB
> Writeback:           0 kB
> Mapped:          42104 kB
> Slab:           293952 kB
> CommitLimit:   2068288 kB
> Committed_AS:    58892 kB
> PageTables:       1112 kB
> VmallocTotal:   116728 kB
> VmallocUsed:      2940 kB
> VmallocChunk:   110548 kB
> HugePages_Total:     0
> HugePages_Free:      0
> Hugepagesize:     2048 kB
>
>
