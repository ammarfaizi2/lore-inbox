Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWFSWNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWFSWNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWFSWNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:13:21 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:64886 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964947AbWFSWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:13:20 -0400
Date: Mon, 19 Jun 2006 15:13:09 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Theodore Tso <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619221309.GI3082@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619155821.GA27867@infradead.org> <20060619161651.GS29684@ca-server1.us.oracle.com> <20060619172014.GD15216@thunk.org> <20060619185555.GA15389@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619185555.GA15389@infradead.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 07:55:55PM +0100, Christoph Hellwig wrote:
> And to answer Joel's statment of these three two already implement their
> own ->getattr.  Also it doesn't mean a filesystem has to completely
> reimplement it, they just have to override it by reusing generic_fillattr,
> e.g.
And actually, that's what we do in ocfs2_getattr() today already:

	generic_fillattr(inode, stat);

	/* We set the blksize from the cluster size for performance */
	stat->blksize = osb->s_clustersize;

Thanks,
	--Mark
--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
