Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275568AbRJAVQi>; Mon, 1 Oct 2001 17:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRJAVQ1>; Mon, 1 Oct 2001 17:16:27 -0400
Received: from [204.177.156.37] ([204.177.156.37]:7103 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S275548AbRJAVQN>; Mon, 1 Oct 2001 17:16:13 -0400
Date: Mon, 1 Oct 2001 22:17:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Christoph Rohland <cr@sap.com>
cc: Mike Fedyk <mfedyk@matchmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 4GB MemShared, Cached bigger (and growing) than MemTotal
 (64MB) on 2.4.9-ac18
In-Reply-To: <m34rpj3lsa.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0110012142400.1098-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Oct 2001, Christoph Rohland wrote:
> On Sun, 30 Sep 2001, Mike Fedyk wrote:
> > 
> > After this happened, I saw MemShared go up to about 4GB, and Cached
> > started growing, getting even bigger than ram!
> 
> Apparently the shmem accounting is screwed. (Hugh does something ring
> at your side?) 

I've now looked, and it's obviously my error in -ac shmem_writepage:
patch below against 2.4.10-ac2, would apply equally to 2.4.9-ac16 on.

Hugh

--- 2.4.10-ac2/mm/shmem.c	Mon Oct  1 21:36:28 2001
+++ linux/mm/shmem.c	Mon Oct  1 21:41:00 2001
@@ -462,6 +462,7 @@
 		swap_list_unlock();
 		/* Add it back to the page cache */
 		add_to_page_cache_locked(page, mapping, index);
+		atomic_inc(&shmem_nrpages);
 		activate_page(page);
 		SetPageDirty(page);
 		error = -ENOMEM;

