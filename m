Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUEYEx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUEYEx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUEYEx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:53:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14210
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264668AbUEYEx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:53:27 -0400
Date: Tue, 25 May 2004 06:53:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525045322.GX29378@dualathlon.random>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org> <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525042054.GU29378@dualathlon.random> <16562.52948.981913.814783@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16562.52948.981913.814783@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 09:43:00PM -0700, David Mosberger wrote:
> >>>>> On Tue, 25 May 2004 06:20:54 +0200, Andrea Arcangeli <andrea@suse.de> said:
> 
>   Andrea> the only architecture that has the accessed bit in
>   Andrea> _hardware_ via page faults I know is ia64, but I don't know
>   Andrea> if it has a mode to set it without page faults
> 
> No, it doesn't.
> 
>   Andrea> and how it is implementing the accessed bit in linux.
> 
> If the "accessed" or "dirty" bits are zero, accessing/writing the
> page will cause a fault which will be handled in a low-level
> fault handler.  The Linux version of these handlers simply turn
> on the respective bit.  See daccess_bit(), iaccess_bit(), and dirty_bit()
> in arch/ia64/kernel/ivt.S.

so you mean, this is being set in the arch section before ever reaching
handle_mm_fault? in such case my fix should work fine for ia64 too.

> Note: I'm on travel and haven't seen the context of this discussion
> and don't expect to have time to think about this until I return on
> Thursday.  So if you don't hear from me, it's not because I'm ignoring
> you... ;-)

take your time ;) thanks a lot for the above hints about those ivt.S
functions (though I don't speak ia64 asm very well ;)
