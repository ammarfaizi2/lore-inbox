Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265163AbUEYWHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUEYWHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUEYWHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:07:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:8586 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265133AbUEYWCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:02:07 -0400
Date: Tue, 25 May 2004 15:01:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525215500.GI29378@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0405251500250.9951@ppc970.osdl.org>
References: <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525212720.GG29378@dualathlon.random>
 <Pine.LNX.4.58.0405251440120.9951@ppc970.osdl.org> <20040525215500.GI29378@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Andrea Arcangeli wrote:
> 
> I expected the pal code to re-read the pte if the control bits asked for
> page fault, like it must happen if the control bits are set to
> non-present.

That may or may not be true. I _think_ it wasn't true.

> This latter this must be true or linux wouldn't run at all
> on alpha.

A "not-present" fault is a totally different fault from a "protection 
fault". Only the not-present fault ends up walking the page tables, if I 
remember correctly.

The PAL-code sources are out there somewhere, so I guess this should be 
easy to check if I wasn't so lazy.

		Linus
