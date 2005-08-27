Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbVH0CeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVH0CeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 22:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVH0CeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 22:34:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:25506 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030276AbVH0CeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 22:34:23 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: rml@novell.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
References: <1125094725.18155.120.camel@betsy>
	<20050826225848.GC28191@mipter.zuzino.mipt.ru>
	<20050826.161537.03992270.davem@davemloft.net>
From: Andi Kleen <ak@suse.de>
Date: 27 Aug 2005 04:34:07 +0200
In-Reply-To: <20050826.161537.03992270.davem@davemloft.net>
Message-ID: <p73vf1skt0g.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Sat, 27 Aug 2005 02:58:48 +0400
> 
> > What's the point of having unlikely() attached to every possible if ()?
> 
> If can result in smaller code, for one thing, even if it
> isn't a performance critical path.

Really? At least on x86 it tends to generate bigger code when 
block reordering is enabled because a jump forward and a jump
backward and a possible label alignment are bigger than just
a single jump forward. But then it doesn't make that much difference
because the compiler does it on its own for every block.

On x86-64 I keep it disabled because:
- it generates bigger code
- it makes the assembly code unreadable
- it doesn't seem to help that much on modern CPUs with good
branch prediction and big icaches anyways.

-Andi (who originally introduced likely/unlikely, but regrets it these
days because it's far overused and makes code uglier everywhere)
