Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbTLNF1g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 00:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbTLNF1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 00:27:35 -0500
Received: from dp.samba.org ([66.70.73.150]:10428 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265352AbTLNF1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 00:27:34 -0500
Date: Sun, 14 Dec 2003 16:23:30 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: prepare_to_wait/waitqueue_active issues in 2.6
Message-ID: <20031214052330.GN17683@krispykreme>
References: <20031214034059.GL17683@krispykreme> <20031214035356.GM17683@krispykreme> <Pine.LNX.4.58.0312132024270.14336@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312132024270.14336@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Pardon my French, but this patch sure looks like crap.

I agree. Your patch wins, and that comment would even pass akpm best
practices.

> So my preference would be to add the barrier into prepare_to_wait(), along
> with a comment on why it is sometimes needed.  Something like the
> appended.. (which just uses "set_current_state()", since that's what it
> exists for).

And thats pretty much how 2.4 handled the problem (set_task_state sits
between the waitqueue addition and the test). That still leaves kswapd
with problems, but in low memory conditions we'll be calling it often so
one lost wakeup here and there shouldnt matter.

Anton
