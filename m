Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVKHPtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVKHPtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVKHPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:49:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:29918 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030217AbVKHPtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:49:06 -0500
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EZUC9-0007oJ-00@dorka.pomaz.szeredi.hu>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
	 <E1EZUC9-0007oJ-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1131464926.5400.234.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Nov 2005 07:48:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 06:11, Miklos Szeredi wrote:
> >  static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
> >  {
> > -	mnt->mnt_parent = mntget(nd->mnt);
> > -	mnt->mnt_mountpoint = dget(nd->dentry);
> > -	list_add(&mnt->mnt_hash, mount_hashtable + hash(nd->mnt, nd->dentry));
> > +	mnt_set_mountpoint(nd->mnt, nd->dentry, mnt);
> > +	list_add_tail(&mnt->mnt_hash, mount_hashtable +
> > +			hash(nd->mnt, nd->dentry));
> 
> Ram,
> 
> IIRC the list_add -> list_add_tail change has been voted down.  Or do
> you have new reasons why it's needed?

No. As explained in the same earlier threads; without this change the
behavior of shared-subtrees leads to inconsistency and confusion in some
scenarios.

Under the premise that no application should depend on this behavior
(most-recent-mount-visible v/s top-most-mount-visible),  Al Viro
permitted this change. And this is certainly the right behavior.

RP
> 
> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

