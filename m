Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263627AbSIQFPJ>; Tue, 17 Sep 2002 01:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263632AbSIQFPJ>; Tue, 17 Sep 2002 01:15:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13777 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263627AbSIQFPF>; Tue, 17 Sep 2002 01:15:05 -0400
Date: Mon, 16 Sep 2002 22:18:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-mm@kvack.org,
       akpm@zip.com.au, hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
Message-ID: <211767585.1032214699@[10.10.2.3]>
In-Reply-To: <3D86BA1B.84873680@digeo.com>
References: <3D86BA1B.84873680@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> meminfo.what?   Remember when I suggested that you put
> a testing mode into the numa code so that mortals could
> run numa builds on non-numa boxes?

NUMA aware meminfo is one of the patches you have sitting
in your tree. I haven't got around to the NUMA-sim yet ...
maybe after Halloween when management stop asking me to
get other bits of code in before the freeze ;-)

mbligh@larry:~$ cat /proc/meminfo.numa 

Node 0 MemTotal:      4194304 kB
Node 0 MemFree:       3420660 kB
Node 0 MemUsed:        773644 kB
Node 0 HighTotal:     3418112 kB
Node 0 HighFree:      2737992 kB
Node 0 LowTotal:       776192 kB
Node 0 LowFree:        682668 kB

Node 1 MemTotal:      4147200 kB
Node 1 MemFree:       4116444 kB
Node 1 MemUsed:         30756 kB
Node 1 HighTotal:     4147200 kB
Node 1 HighFree:      4116444 kB
Node 1 LowTotal:            0 kB
Node 1 LowFree:             0 kB

Node 2 MemTotal:      4147200 kB
Node 2 MemFree:       4131816 kB
Node 2 MemUsed:         15384 kB
Node 2 HighTotal:     4147200 kB
Node 2 HighFree:      4131816 kB
Node 2 LowTotal:            0 kB
Node 2 LowFree:             0 kB

Node 3 MemTotal:      4147200 kB
Node 3 MemFree:       4128432 kB
Node 3 MemUsed:         18768 kB
Node 3 HighTotal:     4147200 kB
Node 3 HighFree:      4128432 kB
Node 3 LowTotal:            0 kB
Node 3 LowFree:             0 kB

>> Looks to me like it's just out of low memory:
>> 
>> > LowFree:          1424 kB
>> 
>> There is no low memory on anything but node 0 ... 
> 
> It was a GFP_HIGH allocation - just pagecache.

Ah, but what does a balance_classzone do on a NUMA box?
Once you've finished rototilling the code you're looking
at, I think we might have a better clue what it's supposed
to do, at least ...

M.
