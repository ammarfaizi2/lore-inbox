Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265080AbUEYVRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUEYVRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUEYVRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:17:04 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34746
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265080AbUEYVP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:15:28 -0400
Date: Tue, 25 May 2004 23:15:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-ID: <20040525211522.GF29378@dualathlon.random>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 04:10:29PM -0400, Rik van Riel wrote:
> Fragmentation causes fork trouble (gone with the 4k stacks)

btw, the 4k stacks sounds not safe to me, most people only tested with
8k stacks so far, I wouldn't make that change in a production tree
without an unstable cycle of testing in between. I'd rather risk a
an allocation failure than a stack memory corruption.

x86-64 has per-irq stacks that allowed to reduce the stack size to 8k
(which is very similar to 4k for an x86, but without per-irq stack it's
too risky).

as for the dcache size, I can certainly imagine you can measure slowdown
bigger than 4:4 in some very vfs intensive workload, but the stuff that
needs 32G of ram normally uses only rawio or a few huge files as storage
anyways. as for the kiobufs they're long gone in 2.6.

Possibly some webserving could use 32G as pure pagecache for the
webserver with tons of tiny files, for such an app the 2:2 or 1:3 model
should be better than 4:4.
