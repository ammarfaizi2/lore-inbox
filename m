Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUEYFJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUEYFJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUEYFJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:09:47 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56452
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264767AbUEYFJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:09:44 -0400
Date: Tue, 25 May 2004 07:09:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525050937.GZ29378@dualathlon.random>
References: <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525042054.GU29378@dualathlon.random> <Pine.LNX.4.58.0405242137210.32189@ppc970.osdl.org> <Pine.LNX.4.58.0405242141150.32189@ppc970.osdl.org> <20040525045958.GY29378@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525045958.GY29378@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> all. However I wonder what happens for PROT_WRITE? How can you make a

I understood now how it works with PROT_WRITE too, it's not FOR but URE
being tweaked together with ACCESSED. This has been a very big misread I
did when I was doing alpha stuff some year ago. that's why I was so
confident it was only setting it during the first page fault and never
clearing it again. Sounds good that it can be emulated fully, I thought
it wasn't even feasible at all.

thanks a lot for pointing out this huge mistake.
