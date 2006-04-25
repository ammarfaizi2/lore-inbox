Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWDYLFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWDYLFE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWDYLFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:05:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41404 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750777AbWDYLFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:05:02 -0400
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060425102628.GA26219@infradead.org>
References: <1145636030.3856.102.camel@quoit.chygwyn.com>
	 <20060423075525.GP6075@schatzie.adilger.int>
	 <1145886796.3856.161.camel@quoit.chygwyn.com>
	 <20060425102628.GA26219@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 25 Apr 2006 12:14:58 +0100
Message-Id: <1145963698.3856.193.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-04-25 at 11:26 +0100, Christoph Hellwig wrote:
> On Mon, Apr 24, 2006 at 02:53:16PM +0100, Steven Whitehouse wrote:
> > > Actually, the 0x0080000 flag has been reserved by e2fsprogs for ext3
> > > extents for a while already.  AFAICS, there are no other flags in the
> > > current e2fsprogs that aren't listed above.
> > > 
> > So if I call that one IFLAG_EXTENT, then I presume that will be ok?
> > What about the 0x00040000 flag? That would seem to be a gap in the
> > sequence (ignoring GFS flags for now), so should I leave that reserved
> > for use by ext2/3 as well?
> 
> note that at least reiserfs, jfs snd xfs seem to use additional flags aswell.
> It would be really helpful if we could get a linux/fflags.h that collects all
> of having them spread all over.  Anyone volunteering to create it?
> 
Thats basically what I was proposing with iflags.h, if you think it
would be better renamed to fflags.h and s/IFLAG/FFLAG/g then I'll do
that.

Perhaps I should "dig this out" from the GFS2 code and submit it as a
separate patch.... ?

XFS appears to support the immutable, append, no atime, no dump and sync
flags only, judging by the test in the xfs ioctl code, I don't see any
extra flags:

if (flags & ~(LINUX_XFLAG_IMMUTABLE | LINUX_XFLAG_APPEND | \
	      LINUX_XFLAG_NOATIME | LINUX_XFLAG_NODUMP | \                
 	      LINUX_XFLAG_SYNC)) {
                        error = -EOPNOTSUPP;
                        break;
              }

Reiserfs appears to use sync, immutable, no tail, append and no atime.

jfs uses No atime, dirsync, sync, secrm, unrm, append and immutable.

So far as I can tell my list already includes all the currently used
flags,

Steve.




