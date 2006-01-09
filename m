Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWAISyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWAISyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWAISyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:54:06 -0500
Received: from solarneutrino.net ([66.199.224.43]:18692 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1030251AbWAISyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:54:01 -0500
Date: Mon, 9 Jan 2006 13:53:50 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060109185350.GG283@tau.solarneutrino.net>
References: <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net> <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local> <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local> <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org> <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org> <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 09:44:26AM +0000, Hugh Dickins wrote:
> On Sun, 8 Jan 2006, Linus Torvalds wrote:
> > 
> > Code like that should use "set_page_dirty()", which does the appropriate 
> > callbacks to the filesystem for that page. I wonder if the bug is simply 
> > because the ST code just sets the dirty bit without telling anybody else 
> > about it...
> 
> Yes, it should be using set_page_dirty_lock(), and that is already known
> about (I have patches for this and similar sg.c, but the sg.c case is
> tougher and not yet finished); but entirely irrelevant to Ryan's case.
> 
> Quite apart from the fact that he's doing backups to tape (not dirtying
> the memory from this driver), you'll find that it even passes dirty 0
> when reading into the memory (another bug; whereas sg.c conversely says
> it's always dirtying when it isn't).  So there's no point in Ryan
> fiddling with the SetPageDirty.

One thing I forgot to mention was that 2.6.11.3 had the problem too when
I reverted to it.  I remember now that the person who made the debian
bug report for this said it only happened with a 64-bit userspace - and
I switched from a 32- to 64-bit userspace when I did 2.6.11 -> 2.6.14
(and I'm too lazy to switch back).

To get the backups back, I just ran a recent kernel with
try_direct_io=0.  If there's nothing further for me to test at this
time, I guess I'll go back to doing that until there's something to try.
Is that OK?

-ryan
