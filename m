Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUJRRhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUJRRhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUJRRhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:37:53 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:34998 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267232AbUJRRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:37:52 -0400
Date: Mon, 18 Oct 2004 19:38:11 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 4level page tables for Linux
Message-ID: <20041018173811.GB29298@dualathlon.random>
References: <20041012135919.GB20992@wotan.suse.de> <1097606902.10652.203.camel@localhost> <20041013184153.GO17849@dualathlon.random> <20041013213558.43b3236c.ak@suse.de> <20041013200414.GP17849@dualathlon.random> <Pine.LNX.4.58.0410180957500.9916@server.graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410180957500.9916@server.graphe.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 10:02:20AM -0700, Christoph Lameter wrote:
> Would it not be best to give up hardcoding these page mapping levels into
> the kernel? Linux should support N levels. pml4,pgd,pmd,pte needs to
> disappear and be replaced by
> 
> pte_path[N]

those aren't the same thing. they may have different
format and different size, plus as Ingo pointed out we use type checking
even when they're the same size. Plus they're already an array. It's not
that simple to remove those duplicate loops, and pte[N] wouldn't mean
the level but the entry offset in the pagetable. Peraphs it's possible
to remove the loops but you'd need at least more runtime branches to
execute in each loop to understand which methods you need to execute
depending on the level you're running on. I certainly don't like the
loops myself so I see your point ;).
