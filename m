Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTIWOIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTIWOIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:08:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:2310 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S263361AbTIWOIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:08:00 -0400
Date: Tue, 23 Sep 2003 16:06:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923140647.GB3113@alpha.home.local>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923124951.GB23111@velociraptor.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,
 
> The point here is that the default must work for 99% of the userbase.
> Either that or the default is totally broken.

You're only thinking about what distro vendors should do. If all kernels should
suit their needs, then there would not be any config anymore, and everyone
would have the same kernel with the same wagon of command line arguments.

Lots of people actually do recompile their kernel to change a few options from
the vendor config, and that's the expected behaviour. And be it 1%, I consider
that 1% of Linux users are *lots* of people.

> And only this 1% would be the one recompiling the kernel
> by themself anyways, and if they can recompile the kernel they can as
> well edit the defaults in kernel/printk.c without pain.

I don't agree. That's what I did for a long time, and finally got bored of it.
Then I wrote a patch and proposed it. Randy Dunlap had one included in 2.6, and
Marcelo thought this one would be useful to lots of people, *exactly* because
it avoids what you describe here, ie. changins constants by hand.

> I don't buy much the lazyness argument in changing lilo.conf, the people
> who need this feature is a marginal part so they must be ok with the
> parmeter. And don't tell me that you don't pass root= to the kernel at
> boot. Do you want to fix that too? I do pass plenty of argumetns all the
> time, starting from profile=0 (and often acpi=off).

sorry, I don't agree with you on this. My lilo.conf contains "root=/dev/root"
and "boot=/dev/mbr" on nearly all my systems, just because it's easier ton
maintain, especially those which are patched remotely. You are speaking about
a developer's system, and I too have lots of crap on my desktop machines, and I
too am regularly annoyed because lilo tells me that 19 boot images is the max.
But on production systems, you need to avoid tricks, and even more when other
people manage the system after you install it.

> however I won't complain if you put the compile time configurator on top
> of my patch (that's easy) but personaly I think it's not needed, and
> having it dyanmic is an order of magnitude more important than having it
> static

I said I agree on the dynamic advantage. BTW, you didn't reply me about what
the statically allocated 64 kB became with your patch. Will this memory be
wasted forever or is there a way to free it ? If I want to pre-allocate it
dynamically with alloc_space() as you did, what can I use to free it ? is
kfree() the right thing ?

Cheers,
Willy

