Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUEYQUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUEYQUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUEYQUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:20:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:53476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264961AbUEYQUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:20:00 -0400
Date: Tue, 25 May 2004 09:19:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Keith M Wesolowski <wesolows@foobazco.org>
cc: Matthew Wilcox <willy@debian.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525153501.GA19465@foobazco.org>
Message-ID: <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525153501.GA19465@foobazco.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Keith M Wesolowski wrote:
> 
> Some sparc32 CPUs are also vulnerable to this race; in fact the
> supersparc manual describes it specifically and even outlines the
> compare-exchange loop using our rotten swap instruction.  In our case,
> the race is with a hardware walker.

Yes, but the sparc32 page tables are not the same as the linux kernel page 
tables, so in your case it's a different path and a different page table. 
Only the shared case really matters (ie things that do hw/microcode walk 
of a page table _tree_ not a hash).

		Linus
