Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVITMWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVITMWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVITMWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:22:01 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:36113 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964990AbVITMWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:22:00 -0400
To: trond.myklebust@fys.uio.no
CC: smfrench@austin.rr.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1127218345.8413.32.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Tue, 20 Sep 2005 08:12:25 -0400)
Subject: Re: ctime set by truncate even if NOCMTIME requested
References: <432EFAB1.4080406@austin.rr.com>
	 <1127156303.8519.29.camel@lade.trondhjem.org>
	 <432F2684.4040300@austin.rr.com>
	 <1127165311.8519.39.camel@lade.trondhjem.org>
	 <432F5968.1020106@austin.rr.com>
	 <1127180199.26459.17.camel@lade.trondhjem.org>
	 <E1EHdrk-00014N-00@dorka.pomaz.szeredi.hu>
	 <E1EHf0E-000197-00@dorka.pomaz.szeredi.hu> <1127218345.8413.32.camel@lade.trondhjem.org>
Message-Id: <E1EHh6U-0001Hp-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Sep 2005 14:20:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ATTR_MTIME is _only_ set in utime[s], which all filesystems want to
> > honor.
> 
> ATTR_MTIME is set in both utimes and truncate.

Not in truncate:

int do_truncate(struct dentry *dentry, loff_t length)
{
	/* ... */

	newattrs.ia_size = length;
	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;

	down(&dentry->d_inode->i_sem);
	err = notify_change(dentry, &newattrs);
	up(&dentry->d_inode->i_sem);
	return err;
}

> As for ATTR_CTIME, that is also set in chown(), chmod(). It too can be
> optimised away for those operations, assuming that CIFS servers
> automatically update ctime.

Yes, I realized this shortly after posting.

Miklos
