Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968066AbWLEDpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968066AbWLEDpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 22:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968070AbWLEDpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 22:45:01 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43399 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968065AbWLEDo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 22:44:59 -0500
Date: Mon, 4 Dec 2006 19:44:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Centralise definitions of sector_t and blkcnt_t
In-Reply-To: <20061204103830.GA3013@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0612041941220.3476@woody.osdl.org>
References: <20061204103830.GA3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2006, Matthew Wilcox wrote:
> 
> CONFIG_LBD and CONFIG_LSF are spread into asm/types.h for no particularly
> good reason.  Centralising the definition in linux/types.h means that arch
> maintainers don't need to bother adding it, as well as fixing the problem
> with x86-64 users being asked to make a decision that has absolutely no
> effect.  The H8/300 porters seem particularly confused since I'm not aware
> of any microcontrollers that need to support 2TB filesystems.

Applied, since this is a good cleanup regardless.

I'd still be open to switching things around further, and allow even 
64-bit architectures to say that they only want 32-bit sector_t's and page 
indexes (ie remove the "depends on !64BIT" and make the "unsigned long" 
case actually be "u32" instead, so that it literally switches between 
32-bit or 64-bit values _regardless_ or architecture).

I don't know how big a deal it is, but I could imagine that we could 
actually save memory in a smaller "struct page", for example, on 64bit 
architectures by just using a 4-byte index.

For now, the !64BIT makes sense simply because a 64-bit architecture 
probably doesn't care, and might as well just use 64 bits anyway (ie you 
tend to have tons of memory there anyway). And I suspect it doesn't 
actually even help on 64-bits due to structure alignment etc issues, but 
am too lazy to go check.

Just thought I'd mention the possibility, in other words.

		Linus
