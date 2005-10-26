Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVJZTSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVJZTSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVJZTSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:18:10 -0400
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:36103 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964861AbVJZTSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:18:08 -0400
To: bulb@ucw.cz
CC: viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20051026173150.GB11769@efreet.light.src> (message from Jan Hudec
	on Wed, 26 Oct 2005 19:31:50 +0200)
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu> <20051025042519.GJ7992@ftp.linux.org.uk> <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu> <20051026173150.GB11769@efreet.light.src>
Message-Id: <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Oct 2005 21:17:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > This patch adds a statfs method to inode operations.  This is invoked
> > > > whenever the dentry is available (not called from sys_ustat()) and the
> > > > filesystem implements this method.  Otherwise the normal
> > > > s_op->statfs() will be called.
> > > > 
> > > > This change is backward compatible, but calls to vfs_statfs() should
> > > > be changed to vfs_dentry_statfs() whenever possible.
> > > 
> > > What the fuck for?  statfs() returns data that by definition should
> > > not depend on inode within a filesystem.
> > 
> > Exactly.  But it's specified nowhere that there has to be a one-one
> > mapping between remote filesystem - local filesystem.
> 
> Unfortunately making statfs alone aware of them does not help. Most useful
> tools that use statfs go to /proc/mouts, read all the entries and invoke
> statfs for each path. So if for some non-root path different values are
> returned, these tools won't see them anyway. So try to think about how to
> provide the info about subfilesystems first.

'df .': tried it and it did not do what was expected, but that can
definitely be fixed

'stat -f .': actually works

foo-filemanager: before copying a file or directory tree, checks for
free space in destination directory

None of the above examples need (and use) /etc/mtab or /proc/mounts.

Just because the info is not available about the placement of the
subfilesystems, doesn't mean that the subfilesystems don't actually
exist.

Miklos
