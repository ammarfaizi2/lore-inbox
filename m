Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTK3No0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 08:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTK3No0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 08:44:26 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263787AbTK3NoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 08:44:24 -0500
Date: Sun, 30 Nov 2003 13:48:56 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311301348.hAUDmuOd000169@81-2-122-30.bradfords.org.uk>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Clausen <clausen@gnu.org>,
       Apurva Mehta <apurva@gmx.net>, Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
In-Reply-To: <20031130112419.GA2920@iliana>
References: <20031128045854.GA1353@home.woodlands>
 <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org>
 <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
 <20031129123451.GA5372@win.tue.nl>
 <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
 <20031129223103.GB505@gnu.org>
 <1070182676.5214.2.camel@laptop.fenrus.com>
 <200311301040.hAUAePk6000149@81-2-122-30.bradfords.org.uk>
 <20031130112419.GA2920@iliana>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Sven Luther <sven.luther@wanadoo.fr>:
> On Sun, Nov 30, 2003 at 10:40:25AM +0000, John Bradford wrote:
> > * All partition information stored in one partition table
> > 
> > Linked lists make re-arranging partitions, and backing up the
> > partition table more difficult.
> 
> I don't agree here. You just follow the linked list and make the backup,
> which is one more reason for having the save/restore mechanism in the
> per partition table code, which knows how to read/write the partition
> table anyway. Also, mostly the linked list is found in a chunk of the
> disk which you can easily backup with dd. The amiga scheme has both
> information about the number of sectors which can be used in the linked
> list, as well as the last used sector.

I must admit, I haven't looked at every single partitioning scheme we
support in detail.

Also, my method of working may not be typical, in that I don't
generally partition all of the space on a disk, just because it's
there.  This came up on LKML a few months ago, in a discussion about
re-sizing filesystems in which I noted that the common case of wanting
to shrink a partition containing a filesytem with free space on it,
just to allow experimentation with a new filesystem, can be completely
avoided in many cases, simply by partitioning only the space you
expect to need from the begining.

Using the standard x86 partitioning system with large numbers of
extended partitions to do all this is not convenient.

I think that maybe I notice it more than most users because I
generally don't have the hassle of resizing partitions before I do
anything anyway.  Working with extended partitions might not seem like
much extra effort, but it is certainly less convenient and more
cumbersome than using primary partitions alone.

> Also, with a linked list, you can maintain two or more partition tables
> on disk, thus making an on-disk backup easy. When you write a new
> partition table, you write it on other sectors than the first one, and
> then update the root pointer. You can then later go back to the old
> partition table by just restoring the root pointer or something such.

I can see that linked-list partition tables have uses, but I think
that their disadvantages outweigh their advantages here - if some
partitioning data is stored at non-fixed locations on the disk,
overwriting a partition can destroy partitioning data for several
other partitions, whereas a dedicated area for partition data isn't
vulnerable to this.

> Also, it allow you flexibility with the amount of partitions you can
> use, as you could have potentially have any number of partitions you
> like (upto 2^30 or such).

Again, I can see that large numbers of partitions might have uses, but
in my experience 4 is a real limitation, whereas 8 or 16 wouldn't be.
Where, say > 128 partitions are needed, linked-lists are probably a
win, but my requirements are for a simple, reliable partitioning
scheme which supports large partitions, and allows us to completely
remove CHS code from the kernel.  I don't think we currently support
one.

John.
