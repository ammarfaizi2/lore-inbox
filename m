Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSLOD6U>; Sat, 14 Dec 2002 22:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbSLOD6U>; Sat, 14 Dec 2002 22:58:20 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:3859 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266322AbSLOD6S>;
	Sat, 14 Dec 2002 22:58:18 -0500
Date: Sat, 14 Dec 2002 23:06:09 -0500 (EST)
Message-Id: <200212150406.gBF469M482759@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, terje.eggestad@scali.com
Subject: Re: Intel P6 vs P7 system call performance
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


H. Peter Anvin writes:

> As far as I know, though, the SYSENTER patch didn't deal with several of
> the corner cases introduced by the generally weird SYSENTER instruction
> (such as the fact that V86 tasks can execute it despite the fact there
> is in general no way to resume execution of the V86 task afterwards.)
>
> In practice this means that vsyscalls is pretty much the only sensible
> way to do this.  Also note that INT 80h will need to be supported
> indefinitely.
>
> Personally, I wonder if it's worth the trouble, when x86-64 takes care
> of the issue anyway :)

There is another way:

Have apps enter kernel mode via Intel's purposely undefined
instruction, plus a few bytes of padding and identification.
Require that this not cross a page boundry. When it faults,
write the SYSENTER, INT 0x80, or SYSCALL as needed. Leave
the page marked clean so it doesn't need to hit swap; if it
gets paged in again it gets patched again.


