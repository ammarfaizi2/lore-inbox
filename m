Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVJGOaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVJGOaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVJGOaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:30:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40876 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964872AbVJGOaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:30:17 -0400
Date: Fri, 7 Oct 2005 15:30:13 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't invalidate non-directory mountpoints
Message-ID: <20051007143012.GC7992@ftp.linux.org.uk>
References: <E1ENqAg-0004bJ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ENqAg-0004bJ-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 01:13:50PM +0200, Miklos Szeredi wrote:
> d_invalidate allowed a non-directory mountpoint to be invalidated,
> which is bad, since the mountpoint becomes unreachable.
> 
> I know it's racy wrt attaching/detaching mount, but AFAICS so is
> everything else that unhashes the dentry.  This seems to be an
> oversight when splitting out vfsmount_lock from dcache_lock.  To be
> fixed.

NAK.  That's a wrong way to deal with the problem and it's much older
than vfsmount_lock or dcache_lock (and affects directories too).
