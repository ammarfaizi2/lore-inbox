Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136540AbRAHKju>; Mon, 8 Jan 2001 05:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136542AbRAHKjl>; Mon, 8 Jan 2001 05:39:41 -0500
Received: from ns.caldera.de ([212.34.180.1]:6149 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S136540AbRAHKja>;
	Mon, 8 Jan 2001 05:39:30 -0500
Date: Mon, 8 Jan 2001 11:39:15 +0100
Message-Id: <200101081039.LAA30397@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: davem@redhat.com ("David S. Miller")
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101080124.RAA08134@pizda.ninka.net> you wrote:

> I've put a patch up for testing on the kernel.org mirrors:
>
> /pub/linux/kernel/people/davem/zerocopy-2.4.0-1.diff.gz
>
> It provides a framework for zerocopy transmits and delayed
> receive fragment coalescing.  TUX-1.01 uses this framework.

Hi Dave,

don't you think the writepage file operation is rather hackish?
I'd much prefer Ben La Haise's rw_kiovec [1] operation, it is more
generic (supports read and write) and should be easily usable for
zerocopy networking with plain old write (using map_user_kio).
Besides that the FS crew thinks it should go in soon because of
aio anyway...

	Christoph


[1] for those that don't know yet, the prototype is:

	rw_kiovec(struct file * filp, int rw, int nr,
		struct kiobuf ** kiovec, int flags,
		size_t size, loff_t pos);
-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
