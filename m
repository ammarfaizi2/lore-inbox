Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289198AbSBJC3w>; Sat, 9 Feb 2002 21:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289201AbSBJC3m>; Sat, 9 Feb 2002 21:29:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6415 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289198AbSBJC3b>; Sat, 9 Feb 2002 21:29:31 -0500
Subject: Re: [PATCH] BUG preserve registers
To: akpm@zip.com.au (Andrew Morton)
Date: Sun, 10 Feb 2002 02:41:53 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), hugh@veritas.com (Hugh Dickins),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <3C659D8A.37EA0155@zip.com.au> from "Andrew Morton" at Feb 09, 2002 02:07:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Zjw9-0000Dr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This works for me, from in-kernel as well as in-module.  It'd
> be good if someone more familiar with x86 could check it over.

This looks a really bad reversion. The CONFIG_DEBUG_BUGVERBOSE ifdef saves
over 70K of memory on my standard kernel build. Putting the file name pointers
back in everywhere is going to put a fair amount of that back except on 
very new gcc's that maybe will do string merging in this case. Have you
verified string merging occurs in gcc 2.95 for __FILE__ string constants
passed into asm blocks ? 

I also don't understand what the problem you are trying to solve is. If you
want to debug the kernel you build with debug verbose. If not you don't.
With the symbol table you can still easily trace down BUG events.

Alan
