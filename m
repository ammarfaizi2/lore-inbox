Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTENFZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTENFZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:25:13 -0400
Received: from holomorphy.com ([66.224.33.161]:40640 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262143AbTENFZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:25:10 -0400
Date: Tue, 13 May 2003 22:37:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: gibbs@scsiguy.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ahc_linux_map_seg() compile/style/data corruption fixes
Message-ID: <20030514053747.GE2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	gibbs@scsiguy.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20030514044934.GC29926@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514044934.GC29926@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 09:49:34PM -0700, William Lee Irwin III wrote:
> This is basically a compilefix for axel@pearbough.net's compile failure,
> with some added cleanup. (2) should cause data corruption on x440,
> NUMA-Q, and ES7000 almost every time this is called, so I guess this
> qualifies as a runtime bugfix too. Oddly, I'm not seeing any even on
> 64GB NUMA-Q, so it's probably bouncing due to some other bug.
> For the connoisseur, I've attached before/after disassemblies
> demonstrating that the if () whose failure is caused by (2) is a very,
> very, very real problem. In order to isolate the code, I uninlined
> ahc_linux_map_seg() so the code could be isolated from the rest of
> everything. It's clear well over half the function was missing before.
> Also note the calls to panic() are made by jmps to the end of the
> function. This is 5f in the -'s, and f3 in the +'s. i.e. you can
> very easily tell from the disassembly that one of the panic()'s is
> missing, i.e. the if () in question is compiled out.

Hmm, 2.5.x is supposed to guarantee most (if not all) of the
preconditions the code here is trying to (re)establish. Probably the
only use of not ripping out the 4GB spanning code and segment count
checks is to keep driver versions synched. As it stands, this doesn't
compile and if ever invoked the code not needed for 2.5 will not behave
as expected (though thankfully a nop). Maybe a (shudder) #ifdef to rip
out the overhead for 2.5 should be added esp. as post gcc-3.0 probably
can't compile earlier kernels anyway.


-- wli
