Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUBDAG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUBDAG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:06:28 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:41449 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266216AbUBDAG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:06:26 -0500
Date: Wed, 4 Feb 2004 01:06:23 +0100
From: David Weinehall <tao@acc.umu.se>
To: Christoph Hellwig <hch@infradead.org>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040204000623.GI15492@khan.acc.umu.se>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <bv8qr7$m2v$1@news.cistron.nl> <20040129063009.GD2474@frodo> <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040129063009.GD2474@frodo> <20040129232033.GA10541@cistron.nl> <20040204000315.A12127@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204000315.A12127@infradead.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 12:03:15AM +0000, Christoph Hellwig wrote:
> Okay, what about this little patch?:
> 
> 
> Index: fs/xfs/linux-2.6/xfs_iops.c
> ===================================================================
> RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_iops.c,v
> retrieving revision 1.212
> diff -u -p -r1.212 xfs_iops.c
> --- fs/xfs/linux-2.6/xfs_iops.c	12 Dec 2003 04:17:52 -0000	1.212
> +++ fs/xfs/linux-2.6/xfs_iops.c	3 Feb 2004 23:56:17 -0000
> @@ -80,11 +80,15 @@ validate_fields(
>  	vattr_t		va;
>  	int		error;
>  
> -	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS;
> +	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS|XFS_AT_SIZE;

Huh? XFS_AT_SIZE twice?!

[snip]


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
