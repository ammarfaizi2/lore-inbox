Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTARHOx>; Sat, 18 Jan 2003 02:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTARHOx>; Sat, 18 Jan 2003 02:14:53 -0500
Received: from dp.samba.org ([66.70.73.150]:39566 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263039AbTARHOw>;
	Sat, 18 Jan 2003 02:14:52 -0500
Date: Sat, 18 Jan 2003 18:23:31 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recent change to exit_mmap
Message-ID: <20030118072331.GF7800@krispykreme>
References: <20030118060522.GE7800@krispykreme> <20030117230014.2647791a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117230014.2647791a.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On seconds thoughts...
> 
> Are the first two SET_PERSONALITY() calls in there actually doing anything? 
> Perhaps you're right, and we only need the one at line 615, whcih is in the
> right place?

Sounds good. The following patch tests out OK.

Anton

===== fs/binfmt_elf.c 1.34 vs edited =====
--- 1.34/fs/binfmt_elf.c	Mon Nov 25 19:59:02 2002
+++ edited/fs/binfmt_elf.c	Sat Jan 18 18:16:52 2003
@@ -536,8 +536,6 @@
 			    strcmp(elf_interpreter,"/usr/lib/ld.so.1") == 0)
 				ibcs2_interpreter = 1;
 
-			SET_PERSONALITY(elf_ex, ibcs2_interpreter);
-
 			interpreter = open_exec(elf_interpreter);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
@@ -578,9 +576,6 @@
 			// printk(KERN_WARNING "ELF: Ambiguous type, using ELF\n");
 			interpreter_type = INTERPRETER_ELF;
 		}
-	} else {
-		/* Executables without an interpreter also need a personality  */
-		SET_PERSONALITY(elf_ex, ibcs2_interpreter);
 	}
 
 	/* OK, we are done with that, now set up the arg stuff,
