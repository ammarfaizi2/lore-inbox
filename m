Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTATNEN>; Mon, 20 Jan 2003 08:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbTATNEN>; Mon, 20 Jan 2003 08:04:13 -0500
Received: from holomorphy.com ([66.224.33.161]:53385 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265711AbTATNEM>;
	Mon, 20 Jan 2003 08:04:12 -0500
Date: Mon, 20 Jan 2003 05:13:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: out of place comment fs/binfmt_elf.c:365
Message-ID: <20030120131312.GM780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301200052070.8560-100000@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301200052070.8560-100000@skynet>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 12:53:19AM +0000, Dave Airlie wrote:
> in fs/binfmt_elf.c around line 365 in 2.5 and same sorta place in 2.4 is a
> comment like so...
> /* Now use mmap to map the library into memory. */
> but the code proceeds to do no such thing.. it has done it already....
> the next lines are another comment stating now fill out the bss..
> Dave.

It looks like code got shuffled around into elf_map() and no one
bothered moving the comment alongside the corresponding code. And
it's actually mapping the interpreter. There's a second comment
which is actually accurate there; I suspect the interpreter mapping
code was copied from the library mapping code without resynching the
comment either.

-- wli


Realign ancient comment with modern source, including adjusting the
name of the function said to be used to map things.

 binfmt_elf.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -urpN mpc-2.5.59-2/fs/binfmt_elf.c elf-2.5.59-1/fs/binfmt_elf.c
--- mpc-2.5.59-2/fs/binfmt_elf.c	2003-01-16 18:22:06.000000000 -0800
+++ elf-2.5.59-1/fs/binfmt_elf.c	2003-01-20 05:11:16.000000000 -0800
@@ -335,6 +335,7 @@ static unsigned long load_elf_interp(str
 	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
 	    	elf_type |= MAP_FIXED;
 
+	    /* Now use elf_map() to map the interpreter into memory. */
 	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
 	    if (BAD_ADDR(map_addr))
 	    	goto out_close;
@@ -362,8 +363,6 @@ static unsigned long load_elf_interp(str
 	  }
 	}
 
-	/* Now use mmap to map the library into memory. */
-
 	/*
 	 * Now fill out the bss section.  First pad the last page up
 	 * to the page boundary, and then perform a mmap to make sure
