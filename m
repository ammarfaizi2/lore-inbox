Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTIWQXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIWQXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:23:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58752
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262001AbTIWQX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:23:28 -0400
Date: Tue, 23 Sep 2003 18:23:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jan Evert van Grootheest <j.grootheest@euronext.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923162319.GA1269@velociraptor.random>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl> <20030923160600.GA4161@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923160600.GA4161@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 06:06:00PM +0200, Willy Tarreau wrote:
> why do you want to force people to do something the way you think is best ?

because it gives you no real disavantage to pass the parameter in grub.
You've to set root=/dev/root anyways, this way you would simply need to
add the parameter for log buf as well. I've always to add lots of other
stuff anyways, including vga= profile= etc..

> I personnaly think that both solutions are a convenient way of achieving the
> same goal for different people. Please let them choose.

they can already choose with the parameter at boot, it's not that I
don't let them choose.

You simply want *two* different APIs, where one is worhtless and
obsoleted by the more powerful one.

That's why I think it's useless to have *two* APIs where one overlaps
on the other *completely*.

My API is good for everyone, yours is not, I don't see why we've to keep
both when nobody depends on yours yet.

> your patch is appealing, but it is not the only solution and does not cover
> all needs, nor does mine.

I can easily fix the 64k ram waste, after that I can't see why my API
can't cover you needs. The init code even gets released because it's
__init.

I just don't buy the fact that you don't like to pass params to the
kernel because you already do, you have to or it won't boot on a system
different than the one that you compiled the kernel.

If you don't like to pass buf_log_len= then how can you be ok to pass
root=/dev/root on all your thousand of lilo.conf in production? How can
root=/dev/root be remotely acceptable if buf_log_len= can't be as well
added to your thousand of distributed lilo.confs for your all images out
there? This makes no sense at all to me.

Yeah, I'm forcing you to waste a dozen bytes of disk space in
/etc/lilo.conf, you can definitely claim that, but I don't that as an
argument either (delete the spaces/tabs and you may save more). And
maybe thanks to this you won't run into the number of kernel images
limitation anymore.

I'm deinitely against worthless APIs in the kernel, when more powerful
one exists, and they give you zero disavantage (I will fix the 64k waste
don't worry, I definitely agree that such bit must be fixed to make
everyone happy).

As for decreasing the buf size, my option will allow you to decrease it
too after I fix it! While the shift only let you increase the buf size,
not decrease. So you should prefer the dynamic API too.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
