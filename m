Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTF2TOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTF2TOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:14:39 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:22408 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263285AbTF2TOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:14:36 -0400
Date: Sun, 29 Jun 2003 20:28:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Leonard Milcin Jr." <thervoy@post.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, mlmoser@comcast.net,
       john@grabjohn.com
Subject: Re: File System conversion -- ideas
Message-ID: <20030629192847.GB26258@mail.jlokier.co.uk>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EFEEF8F.7050607@post.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leonard Milcin Jr. wrote:
> I think that filesystem conversion on-the-fly is useless. Why? If you're
> making conversion of filesystem, you have to make good backup of data
> from that filesystem.

I disagree with this statement.

> It is likely that when something goes wrong during
> conversion (power loss) filesystem will be corrupted, and data will be
> lost.

Only if the converter stores a temporarily inconsistent state on the
filesystem.  Sometimes it is possible to write a converter where the
filesystem is in a consistent state throughout, except perhaps during
a critical transition from one filesystem type to the other.

> If you think the data is not worth to make backup - you don't have
> to convert it. Just delete worthless filesystem, and create new one.
> I
> the data is worth making backup, and finally you make it - you don't
> need to convert it.

You are discounting the existence of data which is valuable enough not
to have deleted already, yet which is not valuable enough to backup.
I'd count local mirrors in this category: backup is too expensive, yet
the cost of recreating the mirror is significant (days of
downloading), therefore worth keeping if possible.

Also MP3 & DIVX collections etc.  If you lose them it's not the end of
the world, but you'd rather not.

> You could just delete filesystem, and restore data
> from copy. If in turn one think the data is worth to protect it from
> loss, but he will not do it... he risks that the data will be lost, and
> he should not get access to such things.
     ^^^^^^

It may not be worth it to _you_, but to me the cost of spare disks is
significant enough that I choose to risk my less valuable data.  It's
my data hence my choice.

> I think that copying data to another filesystem, and restoring it to
> newly created  is most of the time best and fastest method of converting
> filesystems.

You are right that this diminishes the value of an in-place filesystem
converter (and defragmenter), because it is not necessary if you have
the foresight to use multiple partitions or LVM, and enough spare disk
space.q

However it would still be useful to some people, some of the time.

Consider that many people choose ext3 rather than reiser simply
because it is easy to convert ext2 to ext3, and hard to convert ext2
to reiser (and hard to convert back if they don't like it).  I have
seen this written by many people who choose to use ext3.  Thus proving
that there is value in in-place filesystem conversion :)

-- Jamie
