Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVCNQmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVCNQmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCNQmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:42:10 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:48598 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261583AbVCNQlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:41:40 -0500
Date: Mon, 14 Mar 2005 11:41:37 -0500
From: Andreas Dilger <adilger@shaw.ca>
To: Dan Stromberg <strombrg@dcs.nac.uci.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
Message-ID: <20050314164137.GC1451@schnapps.adilger.int>
Mail-Followup-To: Dan Stromberg <strombrg@dcs.nac.uci.edu>,
	linux-kernel@vger.kernel.org
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 09, 2005  10:53 -0800, Dan Stromberg wrote:
> The group I work in has been experimenting with GFS and Lustre, and I did
> some NBD/ENBD experimentation on my own, described at
> http://dcs.nac.uci.edu/~strombrg/nbd.html
> 
> My question is, what is the current status of huge filesystems - IE,
> filesystems that exceed 2 terabytes, and hopefully also exceeding 16
> terabytes?

Lustre has run with filesystems up to 400TB (where it hits a Lustre limit
that should be removed shortly for a 900TB filesystem being deployed).
The caveat is that Lustre is made up of individual block devices and
filesystems of only 2TB or less in size.

> Am I correct in assuming that the usual linux buffer cache only goes to 16
> terabytes?

That is the block device limit, and also the file limit for 32-bit systems,
imposed by the size of a single VM mapping 2^32 * PAGE_SIZE.

> Does the FUSE API (or similar) happen to allow surpassing either the 2T or
> 16T limits?

Some 32-bit systems (PPC?) may allow larger PAGE_SIZE and will have a
larger limit for a single VM mapping.  For 64-bit platforms there is no 
2^32 limit for page->index and this also removes the 16TB limit.

> What about the "LBD" patches - what limits are involved there, and have
> they been rolled into a Linus kernel, or one or more vendor kernels?

These are part of stock 2.6 kernels.  The caveat here is that there have
been some problems reported (with ext3 at least) for filesystems > 2TB
so I don't think it has really been tested very much.

Cheers, Andreas
--
Andreas Dilger
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/

