Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281794AbRLZTYE>; Wed, 26 Dec 2001 14:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbRLZTXz>; Wed, 26 Dec 2001 14:23:55 -0500
Received: from ssh.elis.rug.ac.be ([157.193.67.1]:33236 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S281794AbRLZTXn>; Wed, 26 Dec 2001 14:23:43 -0500
Date: Wed, 26 Dec 2001 20:22:21 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <alad@hss.hns.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Weird __put_user_asm behavior
In-Reply-To: <000901c18e07$e2877d10$010411ac@local>
Message-ID: <Pine.LNX.4.33.0112262011190.19463-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

> The old code evaluates addr once, your new code evaluates it twice.
> Have you tried an inline function instead of a macro?
> linux/fs/binfmt_elf.c contains a few lines that probably break if 'addr' 
> is evaluated twice:
> <<<<<<<
>         argv = (elf_caddr_t *) sp;
>         if (!ibcs) {
>                 __put_user((elf_addr_t)(unsigned long) envp,--sp);
>                 __put_user((elf_addr_t)(unsigned long) argv,--sp);
>         }
> <<<<<<<<<

Double evaluation of the (addr) expression seems to be my problem, not 
register clobbering as I first thought. Although all the macro's that are 
using __put_user_asm also use
	__typeof__(*(addr)) *__their_local_addr = (addr);
	// further use __their_local_addr ...
one apparently needs to repeat this 'localization' of (addr) in order to 
have only one evaluation of (addr) at the end.
I always found the macro paragraph in my first C book -'A Book on C'- a 
little too short :).

Anyway, thanks to all for the help.

Frank.

