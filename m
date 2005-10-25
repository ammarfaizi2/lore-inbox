Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbVJYEZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbVJYEZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 00:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVJYEZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 00:25:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30149 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751449AbVJYEZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 00:25:21 -0400
Date: Tue, 25 Oct 2005 05:25:19 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
Message-ID: <20051025042519.GJ7992@ftp.linux.org.uk>
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 06:55:19PM +0200, Miklos Szeredi wrote:
> This patch adds a statfs method to inode operations.  This is invoked
> whenever the dentry is available (not called from sys_ustat()) and the
> filesystem implements this method.  Otherwise the normal
> s_op->statfs() will be called.
> 
> This change is backward compatible, but calls to vfs_statfs() should
> be changed to vfs_dentry_statfs() whenever possible.

What the fuck for?  statfs() returns data that by definition should
not depend on inode within a filesystem.

NAK, and if FUSE needs that for something, it's *badly* misdesigned.
