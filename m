Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTIPVMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 17:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbTIPVMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 17:12:34 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:21004 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S262060AbTIPVMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 17:12:32 -0400
Date: Tue, 16 Sep 2003 23:13:54 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Omnibook PCMCIA slots unusable after suspend. 
In-Reply-To: <7839.1063471929@cl.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0309140058440.16165-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the delay...

On Sat, 13 Sep 2003, Jon Fairbairn wrote:

> > I had a similar problem with my OB800. It turned out the
> > problem is the BIOS maps the yenta memory window into
> > legacy address range below 1MB.
> 
> This appears to be the correct diagnosis. I applied your
> patch to 2.4.22 and the Omnibook now correctly restarts the
> network after a suspend. Vielen dank!

You're welcome.

> What's the status of a patch like this? It's obviously of
> use to more than one person, and it took me a great deal of
> time to find you and your solution -- I suspect fainter
> hearted folk might just have given up and said "Linux
> doesn't work with this combination of hardware" which would
> have been a shame.

Well, I've sent it to lkml once or twice some years ago. It was apparently 
lost in the noise and I personally didn't care much resending it because 
nobody else reported a similar problem. So I've just included it in my 
local patchset - just the "fixed and forget because nobody else reports 
this problem" case ;-)

> I haven't tried it with 2.6 yet; I don't normally get into
> test kernels, but I might try out of curiosity. I'll post
> the result if anyone indicates that it's a worthwhile thing
> to do.

Right, except for some fuzz the patch should work with both 2.4 and 2.6 - 
at least it does for me. I'm not sure if this is the best possible way to 
work around the issue. But it does the job and I've taken considerable 
care to avoid breaking other boxes.

Of course I personally have no objections wrt. including it in the 
official tree. Russel, what do you think - do you want to apply it? Or 
shall I send it to Greg directly?

> > Yep, this is what happens fo me in the sitation above. And
> > the next time one inserts/ejects any card the box dies in
> > interrupt storm because the irq cannot be acknoledged.
> 
> I think I got that too, at least, reinserting the card caused
> a lockup.  With the patch applied I can eject and reinsert,
> which is fortunate because there seems to be another problem
> where the card switches off when I switch VCs, but it's hard
> to reproduce. (and inconvenient because /usr is on nfs on
> this machine)

No idea - sounds strange to me. No such problem here with any of 
serial_cs, pcnet_cs or orinoco_cs with my ob800 (neither 2.4 nor 2.6).

Martin

