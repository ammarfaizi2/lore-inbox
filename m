Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRCENaq>; Mon, 5 Mar 2001 08:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbRCENa0>; Mon, 5 Mar 2001 08:30:26 -0500
Received: from ns.caldera.de ([212.34.180.1]:24073 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129282AbRCENaW>;
	Mon, 5 Mar 2001 08:30:22 -0500
Date: Mon, 5 Mar 2001 14:30:08 +0100
Message-Id: <200103051330.OAA31295@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: Matt_Domsch@Dell.com
Cc: R.E.Wolff@BitWizard.nl, fluffy@snurgle.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9E09@ausxmrr501.us.dell.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

In article <CDF99E351003D311A8B0009027457F1403BF9E09@ausxmrr501.us.dell.com> you wrote:
> My concern is that if there continues to be a 2GB swap partition/file size
> limitation, and you can have (as currently #defined) 8 swap partitions,
> you're limited to 16GB swap, which then follows a max of 8GB RAM.  We'd like
> to sell servers with 32GB or 64GB RAM to customers who request such for
> their applications.  Such customers generally have no problem purchasing
> additional disks to be used for swap, likely on a hardware RAID controller.

dou you actually want to page that high memory?  These high memory
configurations are usually used by databases and other huge applications
that have their own memory management.

Other UNIX versions, e.g. the UnixWare with dshm have implemented special
memory pools (in this case dshm) to give unswappable memory to this
applications.  While I don't like such implementations with fixed memory
pools it might be a good idea to have a MAP_DEDICATED flags to mmap
(/dev/zero) to allocate non-aged and thus non-paged memory.

To not make the system unusable by allocating too much of this memory
allocation might need a special capability and/or a dynamic limit of
allocatable unaged memory (sysctl?).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
