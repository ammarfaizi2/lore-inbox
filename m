Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVFWXby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVFWXby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbVFWXbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:31:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262850AbVFWXbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:31:32 -0400
Date: Thu, 23 Jun 2005 16:33:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: David Lang <david.lang@digitalinsight.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patch] urgent e1000 fix
In-Reply-To: <42BB4172.5000904@pobox.com>
Message-ID: <Pine.LNX.4.58.0506231625310.11175@ppc970.osdl.org>
References: <42BA7FB5.5020804@pobox.com> <Pine.LNX.4.62.0506231402340.18154@qynat.qvtvafvgr.pbz>
 <42BB2749.1020209@pobox.com> <Pine.LNX.4.58.0506231506510.11175@ppc970.osdl.org>
 <42BB4172.5000904@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
> 
> patch(1) is a huge collection of heuristics like this, even without 
> '-l', so I'm not surprised that it worked.
> 
> Does git-apply support patches with "fuzz", out of curiosity?

No, git is strictly "zero fuzz". So was my "dotest" script even before
switching it to "git-apply", btw (ie I explicitly had a "--fuzz=0" there
when using GNU patch).

Now, I may have to reconsider the strictness if it causes lots of
problems, and it's not like I hate fuzz (or ignoring whitespace) with a
passion. I'd just rather try to be as strict as possible at least
initially.

Your special case of a corrupted patch where a single space turned into an
empty line is actually one case I considered allowing, just because the
fuzz there wouldn't be in the data itself, only in the first character
that just tells what kind of line it is (new, deleted or unmodified), and
just saying "empty means unmodified" doesn't really introduce any
possibility of ambiguity.

So let's see what happens. Tell me if you see more of this particular kind
of corruption, and I'll just make "git-apply" work around it. I don't
think _one_ patch is much of an indication in any direction, but two or
three might convince me to just relax the checks a bit.

To actually allow real fuzz or to allow real whitespace differences in the
patch data itself is a _much_ bigger issue than this trivial patch
corruption, and I'd prefer to avoid going there if at all possible.

		Linus
