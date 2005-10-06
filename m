Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVJFTDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVJFTDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVJFTDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:03:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751308AbVJFTDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:03:38 -0400
Date: Thu, 6 Oct 2005 12:03:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert Derr <rderr@weatherflow.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.13.3 Memory leak, names_cache
In-Reply-To: <43456E31.8000906@weatherflow.com>
Message-ID: <Pine.LNX.4.64.0510061150290.31407@g5.osdl.org>
References: <43456E31.8000906@weatherflow.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Robert Derr wrote:
> 
> I'm having a problem with a memory leak in the kernel.  I'm running 2.6.13.3
> from kernel.org on FC4 on a Dell  Poweredge 2850 Duel Xeon 3ghz with 2GB RAM.

Just out of interest, do you have CONFIG_AUDIT_SYSCALL enabled? Does it go 
away if you disable it?

Also, what filesystems do you use? And if you run

	while : ; do cat /proc/slabinfo | grep names_cache ; sleep 2; done

in one terminal, can you see if you can find any correlation to some 
particular action or behaviour that would seem to be part of leaking it?

It really shouldn't grow very big at all normally. Ie the counts are 
normally something like a few tens of entries used or whatever - all the 
allocations should basically be temporary, and your 200+ _thousand_ 
entries are way out of line.

If you can't find anything obvious, then we can try to figure out a way to 
just print out the contents of your name entries, I bet that would give a 
clue about who is allocating them. But there's also been various leak 
debugging patches out there that may help.  Manfred may have pointers.

		Linus
