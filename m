Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUJOSQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUJOSQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUJOSQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:16:40 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:22243 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268236AbUJOSQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:16:38 -0400
Date: Fri, 15 Oct 2004 20:14:46 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015181446.GF17849@dualathlon.random>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube> <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube> <20041015171355.GD17849@dualathlon.random> <1097862714.2666.13650.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097862714.2666.13650.camel@cube>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 01:51:56PM -0400, Albert Cahalan wrote:
> Sure. That's not because of RSS. It's for TRS and DRS,
> which are supposed to be RSS-like values specific to
> text (code) and data.

And they're not RSS-like right now if you pick them from statm, the only
RSS-like variable is rss itself in 2.6 ;).

	*data = mm->total_vm - mm->shared_vm

all those are virtual, not physical. dunno about 2.4, but I doubt 2.4
would be much different, rss + shared where the only physical driven
things in 2.4 IIRC. (now only rss is left, and Hugh's patch adds
anon_rss back)

to me TRS and DRS have always been _virtual_ when I read the ps output,
obviously since DRS tends to be orders of magnitude bigger than RSS
itself ;).

> The VM size of text is TSIZ, and of data is DSIZ.
> These numbers, while useful, are not the same thing.

those should come out of statm pretty nicely.

> A user can configure top to display other columns if
> he has a box that can't handle /proc/*/statm well.
> The file will not be read if it is not needed.
> Start top, then do:
> 
> f     enters field modification screen
> o     disable VIRT
> q     disable RES
> t     disable SHR
> n     disable %MEM
> enter exits field modification screen
> W     writes a ~/.toprc file
> 
> So, what is the problem again?  :-)

that you can't get those values efficiently. Even assuming you're ok to
drop shared by disabling SHR, it wouldn't help, without a kernel API
change.

> Well, as long as it makes the users happy... I don't personally
> care, except to say that I don't care to document all sorts
> of kernel-specific variations. It gets hopelessly messy.

Yep, I believe users could be happy with Hugh's rss-anon_rss variant.
