Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbUKMOsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbUKMOsM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 09:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbUKMOsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 09:48:12 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:1765 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S262760AbUKMOsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 09:48:07 -0500
Date: Sat, 13 Nov 2004 15:47:43 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041113144743.GL20754@zaphods.net>
References: <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet> <20041110212818.GC25410@mail.muni.cz> <20041110181148.GA12867@logos.cnet> <20041111214435.GB29112@mail.muni.cz> <4194A7F9.5080503@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4194A7F9.5080503@cyberone.com.au>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 194.97.1.3
X-SA-Exim-Mail-From: zaphodb@boombox.zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 11:09:29PM +1100, Nick Piggin wrote:
> OK. Occasional page allocation failures are not a problem, although
> if it is an order-0 allocation it may be an idea to increase
> min_free_kbytes a bit more.
What about more than occasional but more like constant errors? ;)

> I think you said earlier that you had min_free_kbytes set to 8192?
> Well after applying my patch, the memory watermarks get squashed
> down, so you'd want to set it to at least 16384 afterward. Maybe
> more.
I took the default from 2.6.10-rc1-bk19 with your patch and doubled it. No
luck with the following values subsequently applied:
#vm.min_free_kbytes=3831
#vm.min_free_kbytes=7662
#vm.min_free_kbytes=15324
#vm.min_free_kbytes=61296
vm.min_free_kbytes=65535
Did not help against the page allocation errors or boosting up the machines
performance.

I got XFS filesystem corruption in the end which (just) perhaps was triggered by
page allocation errors for it says:
XFS internal error XFS_WANT_CORRUPTED_RETURN after several page allocation
errors for the application having XFS in its stack trace leading to:
kernel: xfs_force_shutdown(sdd5,0x8) called from line 1091 of file
        fs/xfs/xfs_trans.c.  Return address = 0xc0212e5c
kernel: Filesystem "sdd5": Corruption of in-memory data detected.
        Shutting down filesystem: sdd5
kernel: Please umount the filesystem, and rectify the problem(s)

Corruption of in-memory data sounds like something we would not want to
happen, right?

I attached full traces to http://oss.sgi.com/bugzilla/show_bug.cgi?id=345 which
is an rather old ticket dealing with page allocation errors and xfs but
perhaps it does fit.

	Stefan
