Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUBCAJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUBCAJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:09:33 -0500
Received: from mail2.speakeasy.net ([216.254.0.202]:10978 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S264288AbUBCAJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:09:32 -0500
Date: Mon, 2 Feb 2004 16:09:29 -0800
Message-Id: <200402030009.i1309TeY016316@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: Linus Torvalds's message of  Monday, 2 February 2004 15:55:51 -0800 <Pine.LNX.4.58.0402021551320.9720@home.osdl.org>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Atrocious perversions
   (2) Lingering frivolity stones
   (3) Harmonic bombastic horsie perplexers
   (4) Inelegant penny invasions
   (5) Devious hysterical impositions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd suggest making this be:
>  - handle_mm_fault() take a more detailed flag ("read / write / copy", 
>    where the new "copy" part is a write that actually leaves the page 
>    only readable, but marks it dirty)

On second thought, why is it necessary to have the caller tell
handle_mm_fault "write" vs "copy"?  The existing "write" flag says do COW
and mark it dirty.  Why not just redefine it not to also mean "make the pte
writable", but rather "make the pte as writable as the vma says"?
i.e., just replace pte_mkwrite(pte) with pte_modify(pte, vma->vm_page_prot)
throughout.  That way we don't have to change all the arch/*/fault.c callers.

I think this question is orthogonal to my concern about follow_page.


Thanks,
Roland
