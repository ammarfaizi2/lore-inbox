Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261361AbSJ1Qod>; Mon, 28 Oct 2002 11:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSJ1Qod>; Mon, 28 Oct 2002 11:44:33 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:52668 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261361AbSJ1Qoc>;
	Mon, 28 Oct 2002 11:44:32 -0500
Message-ID: <3DBD6AE1.8040403@colorfullife.com>
Date: Mon, 28 Oct 2002 17:50:41 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] shmem missing cache flush
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it permitted to call flush_dcache_page() on pages that are not in the 
page cache?
The documentation is ambiguous, it only mentions how archs can handle 
dcache aliases for page cache users.

What about the user space accesses that kmap user space pages directly, 
without copy_*_user?

For example:
- ptrace
- disk transfers that end up calling __bio_kmap() - RAID-5, ide error 
handling.
    Could be from irq context!
- hole handling for O_DIRECT file access.

In all 3 cases, the target could be outside of the page cache.

--
    Manfred

