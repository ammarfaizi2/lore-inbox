Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUIINhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUIINhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUIINhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:37:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51404 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263770AbUIINhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:37:04 -0400
Date: Thu, 9 Sep 2004 15:37:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
       linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
Message-ID: <20040909133703.GA32038@atrey.karlin.mff.cuni.cz>
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org> <20040905154336.B9202@castle.nmd.msu.ru> <20040905140040.58a5fcdc.akpm@osdl.org> <20040909123957.GB1065@elf.ucw.cz> <41405773.3090403@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41405773.3090403@yahoo.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>No, read() will see the modified pagecache data immediately, apart from 
> >>CPU
> >>cache coherency effects.
> >
> >
> >Is not this quite a big security hole?
> >
> >cat evil_data > /tmp/sign.me   [Okay, evil_data probably have to
> >				contain lot of zeroes?]
> >sync, fill disk or wait for someone to fill disk completely
> >
> >attempt to write good_data to /tmp/sign.me using mmap
> >
> >"Hey, root, see what /tmp/sign.me contains, can you make it suid?"
> >
> >root reads /tmp/sign.me, and sees it is good.
> >
> >root does chown root.root /tmp/sign.me; chmod 4755 /tmp/sign.me
> >
> >kernel realizes that there's not enough disk space, and discard
> >changes, therefore /tmp/sign.me reverts to previous, evil, content.
> >
> 
> root would have to make that change while user has the file open,
> and should welcome the subsequent unleashing of evil content as a
> valuable lesson.

Really? I thought that writeback is not synchronous at close()
time.... Hmm.... It probably could be in case of mmap....

It is still pretty unexpected. Like "root sees you have that file
open, so he stops you via ptrace".... but ok....
							Pavel
