Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVHEJnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVHEJnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVHEJmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:42:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262932AbVHEJjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:39:41 -0400
Date: Fri, 5 Aug 2005 17:44:52 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050805094452.GD14880@redhat.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org> <20050805071415.GC14880@redhat.com> <1123227279.3239.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123227279.3239.1.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 09:34:38AM +0200, Arjan van de Ven wrote:
> On Fri, 2005-08-05 at 15:14 +0800, David Teigland wrote:
> > On Tue, Aug 02, 2005 at 09:45:24AM +0200, Arjan van de Ven wrote:
> > 
> > > * +static const uint32_t crc_32_tab[] = .....
> > > why do you duplicate this? The kernel has a perfectly good set of
> > > generic crc32 tables/functions just fine
> > 
> > The gfs2_disk_hash() function and the crc table on which it's based are a
> > part of gfs2_ondisk.h: the ondisk metadata specification.  This is a bit
> > unusual since gfs uses a hash table on-disk for its directory structure.
> > This header, including the hash function/table, must be included by user
> > space programs like fsck that want to decipher a fs, and any change to the
> > function or table would effectively make the fs corrupted.  Because of
> > this I think it's best for gfs to keep it's own copy as part of its ondisk
> > format spec.
> 
> for userspace there's libcrc32 as well. If it's *the* bog standard crc32
> I don't see a reason why your "spec" can't just reference that instead.
> And esp in the kernel you should just use the in kernel one not your own
> regardless; you can assume the in kernel one is optimized and it also
> keeps size down.

linux/lib/crc32table.h : crc32table_le[] is the same as our crc_32_tab[].
This looks like a standard that's not going to change, as you've said, so
including crc32table.h and getting rid of our own table would work fine.

Do we go a step beyond this and use say the crc32() function from
linux/crc32.h?  Is this _function_ as standard and unchanging as the table
of crcs?  In my tests it doesn't produce the same results as our
gfs2_disk_hash() function, even with both using the same crc table.  I
don't mind adopting a new function and just writing a user space
equivalent for the tools if it's a fixed standard.

Dave

