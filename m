Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTL0Rk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 12:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTL0Rk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 12:40:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:29657 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264508AbTL0Rk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 12:40:56 -0500
Date: Sat, 27 Dec 2003 09:40:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean-Luc Fontaine <jfontain@free.fr>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
In-Reply-To: <3FED9A87.4020209@free.fr>
Message-ID: <Pine.LNX.4.58.0312270938130.14874@home.osdl.org>
References: <3FED9A87.4020209@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Dec 2003, Jean-Luc Fontaine wrote:
> 
> I solved the problem in a very strange way. Note that the (b) disk
> performance only improves after readahead has been increased on another
> (c) drive! (the (c) drive performance was also increased by to 2.4
> levels but is not shown here). I could reliably repeat this behavior
> after rebooting.
> 
> Can any IDE expert explain it?

Looks like a bug. If you don't access hdc, then the read-ahead on hdc 
shouldn't matter. I wonder if the read-ahead code (either the setting or 
the reading) gets the value from the wrong queue or something.

Jens? This could certainly explain some of the confusion about
performance.. Do you see anything strange?

			Linus

> # hdparm -t /dev/hdb
> ~ Timing buffered disk reads:   34 MB in  3.09 seconds =  11.02 MB/sec
> # hdparm -a 4096 /dev/hdb
> /dev/hdb: readahead = 4096 (on)
> # hdparm -t /dev/hdb
> ~ Timing buffered disk reads:   34 MB in  3.08 seconds =  11.04 MB/sec
> # hdparm -a 4096 /dev/hdc
> /dev/hdc: readahead = 4096 (on)
> # hdparm -t /dev/hdb
> ~ Timing buffered disk reads:   46 MB in  3.12 seconds =  14.76 MB/sec
