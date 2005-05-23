Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVEWLOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVEWLOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 07:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVEWLOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 07:14:16 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:39041 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261195AbVEWLOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 07:14:10 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200505231113.j4NBDxLp018742@wildsau.enemy.org>
Subject: Re: [PATCH] binutils-2.16.90.0.3: can't compile 2.4.30
In-Reply-To: <200505221121.j4MBL96E018487@wildsau.enemy.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 23 May 2005 13:13:56 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> it's not right to try to 32bit move a segment register anyway.

hmm ... sorry for writing without checking. it's true that
as complains. but for e.g. nasm, it's no problem at all.
e.g. if you consider this example:

bash-2.05# cat test.nasm 

bits    32
section .text

        mov     eax,ds
        mov     ds,eax

bash-2.05# nasm -f elf test.nasm 
bash-2.05# objdump -d test.o

test.o:     file format elf32-i386

Disassembly of section .text:

00000000 <.text>:
   0:   8c d8                   movl   %ds,%eax
   2:   8e d8                   movl   %eax,%ds


of course, it's still not possible to move 32 bits into a segreg,
so what? the processor will silently ignore the upper word, I guess.
(my ix86 handbook is in the office, so I can't look it up).

so, this probably means that it's *not* the linux kernel which contains
wrong code, but as from binutils-2.16 is being to restrictive when
doing sanity checking, agreed?

best regards,
herbert rosmanith

