Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTDMLjE (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 07:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263473AbTDMLjE (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 07:39:04 -0400
Received: from dialup-137.156.221.203.acc50-nort-cbr.comindico.com.au ([203.221.156.137]:27921
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263470AbTDMLjD (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 07:39:03 -0400
Message-ID: <3E994F06.2000402@cyberone.com.au>
Date: Sun, 13 Apr 2003 21:50:30 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Timothy Miller <tmiller10@cfl.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <001301c30145$5ff85fb0$6801a8c0@epimetheus>
In-Reply-To: <001301c30145$5ff85fb0$6801a8c0@epimetheus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>I'm excited about the new I/O scheduler (proposed?) in the 2.5.x kernel, but
>I have to admit to a considerable amount of ignorance of its actual
>behavior.  Thus, if it already does what I'm talking about, please feel free
>to ignore this post.  :)
>
>
>Any good SCSI drive knows the physical geometry of the disk and can
>therefore optimally schedule reads and writes.  Although necessary features,
>like read queueing, are also available in the current SATA spec, I'm not
>sure most drives will implement it, at least not very well.
>
The "continuous" nature of drive addressing means that the kernel
can do a fine job seek-wise. Due to write caches and read track
buffers, rotational scheduling (which could be done if we knew
geometry) would provide too little gain for the complexity. I would
say that for most workloads you wouldn't see any difference. (IMO)

>
>
>So, what if one were to write a program which would perform a bunch of
>seek-time tests to estimate an IDE disk's physical geometry?
>
Yes, something like this has been done.

>It could then
>make that information available to the kernel to use to reorder accesses
>more optimally.  Additionally, discrepancies from expected seek times could
>be logged in the kernel and used to further improve efficiency over time.
>
The benefit I see is knowing the seek time itself (not geometry), which
can be used to tune the IO scheduler. This is something that I'll
probably need to do (in kernel) in order to get my IO scheduler in 2.6,
as it probably (not tested yet) has bad failure cases on high seek time
devices like CDROMs.

>
>If it were good enough, many of the advantages of using SCSI disks would
>become less significant.
>
I'm not sure that this is among SCSI's big advantages. I know some
SCSI disks have farness/starvation problems with big reorder windows.

>
>
>Ideas?
>
It is worth looking into I think. I will be testing something like it
for AS but in kernel not userspace. I don't think it would be very
useful to help basic head movement optimization, but I would like
someone else to prove me wrong.

