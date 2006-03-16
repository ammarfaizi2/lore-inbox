Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWCPSf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWCPSf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWCPSf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:35:56 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:12209 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932707AbWCPSfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:35:55 -0500
Date: Thu, 16 Mar 2006 11:35:49 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060316183549.GK30801@schatzie.adilger.int>
Mail-Followup-To: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	cmm@us.ibm.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 16, 2006  21:11 +0900, Takashi Sato wrote:
> >Also, I noticed that in your first patch, you changed a few variables
> >for logical block number from "long" to "unsigned int". Just want to
> >point out that's a seperate issue- that's for enlarge the file size, not
> >for expand the max filesystem size.
> 
> Ok, I'll remove them when I update the patch next time.
> They are left because I'm considering enlarging the file size max too...

There was previously a patch by Goldwyn Rodrigues in linux-kernel:
"[PATCH] Pushing ext3 file size limits beyond 2TB", which at least
got as far as 4TB for the file size (for 4kB blocks).

Beyond that, we need a format change and may as well have something
like extents, but even extents still need to allow a larger i_blocks,
so that patch would be useful in any case...  though it needs some
cleanup to remove all users of i_frag and i_faddr (which have never
ever been used).

Laurent, do your 64-bit patches include support for larger i_blocks?

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

