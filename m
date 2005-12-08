Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVLHO1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVLHO1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVLHO1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:27:54 -0500
Received: from pat.uio.no ([129.240.130.16]:6551 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932152AbVLHO1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:27:52 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       "'Andreas Dilger'" <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <02ab01c5fbeb$faf7d740$4168010a@bsd.tnes.nec.co.jp>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
	 <1133963528.27373.4.camel@lade.trondhjem.org>
	 <1133967716.8910.5.camel@kleikamp.austin.ibm.com>
	 <1133969671.27373.47.camel@lade.trondhjem.org>
	 <1133973247.8907.33.camel@kleikamp.austin.ibm.com>
	 <02ab01c5fbeb$faf7d740$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 09:27:23 -0500
Message-Id: <1134052043.7998.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.004, required 12,
	autolearn=disabled, AWL 1.81, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 20:38 +0900, Takashi Sato wrote:

> I prefer sector_t for i_blocks rather than newly defined blkcnt_t.
> The reasons are:
> 
>   - Both i_blocks and common sector_t are for on-disk 512-byte unit.
>     In this point of view, they have the same character.

One is a count of the number of blocks used by a file, and exists only
in order to help filesystems cache this value. The other is a handle to
a block. How is that the same?

>   - If we created the type blkcnt_t newly, the patch would have to
>     touch a lot of files as follows, like sector_t does.
>         block/Kconfig, asm-i386/types.h, asm-x86_64/types.h,
>         asm-ppc/types.h, asm-s390/types.h, asm-sh/types.h,
>         asm-h8300/types.h, asm-mips/types.h
>     It will be simple if we use sector_t for i_blocks.

That is not a particularly good reason.

> Also, I cannot imagine the situation that > 2TB files are used over
> network with CONFIG_LBD disabled kernel.  Is there such a thing
> realistically?

Apart from this and the kstat wart, there is no reason to set CONFIG_LBD
for a networked filesystem. Why would you want to buy a > 2TB local disk
on an HPC cluster node if you already have a server?

I suppose we can make NFS use a private field instead, and just set
i_blocks to 0, but that's unnecessarily wasteful too.

Cheers,
  Trond

