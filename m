Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284603AbRLHUFP>; Sat, 8 Dec 2001 15:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284618AbRLHUFF>; Sat, 8 Dec 2001 15:05:05 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:3200 "EHLO
	orp.orf.cx") by vger.kernel.org with ESMTP id <S284617AbRLHUE5>;
	Sat, 8 Dec 2001 15:04:57 -0500
Message-Id: <200112082004.fB8K4eQ02110@orp.orf.cx>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
To: Andrew Morton <akpm@zip.com.au>
From: Leigh Orf <orf@mailbag.com>
cc: Ken Brownfield <brownfld@irridia.com>, linux-kernel@vger.kernel.org
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: 2.4.16 memory badness (reproducible) 
In-Reply-To: Your message of "Sat, 08 Dec 2001 11:41:22 PST."
             <3C126CE2.31726172@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 15:04:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No change - identical behavior.

Leigh Orf

Andrew Morton wrote:

|   Leigh Orf wrote:
|   > 
|   > Ken Brownfield wrote:
|   > 
|   > |   This parallels what I'm seeing -- perhaps inode/dentry cache
|   > |   bloat is causing the memory issue (which mimics if not _is_
|   > |   a memory leak) _and_ my kswapd thrashing?  It fits both the
|   > |   situation you report and what I'm seeing with I/O across a
|   > |   large number of files (inodes) -- updatedb, smb, NFS, etc.
|   > |
|   > |   I think Andrea was on to this issue, so I'm hoping his work
|   > |   will help.  Have you tried an -aa kernel or an aa patch onto
|   > |   a 2.4.17-pre4 to see how the kernel's behavior changes?
|   > |
|   > |   --
|   > |   Ken.
|   > |   brownfld@irridia.com
|   > 
|   > I get the exact same behavior with 2.4.17-pre4-aa1 - many applications
|   > abort with ENOMEM after updatedb (filling the buffer and cache). Is
|   > there another kernel/patch I should try?
|   > 
|   
|   Just for interest's sake:
|   
|   --- linux-2.4.17-pre6/mm/memory.c	Fri Dec  7 15:39:52 2001
|   +++ linux-akpm/mm/memory.c	Sat Dec  8 11:13:30 2001
|   @@ -1184,6 +1184,7 @@ static int do_anonymous_page(struct mm_s
|    		flush_page_to_ram(page);
|    		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
|    		lru_cache_add(page);
|   +		activate_page(page);
|    	}
|    
|    	set_pte(page_table, entry);

