Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTJ3V2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbTJ3V2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:28:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:23980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262855AbTJ3V2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:28:13 -0500
Date: Thu, 30 Oct 2003 13:30:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: sluskyb@paranoiacs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-Id: <20031030133000.6a04febf.akpm@osdl.org>
In-Reply-To: <3FA15506.B9B76A5D@users.sourceforge.net>
References: <20031030134137.GD12147@fukurou.paranoiacs.org>
	<3FA15506.B9B76A5D@users.sourceforge.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu <jariruusu@users.sourceforge.net> wrote:
>
> Ben Slusky wrote:
> > The attached patch changes the loop device transfer functions (including
> > cryptoloop transfers) to accept page/offset pairs instead of virtual
> > addresses, and removes the redundant kmaps in do_lo_send, do_lo_receive,
> > and loop_transfer_bio. Per Andrew Morton's request a while back.
> 
> Cryptoloop is not the only user of loop transfer interface. Please don't
> change that interface as it breaks code outside of mainline kernel.

We really should not retain ugly interfaces in the mainline kernel because
some external, unmerged piece of code relies on the old interfaces.  That
way lies madness.

Especially as that external code has, I think, remained unmerged for years,
and there appears to be no momentum moving it forwards.

We *have* to get the mainline codebase up-to-date with current kernel
idioms and working as well as possible.  If you want to submit sane-sized
and documented patches to help us get there then sheesh, go wild.  But
please do not try to stop the rest of us.

> Cryptoapi interface is quite broken. Your change extends that breakage to
> loop transfer interface. Please don't do that.

Please describe this breakage.


Ben, I confess that I'd forgotten about #1198.  I'll take a look at your
memory allocation fix - it seems to be unfortunately large, but we may need
to go that way.

One question is: why do we go down a different code path for blockdevs
nowadays anyway?  The handoff to the loop thread seems to work OK for
file-backed loop, and providing a bmap() for blockdevs is easy enough?


