Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbTAVAGs>; Tue, 21 Jan 2003 19:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbTAVAGs>; Tue, 21 Jan 2003 19:06:48 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:32899 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267349AbTAVAGq>; Tue, 21 Jan 2003 19:06:46 -0500
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0301211749390.5658-100000@spit.local>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] restore modules compatibility
Date: Wed, 22 Jan 2003 01:15:08 +0100
Message-ID: <87el76avlf.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

> The patch below does two things:
> 1. The new param stuff suffers from serious bloat, I replaced it with a
> much simpler implementation. The interesting feature here is that even
> without changing any module all parameters are reachable from the command
> line via "<modname>.<param>=..."
> 2. I added the old module system calls back and modules are now installed
> with the ".o" suffix again, so the old modutils are working again. Special
> feature here is that the same module should be loadable with either module
> tools.
>
> The patch is against 2.5.59-um, if you don't have Jeffs patch just ignore
> the single reject.

It doesn't apply cleanly to 2.5.59, nor does it apply to 2.5.59-um:

patching file Makefile
patching file arch/i386/kernel/entry.S
Hunk #1 FAILED at 669.
1 out of 2 hunks FAILED -- saving rejects to file arch/i386/kernel/entry.S.rej
patching file arch/um/kernel/sys_call_table.c
patching file fs/proc/proc_misc.c
patching file include/asm-generic/vmlinux.lds.h
can't find file to patch at input line 132
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff -ur -X /home/roman/nodiff linux-2.5.59.org/include/asm-um/common.lds.S linux-2.5.59/include/asm-um/common.lds.S
|--- linux-2.5.59.org/include/asm-um/common.lds.S       2003-01-21 16:55:00.000000000 +0100
|+++ linux-2.5.59/include/asm-um/common.lds.S   2003-01-20 21:19:40.000000000 +0100
--------------------------
File to patch: 
Skip this patch? [y] 
Skipping patch.
1 out of 1 hunk ignored
patching file include/linux/module.h
patching file include/linux/moduleparam.h
patching file kernel/module.c
Hunk #1 FAILED at 68.
Hunk #8 FAILED at 550.
Hunk #18 FAILED at 1246.
3 out of 20 hunks FAILED -- saving rejects to file kernel/module.c.rej
patching file kernel/params.c
Hunk #2 FAILED at 28.
1 out of 4 hunks FAILED -- saving rejects to file kernel/params.c.rej
patching file scripts/Makefile.modinst
patching file modules.lds

entry.S(672): missing space at end of line
module.c(84): missing space at end of line
...

Although, "patch -l" applies without failures.

Regards, Olaf.
