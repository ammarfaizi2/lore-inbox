Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbRCBM0a>; Fri, 2 Mar 2001 07:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130422AbRCBM0K>; Fri, 2 Mar 2001 07:26:10 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:14350 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S130420AbRCBMZ4>;
	Fri, 2 Mar 2001 07:25:56 -0500
Date: Fri, 2 Mar 2001 13:26:15 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Oystein Viggen <oysteivi@tihlde.org>
cc: Pavel Machek <pavel@suse.cz>, Alexander Viro <viro@math.psu.edu>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <03ofvkcrcq.fsf@colargol.tihlde.hist.no>
Message-ID: <Pine.LNX.4.30.0103021313430.30991-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Mar 2001, Oystein Viggen wrote:
> Pavel Machek wrote:
> > xargs is very ugly. I want to rm 12*. Just plain "rm 12*". *Not* "find
> These you work around using the smarter, \0 terminated, version:

Another example demonstrating why xargs is not always good (and why a
bigger command line is needed) is when you combine it with e.g. wc:

	find . -type f -print0 | xargs -0 wc

You cannot trust the summary line from wc, since xargs may have decided to
run wc may times, and thus you have may summary lines.  If the kernel
would allow a larger command line, you could run

	wc `find . -type f`

and get exacly what you want.  And if I'm not mistaken, Linux accepts a
much smaller command line than other "unices" such as Solaris.

...but it's not _that_ important...  obviously there has to be an upper
limit somewhere...

/Tobias


