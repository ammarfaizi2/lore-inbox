Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVFDQCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVFDQCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 12:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFDQCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 12:02:08 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:35712 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261355AbVFDQCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 12:02:05 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200506041601.j54G1nrq022039@wildsau.enemy.org>
Subject: Re: [PATCH] struct thread_struct, asm-i386/processor.h: wrong datatype?
In-Reply-To: <200506041543.j54Fh7xv018234@wildsau.enemy.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Date: Sat, 4 Jun 2005 18:01:49 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


or better: 

> -       unsigned long   fs;
> -       unsigned long   gs;
> +       unsigned short  fs;
> +       unsigned short  gs;
>  /* Hardware debugging registers */
>         unsigned long   debugreg[8];  /* %%db0-7 debug registers */
>  /* fault info */

+ unsigned short fs, __fsh; 
+ unsigned short gs, __gsh; 

which is also done this way the structure above, the TSS. I don't know
why it's done this way, but I guess it's probably better pad with 16 bits
to avoid potential problems with 32bit movl which might overwrite portions
of the next field.

kind regards,
herbert rosmanith

