Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTEQR2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 13:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTEQR2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 13:28:10 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49576
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261702AbTEQR2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 13:28:10 -0400
Date: Sat, 17 May 2003 19:41:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: dak@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
Message-ID: <20030517174100.GT1429@dualathlon.random>
References: <x54r3tddhs.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x54r3tddhs.fsf@lola.goethe.zz>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 01:22:23PM +0200, David Kastrup wrote:
> 
> I have a problem with Emacs which crawls when used as a shell.  If I
> call M-x shell RET and then do something like
> hexdump -v /dev/null|dd count=100k bs=1

this certainly can't be it

andrea@dualathlon:~> hexdump -v /dev/null|dd count=100k bs=1
0+0 records in
0+0 records out
andrea@dualathlon:~> 

how can that run slow, there's nothing to hexdump in /dev/null and
nothing to read for dd?

One related hint, since you're playing with >4k buffers with dd, make
sure to run a -aa kernel with the lowlatency fixes (latest is
2.4.21rc2aa1), or those large writes can loop in the kernel forbid
preemption (in this case maybe not if they block in a socket/pipe before
100k is all written)

overall often people notices improvement with preempt becuse they
compare it with buggy kernels (I know this has nothing to do with your
report, but it's related to the above)

Andrea
