Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264761AbSJVQKr>; Tue, 22 Oct 2002 12:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSJVQKJ>; Tue, 22 Oct 2002 12:10:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31689 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263968AbSJVQJR>; Tue, 22 Oct 2002 12:09:17 -0400
Date: Tue, 22 Oct 2002 09:13:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
Message-ID: <2666502487.1035277994@[10.10.2.3]>
In-Reply-To: <3DB4EE4E.88311B7B@digeo.com>
References: <3DB4EE4E.88311B7B@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> > Maybe you didn't cat /dev/sda2 for long enough?
>> 
>> Well, it's a multi-gigabyte partition. IIRC, I just ran it until
>> it died with "input/output error" ... which I assumed at the time
>> was the end of the partition, but it should be able to find that
>> without error, so maybe it just ran out of ZONE_NORMAL ;-)
> 
> Oh.  Well it should have just hit eof.  Maybe you have a dud
> sector and it terminated early.

OK, I catted an 18Gb disk completely. The beast still didn't shrink.

larry:~# cat /proc/meminfo
MemTotal:     16078192 kB
MemFree:      15043280 kB
MemShared:           0 kB
Buffers:         79152 kB
Cached:         287248 kB
SwapCached:          0 kB
Active:         263056 kB
Inactive:       105136 kB
HighTotal:    15335424 kB
HighFree:     15039616 kB
LowTotal:       742768 kB
LowFree:          3664 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           3736 kB
Slab:           641352 kB
Reserved:       570000 kB
Committed_AS:     2400 kB
PageTables:        180 kB
ReverseMaps:      2236

ext2_inode_cache  476254 541125    416 60125 60125    1 :  120   
dentry_cache      2336272 2336280    160 97345 97345    1 :  248  124

Note that dentry cache seems to have grown overnight ....

I guess I'll add some debug code to the slab cache shrinkers
and try to see what it's doing.

M.
