Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbVLFVYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbVLFVYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVLFVYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:24:17 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:57000 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1030255AbVLFVYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:24:15 -0500
Date: Tue, 6 Dec 2005 14:24:16 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Message-ID: <20051206212416.GZ14509@schatzie.adilger.int>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Takashi Sato <sho@tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <000301c5fa62$8d1bb730$4168010a@bsd.tnes.nec.co.jp> <1133879435.8895.14.camel@kleikamp.austin.ibm.com> <1133880516.9040.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133880516.9040.6.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 06, 2005  09:48 -0500, Trond Myklebust wrote:
> On Tue, 2005-12-06 at 08:30 -0600, Dave Kleikamp wrote:
> > I think it looks good.  The only issue I have is that I agree with
> > Andreas that i_blocks should be of type sector_t.  I find the case of
> > accessing very large files over nfs with CONFIG_LBD disabled to be very
> > unlikely.
> 
> NO! sector_t is a block-device specific type. It does not belong in the
> generic inode.

sector_t would imply "units of 512-byte sectors", and this is exactly
what i_blocks is actually measuring, so I don't really understand your
objection.

If you have objection to the use of sector_t, it could be some other type
that is defined virtually identically as CONFIG_LBD sector_t, except that
it might be desirable to allow it to be configured separately for network
filesystems that have large files.  I'm sure the embedded linux folks
wouldn't be thrilled at an extra 4 bytes in every inode and 64-bit math
if they don't really use it.

Even in HPC very few users have many-TB files, and Lustre is one of the few
filesystems that can actually do this today.  We of course would enable
this option for our kernels, but I don't want to force it upon everyone.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

