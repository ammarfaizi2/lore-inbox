Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbRCWUAl>; Fri, 23 Mar 2001 15:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbRCWUAV>; Fri, 23 Mar 2001 15:00:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:780 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131402AbRCWUAJ>; Fri, 23 Mar 2001 15:00:09 -0500
Date: Fri, 23 Mar 2001 11:58:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben LaHaise <bcrl@redhat.com>,
        Christoph Rohland <cr@sap.com>
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
In-Reply-To: <20010323011331.J7756@redhat.com>
Message-ID: <Pine.LNX.4.31.0103231157200.766-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Stephen C. Tweedie wrote:
>
> The patch below is for two races in sysV shared memory.

	+       spin_lock (&info->lock);
	+
	+       /* The shmem_swp_entry() call may have blocked, and
	+        * shmem_writepage may have been moving a page between the page
	+        * cache and swap cache.  We need to recheck the page cache
	+        * under the protection of the info->lock spinlock. */
	+
	+       page = find_lock_page(mapping, idx);

Ehh.. Sleeping with the spin-lock held? Sounds like a truly bad idea.

		Linus

