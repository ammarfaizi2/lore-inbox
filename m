Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSDEUAY>; Fri, 5 Apr 2002 15:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSDEUAO>; Fri, 5 Apr 2002 15:00:14 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:64267 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313314AbSDEUAI>; Fri, 5 Apr 2002 15:00:08 -0500
Message-ID: <3CAE01D8.EB75F7A2@zip.com.au>
Date: Fri, 05 Apr 2002 11:58:16 -0800
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

You're writing a large amount of data to disk.  Presumably
the X server on the same machine wants to read a little
bit of data from the same disk.  The X server spends a
long time in disk wait, behind all the writes.

This is somewhat worsened by the VM's tendency to evict
useful pages in favour of less useful pages (cache for
large reads and writes).

You will probably find that the -aa VM will help a little, by
reducing the tendency to evict the wrong pages.  You will
probably find that
http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.18-pre1/read-latency2.patch
helps a lot, by allowing the reads to be satisfied more quickly.

You will probably find that current -ac kernels help
a lot, because they contain read-latency2.  -ac kernels
also have a different VM which I think makes an attempt
to special-case the large streaming read and write problem.

We're getting there, slowly.

-
