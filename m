Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266914AbRHCJtc>; Fri, 3 Aug 2001 05:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbRHCJtX>; Fri, 3 Aug 2001 05:49:23 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:46853 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S266914AbRHCJtG>;
	Fri, 3 Aug 2001 05:49:06 -0400
Date: Fri, 03 Aug 2001 11:49:14 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Linux can't find partitions , again
To: linux-kernel@vger.kernel.org, testers-list@redhat.com
Message-id: <3B6A739A.7D6197CD@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yesterday I did "nothing" (*) and then linux didn't boot anymore.
It couldn't mount the root FS.
After I fixed that , it couldn't turn on the swap partition.

This really pisses me off ! ( I am cool now, you should see me yesterday )

The problem was that the partitions were renumbered "randomly"
and linux just can not deal with that. Before linux named the root FS
partition hda6, but now he names it hda7. Off course the kernel still looks
for hda6 and fails. After I fix LILO , it boots, but fails to turn on the swap
as it was renamed from hda7 to hda5. I edit /etc/fstab and all is well.
Until next time.

This has bitten me and my neighbour enough times that I wrote a kernel patch
to fix ( 99% fix ) the first problem ( root-FS ) and I don't write kernel patches
every week !
I didn't address the second problem ( swap ).

The patch works by scanning all known partitions for a matching ext2 UUID ( or label ).
Maybe a simpler solution would be to search the partition list for a particular
disk ( hda ) for a partition which has a particular (start,size) pair ? ( less disk access, 
FS-type neutral , would work for the swap problem too )

Patch available at
http://linux-patches.rock-projects.com/v2.2-f/uuid.html

Opinions ?

* - I created a partition on the free part of the disk, but after a minute
I changed my mind an deleted it. I used the Disk Administrator tools undwr win2000

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
