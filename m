Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTL3TlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbTL3TlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:41:21 -0500
Received: from holomorphy.com ([199.26.172.102]:10435 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264271AbTL3TlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:41:19 -0500
Date: Tue, 30 Dec 2003 11:40:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Thomas Molina <tmolina@cablespeed.com>, Roger Luethi <rl@hellgate.ch>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230194051.GD22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andy Isaacson <adi@hexapodia.org>,
	Thomas Molina <tmolina@cablespeed.com>,
	Roger Luethi <rl@hellgate.ch>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain> <20031230132145.B32120@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230132145.B32120@hexapodia.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 08:37:53PM -0500, Thomas Molina wrote:
>> Right.  I have 120MB RAM and 256MB swap partition.  That corresponds to 
>> the 85 to 90 percent top says I am spending in iowait.

On Tue, Dec 30, 2003 at 01:21:45PM -0600, Andy Isaacson wrote:
> Yeah, right now BK needs about 140-160MB of working set to do a
> consistency check on the 2.5 tree.  That means you're paging, and it
> sounds like paging sucks on 2.6?
> (Actually, BK is even happier if the kernel can keep all the sfiles in
> cache, so a half-gig is a comfortable amount for working with the
> current 2.5 tree, although 256MB should be enough to avoid paging hell.
> With a full gig, you can keep two full trees in "checkout:get" mode in
> cache, which is nice.)

Well, it's not supposed to suck.

Something to try that affects paging directly would be adjusting
/proc/sys/vm/swappiness to, say, 0 and 100 and trying it at both levels.

More intelligent solutions require more instrumentation to address.

I generally recommend:
(1) logging top(1) running in batch mode
(2) logging vmstat(1)
(3) snapshotting /proc/meminfo
(4) snapshotting /prov/vmstat

I recommend an interval of 5s and logging with things like
top b d 5 > /tmp/top.log 2>&1 &
vmstat 5 > /tmp/vmstat.log 2>&1 &
(while true; do cat /proc/meminfo; sleep 5; done) > /tmp/meminfo.log 2>&1 &
(while true; do cat /proc/vmstat; sleep 5; done) > /tmp/proc_vmstat.log 2>&1 &

Thus far interpretations of information collected this way have been
somewhat lacking. Roger Luethi has identified various points at which
regressions happened over the course of 2.5, but it appears that
information hasn't yet been and still needs to be acted on.

If you could also try to identify points in time when the system has
become less responsive I'd be much obliged.


-- wli
