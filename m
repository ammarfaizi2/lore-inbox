Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSJINKj>; Wed, 9 Oct 2002 09:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSJINKj>; Wed, 9 Oct 2002 09:10:39 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:26383 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261616AbSJINKi>; Wed, 9 Oct 2002 09:10:38 -0400
Date: Wed, 9 Oct 2002 14:16:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luka Renko <luka.renko@hermes.si>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext 2/3
Message-ID: <20021009141617.B22105@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luka Renko <luka.renko@hermes.si>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <A1C30C1C0FB8D5118D810004754C03756677C5@hsl-lj3x.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <A1C30C1C0FB8D5118D810004754C03756677C5@hsl-lj3x.hermes.si>; from luka.renko@hermes.si on Wed, Oct 09, 2002 at 10:53:47AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 10:53:47AM +0200, Luka Renko wrote:
> Actually we are currently developing HSM application that stacks on top of
> standard file system (ext3 and XFS today) and we are using EA to store HSM
> specific information with each inode. However, we are not using registration
> API, but rather store this in user EA (even if we don't like some
> limitations of user EA), because registration API is not exported and
> registration API is per-FS and not generic. This would mean that we would
> need to have handlers defined for each supported filesystem (ext3 and XFS
> today, reiserfs and JFS in near future). As we use user EA, we just call VFS
> EA operations of the bottom FS (ext3 or XFS or any other FS that supports
> EA).

Yupp, that's exactly what I meant.

> I think that we could also then have only single ACL code for both ext2 and
> ext3 - currently ACL patch adds similar (same?) code to both ext2 and ext3
> and this code could be shared for sure.

And JFS and reiserfs.  Yes, this code should be in a library, but e.g.
XFS (different ondisk format) or NFSv4/NTFS/whatever need very different
ACL rountines.  You can't easily plug the handler into different filesystems
due to very different implementations below the VFS level.

BTW, do you have a pointer to your DSM system?  I'l like to look at something
less broken them dmapi..
