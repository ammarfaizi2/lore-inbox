Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAIGX3>; Tue, 9 Jan 2001 01:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIGXT>; Tue, 9 Jan 2001 01:23:19 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:28861 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129401AbRAIGXE>;
	Tue, 9 Jan 2001 01:23:04 -0500
Date: Tue, 9 Jan 2001 07:25:27 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19pre6aa1 degraded performance for me...
In-Reply-To: <20010109021805.Q27646@athlon.random>
Message-ID: <Pine.LNX.4.30.0101090722580.22161-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Andrea Arcangeli wrote:

> On Mon, Jan 08, 2001 at 10:46:29PM +0100, Sasi Peter wrote:
> > What I had w/2.2.18pre19 (+raid+ide):
> > ~80MB more in cache and ~80MB swapped out (eg. currently unused notes
> > server and squid) There is enough of swap over 3 disks (like the
> > raid), so I did not bother disabling squid and notes, since - I thought -
> > they would only take up some swap unused.
>
> There are many variables. However I guess the slowdown is because your idle
> apps didn't got swapped out in favour of cache as you noticed. An aggressive
> aging algorithm would probably fix that but it then would hurt other cases
> (after you don't need a frequenty accessed part of filesystem cache anymore it
> would take ages before it gets collected potentially causing an unnecessary
> swapout storms because the kernel doesn't know you don't need such cache
> anymore).  Furthmore if notes and squid are rarely running but they provides
> critical services if they would go totally into swap in favour of fs cache you
> would get very bad latencies the first time somebody connects to the server. So
> the fix I suggest you is to buy more ram or to shutdown squid and notes. Than

Oh well I thought 384MB should be enought for everyone aiming at this
performance (almost TM ;). At least it would up till now :(

> you may as well see a performance improvement compared to 2.2.18pre19
> (+raid+ide).  Otherwise you can push the machine low on memory a bit until they
> both goes totally into swap (check with `ps v`). Hope this helps.

I'll try this, thanks. (so no echo '1 23 456' >/proc/sys/vm/...?)

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
