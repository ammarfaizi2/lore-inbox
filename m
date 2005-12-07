Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVLGBAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVLGBAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVLGBAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:00:07 -0500
Received: from pat.uio.no ([129.240.130.16]:2558 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964974AbVLGBAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:00:06 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20051206212416.GZ14509@schatzie.adilger.int>
References: <000301c5fa62$8d1bb730$4168010a@bsd.tnes.nec.co.jp>
	 <1133879435.8895.14.camel@kleikamp.austin.ibm.com>
	 <1133880516.9040.6.camel@lade.trondhjem.org>
	 <20051206212416.GZ14509@schatzie.adilger.int>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 19:59:44 -0500
Message-Id: <1133917184.8197.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.977, required 12,
	autolearn=disabled, AWL 1.84, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 14:24 -0700, Andreas Dilger wrote:
> On Dec 06, 2005  09:48 -0500, Trond Myklebust wrote:
> > On Tue, 2005-12-06 at 08:30 -0600, Dave Kleikamp wrote:
> > > I think it looks good.  The only issue I have is that I agree with
> > > Andreas that i_blocks should be of type sector_t.  I find the case of
> > > accessing very large files over nfs with CONFIG_LBD disabled to be very
> > > unlikely.
> > 
> > NO! sector_t is a block-device specific type. It does not belong in the
> > generic inode.
> 
> sector_t would imply "units of 512-byte sectors", and this is exactly
> what i_blocks is actually measuring, so I don't really understand your
> objection.

Strictly speaking, sector_t is a block offset that happens to be in
"units of 1<<inode->i_blkbits bytes". It is not a count of the number of
blocks in a file.

> If you have objection to the use of sector_t, it could be some other type
> that is defined virtually identically as CONFIG_LBD sector_t, except that
> it might be desirable to allow it to be configured separately for network
> filesystems that have large files.  I'm sure the embedded linux folks
> wouldn't be thrilled at an extra 4 bytes in every inode and 64-bit math
> if they don't really use it.

That would be fine.

Cheers,
  Trond

