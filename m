Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313531AbSDETre>; Fri, 5 Apr 2002 14:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313533AbSDETrZ>; Fri, 5 Apr 2002 14:47:25 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36618 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313531AbSDETrL>; Fri, 5 Apr 2002 14:47:11 -0500
Message-ID: <3CADFECE.F2A6374@zip.com.au>
Date: Fri, 05 Apr 2002 11:45:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ricardo Galli <gallir@uib.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Report: 2.4.18 very high latencies (with lowlat. and pre-empt 
 patches)
In-Reply-To: <E16tEL4-0006fr-00@antoli.gallimedina.net> <3CACD3BC.1EB55BCC@zip.com.au> <E16tQlJ-0007ZV-00@antoli.gallimedina.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli wrote:
> 
> To test computer A, which has installed Linux 2.4.18 + all low latency
> patches.
> 
> 1. Put ten (10) to twenty (20) files of 64-80 MB each in computer B. For
> example in /tmp/test.
> 
> 2. Mount in B a disk in A via NFS in, for example, /mnt/A
> 
> 3. In B, run the following command:
> cp /tmp/test/* /mnt/A
> 
> 4. Check in A how you mouse freezes.
> 

You're writing a ton of data to disk, and this causes the X
server to have long freezes.

Probably the X server is waiting on a disk read, which is
blocked behind all the writes.  This is worsened by the
VM's tendency to evict useful data in favour of caching
large read/write data.

You'll find that the -aa VM will improve the page replacement
decisions, so the X server won't have to read random
pages as often.  This should help a bit.  The patch at
http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.18-pre1/read-latency2.patch
will decrease the time which the remaining reads take.
This should help a lot.

We're getting there, albeit a bit slowly.

-
