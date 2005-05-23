Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVEWLZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVEWLZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 07:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVEWLZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 07:25:41 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:40321 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261219AbVEWLZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 07:25:34 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200505231125.j4NBPQoZ018751@wildsau.enemy.org>
Subject: Re: [PATCH] binutils-2.16.90.0.3: can't compile 2.4.30
In-Reply-To: <200505231113.j4NBDxLp018742@wildsau.enemy.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 23 May 2005 13:25:26 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bash-2.05# cat test.nasm 
> 
> bits    32
> section .text
> 
>         mov     eax,ds
>         mov     ds,eax
 
> of course, it's still not possible to move 32 bits into a segreg,
> so what? the processor will silently ignore the upper word, I guess.

oops ... as doesn't complain about that either .... the error is produced
when moving a segreg to a 32bit memory location, e.g.:

(nasm)
        mov     ds,long [ebx]
(as)
#APP
        movl %ds,636(%ebx)
        movl %gs,640(%ebx)
#NO_APP

neither nasm nor as do like that. I wonder which code the previous
binutils produced in that case?

sorry for the superfluos posting, I really should brush up on my assembly;-)
the consequence still is to apply the patches to the kernel.

best regards,
herbert rosmanith

