Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267014AbSKQXap>; Sun, 17 Nov 2002 18:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267016AbSKQXap>; Sun, 17 Nov 2002 18:30:45 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:54145
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267014AbSKQXao>; Sun, 17 Nov 2002 18:30:44 -0500
Message-ID: <3DD8284C.409@redhat.com>
Date: Sun, 17 Nov 2002 15:37:48 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Molnar wrote:
> here are the my current TID-setting changes. It's now 3 clone flags:
> 
>  - CLONE_PARENT_SETTID
> [...]

BTW, this patch contains one little bug.

diff -u linux/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
- --- linux/arch/i386/kernel/process.c    2002-11-17 21:11:52.000000000 +0100
+++ linux/arch/i386/kernel/process.c    2002-11-17 21:11:52.000000000 +0100
@@ -516,7 +516,7 @@
        clone_flags = regs.ebx;
        newsp = regs.ecx;
        parent_tidptr = (int *)regs.edx;
- -       child_tidptr = (int *)regs.esi;
+       child_tidptr = (int *)regs.edi;
        if (!newsp)
                newsp = regs.esp;
        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
parent_tidptr, child_tidptr);


%esi is used for the TLS pointer.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92ChN2ijCOnn/RHQRAqUnAKCa4VHC6EtZCCtArHJ9qHcznA84kACgrGNG
0niSahEXQ5aGa0XrSLSwv7A=
=YpSY
-----END PGP SIGNATURE-----

