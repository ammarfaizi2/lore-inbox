Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTIWPln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 11:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbTIWPln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 11:41:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47744
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261337AbTIWPll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 11:41:41 -0400
Date: Tue, 23 Sep 2003 17:41:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jan Evert van Grootheest <j.grootheest@euronext.nl>
Cc: Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923154137.GA1265@velociraptor.random>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F706046.1000306@euronext.nl>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 05:01:26PM +0200, Jan Evert van Grootheest wrote:
> Andrea,
> 
> since you ask...
> I consider myself a not very typical Linux user in that I am a 
> programmer too and I (sometimes) write programs for Linux as well. And 
> yes, I do compile my own kernels.
> 
> I think it is pretty senseless to have a configuation option for the 
> default size of that buffer. Especially if I can, in one of the first rc 
> scripts, do something like 'echo 128 > /proc/sys/kernel/printkbuffer'.

having a sysctl can be an additional option (though it's tricky to
implement due the needed callbacks), but the problem I guess is that
most people needs a larger buf for the boot logs, so having only the
sysctl would be too late...

> The only hard requirement for that default size is that all output up 
> till that rc script fits into a buffer of that size.
> 
> And yes, I do care about that static 64K buffer. I still have an old 
> pentium that only has 16M. Every byte counts!

Note however that on the old 16M pentium it's unlikely that your boot
logs will overflow the current 64k, so for your pentium I doubt there
would be any need to use the feature. At least from my point of view the
feature is meant mainly for the high end, like 16/32-way HT with 64G of
ram etc.. where 64k hardly matters.

> On the other hand there are the really large systems with many CPUs and 
> such. Those might have problems with the small default. But, well, those 
> really could #ifdef a different default based on some configuration 
> options...

note the 64k are only wasted when you use the feature, there's nothing
wasted if you don't use it.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
