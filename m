Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVF1WuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVF1WuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVF1Wqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:46:32 -0400
Received: from waste.org ([216.27.176.166]:44774 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261231AbVF1WPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:15:33 -0400
Date: Tue, 28 Jun 2005 15:14:22 -0700
From: Matt Mackall <mpm@selenic.com>
To: Sean <seanlkml@sympatico.ca>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Petr Baudis <pasky@ucw.cz>,
       Christopher Li <hg@chrisli.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050628221422.GT12006@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org> <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com> <3886.10.10.10.24.1119991512.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3886.10.10.10.24.1119991512.squirrel@linux1>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 04:45:12PM -0400, Sean wrote:
> On Tue, June 28, 2005 4:27 pm, Kyle Moffett said:
> > On Jun 28, 2005, at 14:01:57, Matt Mackall wrote:
> >> Everything in Mercurial is an append-only log. A transaction journal
> >> records the original length of each log so that it can be restored on
> >> failure.
> >
> > Does this mean that (excepting the "undo" feature) one could set the
> > ext3 "append-only" attribute on the repository files to avoid losing
> > data due to user account compromise?
> >
> 
> Probably.  In Git, which is a bit more flexible than Mecurial you can
> chmod your objects to read-only or use the ext3 immutable setting to
> protect your existing objects.

You can do this in Mercurial as well.

> You can even have a setup where objects
> are archived onto write-once media like DVD and still participate in a
> live repository, where new objects are written to hard disk, but older
> object are (automatically) sourced from the DVD.

Have fun with that. It's an excellent way to destroy your DVD drive.

Git's completely structureless filename hashing pretty much guarantees
that disk layout will degrade to worst-case random access behavior
over time. Just walking through the 2000 commit blobs in the current
tree can take minutes cold cache on a fast hard disk. Walking the 1700
tree blobs in a given version takes quite a while too.

Put that on a DVD and that could easily turn into hours of continuous
seeking for a simple operation like checking out tip of tree.

And as far as I know, ISO9660 and UDF don't really handle huge
directories well. So if you try and put the whole kernel history (200k
files, some huge number of directory blobs, and 30k-60k commit blobs)
on a DVD, you'll be really hurting.

Meanwhile the whole history (>30k changesets) with Mercurial fits on a
regular CD, with reasonable directory sizes and I/O patterns.

Not that it's really worth the trouble. It takes longer for me to burn
an ISO image to disc than to download a complete kernel repo from
kernel.org.

-- 
Mathematics is the supreme nostalgia of our time.
