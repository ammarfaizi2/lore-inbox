Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTICMle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTICMle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:41:34 -0400
Received: from smtp02.fuse.net ([216.68.1.133]:63995 "EHLO smtp02.fuse.net")
	by vger.kernel.org with ESMTP id S262038AbTICMlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:41:32 -0400
From: "Dale E Martin" <dmartin@cliftonlabs.com>
Date: Wed, 3 Sep 2003 08:41:31 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more details)
Message-ID: <20030903124131.GA842@cliftonlabs.com>
References: <20030902123050.GA854@cliftonlabs.com> <20030902130323.41d2fdca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902130323.41d2fdca.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like it.  Please add a DB() to the start of i8042_interrupt(),
> see if we locked up in an interrupt storm.

I believe this is what's happening - i8042_interrupt is getting called at a
very fast rate and we never do anything else.  (I suppose that's the
definition of an interrupt storm - this is my first foray into kernel
programming aside from fixing compiler errors.)

As others have suggested, booting with "pci=noacpi" fixes the problem.
(Leaving the debug statement in there, I'd estimate that i8042_interrupt
gets called at about 25 times a second - about a screenfull a second or
so.)

So, anyone else with this problem can plug in a PS/2 mouse or boot with
"pci=noacpi" to work around it.

The last thing I would mention is that 2.5.75 ran fine on this machine, so
I guess this problem has crept in since then.

> There's an ugly in the irq code there: if i8042_check_mux() or
> i8042_check_mux() are called while the device is open we end up freeing
> the wrong IRQ.  It is unlikely to help though.

I did apply this patch, and it did not visibly help.

Thanks for the help, let me know if you'd like me to try anything else.

Take care,
     Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
