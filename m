Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272521AbTHEQSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270169AbTHEQSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:18:22 -0400
Received: from dm4-153.slc.aros.net ([66.219.220.153]:62937 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S272521AbTHEQSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:18:20 -0400
Message-ID: <3F2FD8C8.7080507@aros.net>
Date: Tue, 05 Aug 2003 10:18:16 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rddunlap@osdl.org>, Leann Ogasawara <ogasawara@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert to static = {0}
References: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>Please revert to static zero initialization of a const: when thus
>initialized it's linked into a readonly cacheline shared between cpus;
>otherwise it's linked into bss, likely to be in a dirty cacheline
>bouncing between cpus.
>
>--- 2.6.0-test2-bk/mm/shmem.c	Tue Aug  5 15:57:31 2003
>+++ linux/mm/shmem.c	Tue Aug  5 16:16:55 2003
>@@ -296,7 +296,7 @@
> 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> 	struct page *page = NULL;
> 	swp_entry_t *entry;
>-	static const swp_entry_t unswapped;
>+	static const swp_entry_t unswapped = {0};
> 
> 	if (sgp != SGP_WRITE &&
> 	    ((loff_t) index << PAGE_CACHE_SHIFT) >= i_size_read(inode))
>  
>
If this static zero initialization makes it into the kernel distro for 
the given reason, please also add a comment sharing your above mentioned 
reasoning.

