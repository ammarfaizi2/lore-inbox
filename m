Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWFSQCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWFSQCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWFSQCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:02:05 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:45897 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964778AbWFSQCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:02:04 -0400
Date: Mon, 19 Jun 2006 09:01:46 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Theodore Tso <tytso@thunk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619160146.GQ29684@ca-server1.us.oracle.com>
Mail-Followup-To: Theodore Tso <tytso@thunk.org>,
	linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619153109.817554000@candygram.thunk.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 11:20:08AM -0400, Theodore Tso wrote:
> Index: linux-2.6.17/fs/ocfs2/super.c
> ===================================================================
> --- linux-2.6.17.orig/fs/ocfs2/super.c	2006-06-18 19:37:14.000000000 -0400
> +++ linux-2.6.17/fs/ocfs2/super.c	2006-06-18 19:53:54.000000000 -0400
> @@ -1390,7 +1390,7 @@
>  	/* get some pseudo constants for clustersize bits */
>  	osb->s_clustersize_bits =
>  		le32_to_cpu(di->id2.i_super.s_clustersize_bits);
> -	osb->s_clustersize = 1 << osb->s_clustersize_bits;
> +	osb->s_blksize = osb->s_clustersize = 1 << osb->s_clustersize_bits;

	I assume you meant sb->s_blksize.  osb is a private structure
hanging off of sb->s_fs_info.
	I have to say, having sb->s_blocksize and sb->s_blksize might be
a little confusing.

Joel

-- 

"Heav'n hath no rage like love to hatred turn'd, nor Hell a fury,
 like a woman scorn'd."
        - William Congreve

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
