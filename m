Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbSJDREm>; Fri, 4 Oct 2002 13:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262560AbSJDREm>; Fri, 4 Oct 2002 13:04:42 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:10500 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262547AbSJDREl>; Fri, 4 Oct 2002 13:04:41 -0400
Date: Fri, 4 Oct 2002 18:10:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
Message-ID: <20021004181012.A4024@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <OF25D731E3.0E245DDC-ON85256C47.00645AA7@pok.ibm.com> <20021004151442.B30635@infradead.org> <20021004143402.GR3000@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004143402.GR3000@clusterfs.com>; from adilger@clusterfs.com on Fri, Oct 04, 2002 at 08:34:02AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 08:34:02AM -0600, Andreas Dilger wrote:
> On Oct 04, 2002  15:14 +0100, Christoph Hellwig wrote:
> > > the IOCTL entry point is used to send to volumes.
> > > the DIRECT_IOCTL entry point is used for point-
> > > to-point ioctls between corresponding user space
> > > and kernel space plugins.
> > 
> > Do the ioctl directly to the device node of the lower layer plugin instead.
> 
> Not possible - EVMS doesn't export the lower-level device nodes at all.
> That is one of the benefits - you can take 1000 drives and stack them
> and raid and LVM them all you want, and you don't consume 1000*layers
> device nodes.

I don't think it's a benefit but really ugly.  There is no reason to now
allow access to the lower layers.  How do I e.g. write a new volume label to
the lower level devices?

> Um, how about EXT3_I() and EXT3_SB(), or almost any filesystem in
> 2.5 which hides inode->u.generic_ip->foo_inode_info->blah?

That one actually provides a benfit as we have two different 24 and one 2.5 method
to access it.  I'm speaking about the wrappers for function pointer
invocations.  And yes, XFS has some massive macro abuse, but it's legacy
code that's not to easy to change while EVMS is new, from-the-scratch code that
should rather do it right.

