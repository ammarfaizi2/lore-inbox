Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVJUR5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVJUR5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVJUR5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:57:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40078 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965045AbVJUR5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:57:34 -0400
Date: Fri, 21 Oct 2005 18:57:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [RFC] page lock ordering and OCFS2
Message-ID: <20051021175730.GD22372@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Andreas Dilger <adilger@clusterfs.com>
References: <20051017222051.GA26414@tetsuo.zabbo.net> <20051017161744.7df90a67.akpm@osdl.org> <43544499.5010601@oracle.com> <435928BC.5000509@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435928BC.5000509@oracle.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 10:43:24AM -0700, Zach Brown wrote:
> It introduces block_read_full_page() and truncate_inode_pages() derivatives
> which understand the PG_fs_misc special case.  It needs a few export patches to
> the core, but the real burden is on OCFS2 to keep these derivatives up to date.

The way you do it looks nice, but the exports aren't a big no-way.  That
stuff is far too internal to be exported.  Either we can get Andrew to
agree on moving those bits into the codepath for all filesystems or
we need to do some hackery where every functions gets renamed to __function
with an argument int cluster_aware and we have to functions inling them,
one normal and one for cluster filesystems.

