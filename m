Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVHLL7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVHLL7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 07:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVHLL7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 07:59:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:30645 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751062AbVHLL7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 07:59:38 -0400
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems on x86_64 (fwd)
References: <Pine.LNX.4.58.0508110331360.3920@ppg_penguin.kenmoffat.uklinux.net.suse.lists.linux.kernel>
	<20050811152948.GH31019@csclub.uwaterloo.ca.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0508111905310.8504@ppg_penguin.kenmoffat.uklinux.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Aug 2005 13:59:37 +0200
In-Reply-To: <Pine.LNX.4.58.0508111905310.8504@ppg_penguin.kenmoffat.uklinux.net.suse.lists.linux.kernel>
Message-ID: <p73k6ir2wnq.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Moffat <ken@kenmoffat.uklinux.net> writes:

> On Thu, 11 Aug 2005, Lennart Sorensen wrote:
> 
> >
> > The kernel won't reread the partition table as long as ANY part of that
> > disk is mounted.  Reboot (which of course unmounts everything) to reread
> > the partition table.
> >
> 
>  OK, I've noted that now, thanks for the clue.

Actually it's a fdisk misfeature. There are two kinds of ioctls for
partition table rereading. One that rereads everything and fails if
any partitions on the disk are mounted.  And another kind that
adds/removes partitions explicitely. That works fine as long as you
don't touch the mounted partitions.

Unfortunately the only tool that seems to use the new kind is parted
but it has a nearly unusable awkward command line interface from hell, 
so fdisk is preferable even with the reboot requirement.

Ideally someone would fix fdisk to use the new kind.

Or just use LVM, it deals with all that much better.

-Andi
