Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264730AbTGBFoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 01:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264740AbTGBFoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 01:44:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56294
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264730AbTGBFoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 01:44:01 -0400
Date: Wed, 2 Jul 2003 07:57:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Bernardo Innocenti <bernie@develer.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Message-ID: <20030702055759.GJ3040@dualathlon.random>
References: <200307020232.20726.bernie@develer.com> <20030701173612.280d1296.akpm@digeo.com> <200307020424.47629.bernie@develer.com> <16130.21283.122787.362837@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16130.21283.122787.362837@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 01:36:03PM +1000, Peter Chubb wrote:
> Platforms that never expect to deal with a 64-bit number just redefine
> the macro in terms of long.  Which means that printing out long longs

this doesn't even sounds safe. If it's just for printing not a big deal,
but there may be functional usages where they should not truncate the
high 32bit of the 64bit words.

Bernardo, you should definitely add an #if BITS_PER_LONG == 64 around
your implementation of do_div in asm-generic, just to make an example
sparc is still silenty broken (and that's not an embedded thing).

In the #else path of the generic implementation you can consider adding
another version that casts to (long long), then as worse it will spwan a
link compile time failure. But if it compiles it won't generate runtime
failures. so basically it's up to gcc to do the right thing then.

Andrea
