Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267726AbUHWWps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267726AbUHWWps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267951AbUHWWpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:45:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:18641 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267726AbUHWW2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:28:13 -0400
Date: Mon, 23 Aug 2004 15:27:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <Pine.LNX.4.58.0408231516460.3222@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0408231526100.17766@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <20040823233249.09e93b86.ak@suse.de> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
 <Pine.LNX.4.58.0408231516460.3222@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Aug 2004, Davide Libenzi wrote:
> 
> IMHO since the GPF path is not a fast path like a page fault, we shouldn't 
> be in bad shape with the current approach. No?

I agree. Mostly. It might actually be a fairly critical path for some 
things, though. GP's happen with high frequency in emulation environments, 
ie I'd expect both vmware and dosemu to have just _tons_ of them.

Of course, in those emulation environments you usually have other things 
going on too (ie signal handling costs will likely dwarf everything else). 
So who knows..

		Linus
