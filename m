Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUBPTrh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265852AbUBPTrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:47:37 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:18561 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S265471AbUBPTrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:47:35 -0500
Date: Mon, 16 Feb 2004 20:48:57 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
In-Reply-To: <200402161758.i1GHwfek031651@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0402162041470.2449@neptune.local>
References: <1pvrI-8bq-29@gated-at.bofh.it> <1pvrI-8bq-31@gated-at.bofh.it>
 <1pvrJ-8bq-33@gated-at.bofh.it> <1pvrJ-8bq-35@gated-at.bofh.it>
 <1pvrJ-8bq-37@gated-at.bofh.it> <1pvrJ-8bq-39@gated-at.bofh.it>
 <1pvrJ-8bq-41@gated-at.bofh.it> <1pvrJ-8bq-43@gated-at.bofh.it>
 <1pTay-3hc-13@gated-at.bofh.it> <1pTay-3hc-15@gated-at.bofh.it>
 <1pTay-3hc-11@gated-at.bofh.it> <1pTu7-3Ce-7@gated-at.bofh.it>           
 <E1AsmW7-0000bV-DM@localhost> <200402161758.i1GHwfek031651@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 Valdis.Kletnieks@vt.edu wrote:

> Oh?
>
> % rm *
> % touch foo1 bar1    # this calls creat() or open() or similar
> % touch foo2 bar2	# as will this...
> % echo foo*	# and this will do a readdir(), presumably
>
> Do you have any expectations what the echo will do?  Obviously the glob
> DOES have a relationship with previous shell operations.

Yes, and? One may expect the echo to give "foo1 foo2", but that depends
on a lot of side effect, such as no other processing doing things in
the current directory. The same is true in a program - if you need
to know whether you could create a file, the only sane way is to use
creat() from an application and look at the return value. No other
method is meaningful - arbitrary things can happen between creating
a file and running readdir().

> The point is that *if* we assume that glibc is going to do some magic
> conversion when creating a file, we are assuming that glibc will
> *always* keep the conversion hidden. No matter what.  Because the user
> now has expectations of what that file was called when he created it -
> the string he passed to open()/creat().  If what gets handed to the
> kernel is something different, we have to make sure that the user never
> finds out about it.

That way lies madness, I agree. The sane thing (but breaks existing
applications) would be to reject any filename that is not valid
UTF-8, returning -EINVAL. I don't think *that* is going to happen,
though. ;)

-- 
Ciao,
Pascal
