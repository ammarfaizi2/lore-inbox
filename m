Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSBEVPn>; Tue, 5 Feb 2002 16:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289820AbSBEVPZ>; Tue, 5 Feb 2002 16:15:25 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:34177 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S289815AbSBEVPM>; Tue, 5 Feb 2002 16:15:12 -0500
Date: Tue, 5 Feb 2002 21:17:40 +0100
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Suspicious RLIM_INFINITY use, 2.4.17
Message-ID: <20020205211740.A278@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I came acros this (2.4.17):

fs/binfmt_aout.c:

	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
	if (rlim >= RLIM_INFINITY)
		rlim = ~0;
	if (ex.a_data + ex.a_bss > rlim)
		return -ENOMEM;

this looks like it will disable any limit checks, but no similar
code is binfmt_elf so maybe it should be removed altogether?


--- mm/mmap.c.rz   Sat Dec 29 01:02:57 2001
+++ mm/mmap.c        Tue Feb  5 19:53:59 2002
@@ -167,7 +167,7 @@
 
        /* Check against rlimit.. */
        rlim = current->rlim[RLIMIT_DATA].rlim_cur;
-       if (rlim < RLIM_INFINITY && brk - mm->start_data > rlim)
+       if (rlim != RLIM_INFINITY && brk - mm->start_data > rlim)
                goto out;
 
        /* Check against existing mmap mappings. */


Richard
