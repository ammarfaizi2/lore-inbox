Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbTFWLIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbTFWLIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:08:34 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:25613 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265999AbTFWLIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:08:32 -0400
Subject: Re: O(1) scheduler & interactivity improvements
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: John Bradford <john@grabjohn.com>
Cc: helgehaf@aitel.hist.no, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200306231050.h5NAo8EE000843@81-2-122-30.bradfords.org.uk>
References: <200306231050.h5NAo8EE000843@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Message-Id: <1056367355.587.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 23 Jun 2003 13:22:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 12:50, John Bradford wrote:
> > Maybe I have different a different idea of what "interactive" should be.
> 
> [snip]
> 
> > moving windows around the screen do feel jerky and laggy at best
> > when the machine is loaded. For a normal desktop usage, I prefer all
> > my intensive tasks to start releasing more CPU cycles so moving a
> > window around the desktop feels completely smooth
> 
> That's fine for a desktop box, but I wouldn't really want a heavily
> loaded server to have database queries starved just because somebody
> is scrolling through a log file, or moving windows about doing admin
> work.

I agree 100%... So this leads us to having two different set of
scheduler policies: for desktop usage, and for server usage. For desktop
usage, most of the apps need CPU bursts for a bried period of time. For
server usage, we want a more steady scheduling plan.

> If I was simply typing a letter, I wouldn't really care about
> interactivity.  If I was using a heavily loaded server to do it,
> (unlikely), I'd rather the wordprocessor was starved, and updated the
> screen once per second, and gave more time to the server processes,
> because I don't need the visual feedback to carry on typing.  Screen
> updates are a waste of CPU in that instance - it might look nice, but
> all it's doing is starving the CPU even more.

So, opaque window moving is also a waste of time and we'd better stick
to border-only (transparent) window moving ;-)

Nah! I also think it'a waste of time, but Joe-end-user won't think the
same. He'll have a better feeling using more CPU to refresh the screen
at a faster rate, even when that's a waste of CPU cycles. Look at
Windows or Mac with all those nice, CPU-wasting visual effects.

> I propose a radically different approach to scheduling, why not
> favour processes that cause the fewest cache faults?  I.E. if a
> process that gets more done in it's timeslice is more deserving of
> it.  It might look ugly with screen updates being starved, but it
> would probably get more work done :-).

What would happen with poorly written programs? There are a lot of them
that don't take advantage of memory locality, are not designed to fully
utilize the cache, or use arrays in a way that produces too much
page/cache faults.

