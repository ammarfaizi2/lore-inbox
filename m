Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269709AbRHIHIg>; Thu, 9 Aug 2001 03:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269712AbRHIHI0>; Thu, 9 Aug 2001 03:08:26 -0400
Received: from imladris.infradead.org ([194.205.184.45]:7947 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269709AbRHIHIM>;
	Thu, 9 Aug 2001 03:08:12 -0400
Date: Thu, 9 Aug 2001 08:08:15 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: Ivan Kalvatchev <iive@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Thoughts on tmpfs and swapfs
In-Reply-To: <3B722DE4.96DA5711@idb.hist.no>
Message-ID: <Pine.LNX.4.33.0108090754170.10432-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge.

 >> I didn't look at the chages but i will say this one more time.
 >> Limiting tmpfs size at fixed amount of space will make the bug
 >> harder to reproduce but won't fix it. The right hack is to limit
 >> tmpfs to be with freepages.high less than available
 >> memory(swap+ram). It won't be hard to code.

 > The problem with this is that tmpfs may be mounted before swap
 > is initialized, so a little less than swap+ram will become "a
 > little less than just RAM" anyway.

 > Or do you propose a dynamic limit, changing as swap is
 > added/removed? This has problems if some swap is removed, and
 > suddenly tmpfs usage exceeds its quota.

I have to admit that tmpfs is new to me, but I would assume it's a
filing system for temporary files, that works along the lines of a
ramdisk?

If so, I would see the following issues with this idea:

 1. If the idea is to keep temporary files off the hard disk,
    it makes no sense to use swap for them, so any limit on
    the size of tmpfs would need to be limited to the size
    of physical ram.

 2. If the idea is to ensure that temporary files are deleted
    as soon as they are finished with, it makes no sense to
    use physical ram for them, and this effectively becomes
    what I would refer to as swapfs - a filing system where
    the objects within it are stored in swap until such time
    as the last reference is freed, and are then auto-deleted,
    possibly with a short delay to allow for programs run one
    after the other where the first creates a file that is
    read by the second.

 3. If the idea is to do both of the above at the same time,
    any limit on the size of tmpfs would need to be linked to
    the amount of swap present, and the link would need to be
    such that it was not possible to release swap if doing so
    would leave tmpfs over-committed. I can see serious bugs
    with this idea in a hotplug environment.

Comments, anybody?

Best wishes from Riley.

