Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVJGOix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVJGOix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVJGOix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:38:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56244 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030215AbVJGOiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:38:52 -0400
Date: Fri, 7 Oct 2005 15:38:50 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: don't drop dentry in d_revalidate
Message-ID: <20051007143850.GD7992@ftp.linux.org.uk>
References: <E1ENqHd-0004cW-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ENqHd-0004cW-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 01:21:01PM +0200, Miklos Szeredi wrote:
> NFS d_revalidate() is doing things that are supposed to be done by
> d_invalidate().
> 
> Dropping the dentry is especially bad, since it will make
> d_invalidate() bypass all checks.

NAK.  _IF_ you are going to start playing with that area, start with
handling that stuff in caller before going after methods.

Note that the only relatively sane semantics is to have equivalent on
umount -l done to everything that becomes unreachable.
