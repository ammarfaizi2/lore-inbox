Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284444AbRLHTmW>; Sat, 8 Dec 2001 14:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284445AbRLHTmN>; Sat, 8 Dec 2001 14:42:13 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:46860 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284444AbRLHTl7>; Sat, 8 Dec 2001 14:41:59 -0500
Message-ID: <3C126CE2.31726172@zip.com.au>
Date: Sat, 08 Dec 2001 11:41:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Leigh Orf <orf@mailbag.com>
CC: Ken Brownfield <brownfld@irridia.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 memory badness (reproducible)
In-Reply-To: Your message of "Sat, 08 Dec 2001 09:56:20 CST."
	             <20011208095620.C1179@asooo.flowerfire.com> <200112081854.fB8IsIr01485@orp.orf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leigh Orf wrote:
> 
> Ken Brownfield wrote:
> 
> |   This parallels what I'm seeing -- perhaps inode/dentry cache
> |   bloat is causing the memory issue (which mimics if not _is_
> |   a memory leak) _and_ my kswapd thrashing?  It fits both the
> |   situation you report and what I'm seeing with I/O across a
> |   large number of files (inodes) -- updatedb, smb, NFS, etc.
> |
> |   I think Andrea was on to this issue, so I'm hoping his work
> |   will help.  Have you tried an -aa kernel or an aa patch onto
> |   a 2.4.17-pre4 to see how the kernel's behavior changes?
> |
> |   --
> |   Ken.
> |   brownfld@irridia.com
> 
> I get the exact same behavior with 2.4.17-pre4-aa1 - many applications
> abort with ENOMEM after updatedb (filling the buffer and cache). Is
> there another kernel/patch I should try?
> 

Just for interest's sake:

--- linux-2.4.17-pre6/mm/memory.c	Fri Dec  7 15:39:52 2001
+++ linux-akpm/mm/memory.c	Sat Dec  8 11:13:30 2001
@@ -1184,6 +1184,7 @@ static int do_anonymous_page(struct mm_s
 		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		lru_cache_add(page);
+		activate_page(page);
 	}
 
 	set_pte(page_table, entry);
