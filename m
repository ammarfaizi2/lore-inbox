Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUEQOOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUEQOOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUEQOOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:14:35 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:10152 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261425AbUEQOOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:14:34 -0400
Date: Mon, 17 May 2004 07:14:27 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Cole <elenstev@mesatop.com>, Larry McVoy <lm@bitmover.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040517141427.GD29054@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Steven Cole <elenstev@mesatop.com>, Larry McVoy <lm@bitmover.com>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
	adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com> <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org> <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 10:17:58PM -0700, Linus Torvalds wrote:
> > Found null start 0x1550b01 end 0x1551000 len 0x4ff line 535587
> > Found null start 0x2030b01 end 0x2031000 len 0x4ff line 639039
> > Found null start 0x2330b01 end 0x2331000 len 0x4ff line 663611
> 
> The fact that it's always zeroes, and it's an strange number but it always 
> ends up being page-aligned at the _end_ makes me strongly suspect that we 
> have one of the "don't write back data past i_size" things wrong.

Isn't it weird that it is starting at 0xb01 and has the same length at
three different offsets?  That's a definite pattern and might be a clue.
And note that the weird starting offset plus the length is a page size.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
