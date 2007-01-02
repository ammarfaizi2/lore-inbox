Return-Path: <linux-kernel-owner+w=401wt.eu-S932827AbXABLVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbXABLVW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932838AbXABLVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:21:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34373 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827AbXABLVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:21:20 -0500
Date: Tue, 2 Jan 2007 11:20:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: [patch] fix data corruption bug in __block_write_full_page()
Message-ID: <20070102112054.GC22657@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
	kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
	linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
	gordonfarquharson@gmail.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
	tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <20061229121946.GA17837@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229121946.GA17837@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 01:19:46PM +0100, Ingo Molnar wrote:
> i've extended the tracer in -rt to trace all relevant pagetable, 
> pagecache, buffer-cache and IO events and coupled the tracer to your 
> test.c code. The corruption happens here:
> 
>     test-2126  0.... 3756170us+: trace_page (cf20ebd8 b6a2c000 0)
>  pdflush-2006  0.... 6432909us+: trace_page (cf20ebd8 b6a2c000 4200420)
>     test-2126  0.... 8135596us+: trace_page (cf20ebd8 b6a2c000 4200420)
>     test-2126  0D... 9012933us+: do_page_fault (8048900 4 b6a2c000)
>     test-2126  0.... 9023278us+: trace_page (cf262f24 b6a2c000 0)
>     test-2126  0.... 9023305us > sys_prctl (000000d8 b6a2c000 000000ac)

This tracer definitly looks interesting.  Could you send a splitout
patch with it to lkml for review?

