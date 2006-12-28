Return-Path: <linux-kernel-owner+w=401wt.eu-S1754897AbWL1R3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbWL1R3H (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbWL1R3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:29:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46079 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754897AbWL1R3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:29:04 -0500
Date: Thu, 28 Dec 2006 09:27:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       David Miller <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <20061228101311.GA9672@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612280917000.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net>
 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net>
 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
 <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
 <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
 <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
 <20061228101311.GA9672@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, Russell King wrote:
> 
> and if you look at glibc's memset() function, you'll notice that's exactly
> what you expect if you pass a non-8bit value to it.  Ergo, what you're
> seeing is utterly expected given glibc's memset() implementation on ARM.

Guys, you _really_ should fix memset(). What you describe is a _bug_. 

"memset()" takes an "int" as its argument (always has), and has to convert 
it to a byte _itself_. It may not be common, but it's perfectly normal, to 
pass it values outside 0-255 (negative values that still fit in a "signed 
char" in particular are very normal, but my usage of "let the thing 
truncate it itself" is also quite fine).

> Fixing Linus' test program to pass nr & 255 to memset

No. I'm almost certain that that is not a "fix", it's a workaround for a 
serious bug in your glibc crap.

But it does explain all the unexpected strange behaviour (and the really 
small writeback size - now it doesn't need any /proc/sys/vm/dirty_ratio 
assumptions to be explicable.

		Linus
