Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbTDUXeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbTDUXeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:34:36 -0400
Received: from zero.aec.at ([193.170.194.10]:2569 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262713AbTDUXeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:34:31 -0400
Date: Tue, 22 Apr 2003 01:46:11 +0200
From: Andi Kleen <ak@muc.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030421234611.GA15191@averell>
References: <20030421192734.GA1542@averell> <Pine.LNX.4.44.0304211254190.17221-100000@home.transmeta.com> <20030421205333.GA13883@averell> <20030421233557.GB17595@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421233557.GB17595@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 01:35:57AM +0200, Jamie Lokier wrote:
> Andi Kleen wrote:
> > The patching code is quite generic and could be used to patch other
> > instructions
> 
> Such as removing the lock prefix when running non-SMP?

Yes, could work. But you need a new variant of alternative()
or eat worse code. The current alternative() can only handle
constant sized original instructions, which requires that you
use a constant sized constraint (e.g. (%0) ... "r" (ptr)) etc.)
"m" is unfortunately variable size.

For the special case of lock it would still work because you
only need to patch the prefix away, not replace the whole 
instruction, but that requires a new macro.

Also when you do that I would start to think about discarding the
.altinstructions section after load to avoid too much kernel bloat (it
currently costs 7 byte + the length of the replacement. And lock
is quite common in the kernel these days.

-Andi
