Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUHFQuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUHFQuN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUHFQri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:47:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:4294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268186AbUHFQoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:44:08 -0400
Date: Fri, 6 Aug 2004 09:43:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
In-Reply-To: <m3wu0cgv6q.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0408060941550.24588@ppc970.osdl.org>
References: <2qbyt-1Op-45@gated-at.bofh.it> <2qemF-3Pj-49@gated-at.bofh.it>
 <m3wu0cgv6q.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Aug 2004, Andi Kleen wrote:
> 
> You could use .altinstructions to patch a jump in at runtime
> based on CPU capabilities. Assuming MMX is really faster of course.

I seriously doubt that the MMX code could be faster.

The only MMX code in the original was saving some integer contents to a 
scratch MMX register rather than saving to memory. There's _no_ way that 
is faster, especially since in the kernel it would require us much extra 
work to first check that the FP context is safed. Even _without_ the extra 
work I simply cannot imagine that a "movd reg,mmx" is faster than a plain 
"movl reg,stackslot". 

		Linus
