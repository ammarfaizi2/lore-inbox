Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbUJ2Two@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbUJ2Two (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbUJ2Tve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:51:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:49883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262045AbUJ2T1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:27:00 -0400
Date: Fri, 29 Oct 2004 12:26:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0410291217460.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410291225370.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com>
 <Pine.LNX.4.58.0410291217460.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, Linus Torvalds wrote:
> 
> 
> Here's a totally untested patch to make the semaphores use "fastcall" 
> instead of "asmlinkage", and thus pass the argument in %eax instead of on 
> the stack. Does it work? I have no idea. If it does, it should fix the 
> particular bug that started this thread..

Oh, sorry, please remove this part, it was totally unintentional (I _told_ 
you this wasn't tested):

> --- 1.4/include/asm-i386/linkage.h	2004-10-16 18:24:37 -07:00
> +++ edited/include/asm-i386/linkage.h	2004-10-29 11:32:18 -07:00
> @@ -1,7 +1,7 @@
>  #ifndef __ASM_LINKAGE_H
>  #define __ASM_LINKAGE_H
>  
> -#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
> +#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(3)))
>  #define FASTCALL(x)	x __attribute__((regparm(3)))
>  #define fastcall	__attribute__((regparm(3)))
>  

We're not making all asmlinkage things fastcalls here, we're only doing 
the semaphores..

		Linus
