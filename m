Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWDXWUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWDXWUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWDXWUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:20:00 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:48818 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751163AbWDXWT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:19:59 -0400
Date: Mon, 24 Apr 2006 16:19:57 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
Message-ID: <20060424221957.GW6075@schatzie.adilger.int>
Mail-Followup-To: Steven Whitehouse <swhiteho@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1145636030.3856.102.camel@quoit.chygwyn.com> <20060423075525.GP6075@schatzie.adilger.int> <1145886796.3856.161.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145886796.3856.161.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2006  14:53 +0100, Steven Whitehouse wrote:
> On Sun, 2006-04-23 at 01:55 -0600, Andreas Dilger wrote:
> > > +++ b/include/linux/iflags.h
> > > @@ -0,0 +1,104 @@
> > > +#define IFLAG_TOPDIR		__IFL(TopDir)		/* 0x00020000 */
> > > +#define IFLAG_DIRECTIO		__IFL(DirectIO)		/* 0x00040000 */
> > > +#define IFLAG_INHERITDIRECTIO	__IFL(InheritDirectIO)	/* 0x00080000 */
> > > +#define IFLAG_INHERITJDATA	__IFL(InheritJdata)	/* 0x00100000 */
> > > +#define IFLAG_RESERVED		__IFL(Reserved)		/* 0x80000000 */
> > 
> > Actually, the 0x0080000 flag has been reserved by e2fsprogs for ext3
> > extents for a while already.  AFAICS, there are no other flags in the
> > current e2fsprogs that aren't listed above.
>
> So if I call that one IFLAG_EXTENT, then I presume that will be ok?
> What about the 0x00040000 flag? That would seem to be a gap in the
> sequence (ignoring GFS flags for now), so should I leave that reserved
> for use by ext2/3 as well?

To be honest, I don't know if 0x40000 is used or not.  It isn't in the
e2fsprogs version of ext2_fs.h.

> > The other tidbit is that new ext2/ext3 files generally inherit the flags
> > from their parent directory, so it isn't clear if there is really a need
> > for a distinction between DIRECTIO and INHERIT_DIRECTIO, and similarly
> > JDATA and INHERIT_JDATA?  Generally, I'd think that JDATA isn't meaningful
> > on directories (since they are metadata and journaled anyways), nor is
> > DIRECTIO so their only meaning on a directory is "INHERIT for new files".
> 
> Yes, that sounds like a good plan. The only downside (purely from a GFS2
> point of view, it won't affect anybody else) means that its no longer a
> 1:1 relationship between flags, so in order to do the conversion, I'd
> have to use something a little more elaborate than the inline function I
> added to the iflags.h header file,

Hmm, maybe I don't understand the GFS2 issue then?  Why not just use
IFLAG_JDATA on the directory and remove the use of IFLAG_INHERITJDATA
(equivalent) entirely from GFS2?  Does the implementation depend on a
distinction between these on a directory?

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

