Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUEZHG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUEZHG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265330AbUEZHG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:06:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7073
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265327AbUEZHG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:06:26 -0400
Date: Wed, 26 May 2004 09:06:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040526070617.GN29378@dualathlon.random>
References: <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525212720.GG29378@dualathlon.random> <Pine.LNX.4.58.0405251440120.9951@ppc970.osdl.org> <20040525215500.GI29378@dualathlon.random> <Pine.LNX.4.58.0405251500250.9951@ppc970.osdl.org> <20040526021845.A1302@den.park.msu.ru> <20040525224258.GK29378@dualathlon.random> <Pine.LNX.4.58.0405251924360.15534@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405251924360.15534@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 07:26:21PM -0700, Linus Torvalds wrote:
> You're reading it wrong.
> 
> The "including when the present flag is set to zero" part does not mean 
> that the present flag was zero _before_, it means "is being set to zero" 
> as in "having been non-zero before that".

"having been non-zero before that" makes a lot more sense indeed, the
wording in the specs wasn't the best IMHO.  Interestingly the
ptep_establish at the end of handle_pte_fault would have hidden any
double fault completely, nobody but a tracer would have noticed that,
but it made very little sense that non-present entries can be cached.
It's all clear now thanks.
